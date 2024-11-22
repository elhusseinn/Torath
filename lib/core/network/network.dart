import 'dart:convert';
import 'dart:io';


import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:torath/core/utils/properties.dart';

import '../error/exceptions.dart';
import '../utils/enums.dart';
import '../utils/preference_manager.dart';
import 'network_client.dart';
import 'network_response.dart';
import 'package:http/http.dart' as http;

abstract class INetwork {
  Future<Map<String, dynamic>> get(
    String url, {
    bool auth = true,
    bool visitor = false,
  });

  Future<Map<String, dynamic>> post(String url,
      {dynamic data,
      dynamic queryParams,
      bool auth = true,
      bool visitor = false,
      bool isExternal = false,
      Map<String, String>? headers});
  Future<Map<String, dynamic>> put(String url,
      {dynamic data, bool auth = true, bool visitor = false});
}

class Network implements INetwork {
  INetworkClient networkClient;
  String? refreshToken;
  late String baseUrl;

  RetrialRequest? oldRequest;

  Network({required this.networkClient}) {
    baseUrl = Properties.baseUrl;
  }
  int trailsCounter = 0;
  void saveGetRequest(String url) {
    oldRequest = null;
    oldRequest ??= RetrialRequest(method: RequestType.get, url: url);
    if (kDebugMode) {
      // loggy.info("save request : " + oldRequest.toString());
    }
  }

  void savePostRequest(String url, dynamic data) {
    if (kDebugMode) {
      print("-------- url is $url and body is  ${data.toString()}");
    }
    oldRequest = null;
    oldRequest ??=
        RetrialRequest(method: RequestType.post, url: url, data: data);

    // if (oldRequest!.counter > 1) {
    //   oldRequest = null;
    // }
  }

  void savePutRequest(String url, dynamic data) {
    oldRequest = null;
    oldRequest ??=
        RetrialRequest(method: RequestType.put, url: url, data: data);

    // if (RetrialRequest.counter > 1) {
    //   oldRequest = null;
    // }
  }

  void disposeOldRequest() {
    trailsCounter = 0;
    oldRequest = null;
  }

  Future<Map<String, dynamic>> retryRequest({bool isHttp = false}) async {
    if (kDebugMode) {
      // loggy.info("retry refresh token");
    }

    if (oldRequest != null) {
      if (oldRequest!.method == RequestType.post) {
        if (isHttp) {
          return post(oldRequest!.url, data: oldRequest!.data);
        }
      } else {
        return get(oldRequest!.url);
      }
    }
    disposeOldRequest();
    throw UnAuthorizedException();
  }

  Future<bool> simpleGet(String url) async {
    NetworkResposne response;
    try {
      response = await networkClient.get(url);
      if (response.statusCode == 200) return true;
    } catch (e) {
      return false;
    }
    return false;
  }

  @override
  Future<Map<String, dynamic>> get(String url,
      {bool auth = true,
      bool visitor = false,
      bool isExtrnal = false,
      bool isFile = false,
      Map<String, String>? params,
      Map<String, String>? otherHeaders,
      bool isFullUrl = false}) async {
    if (kDebugMode) {
      print("------ request url $url");
      //  print("------ request body is $data");
    }
    print(url);
    saveGetRequest(url);

    final response = await networkClient.get(isFullUrl ? url : (baseUrl + url),
        headers: await getHeaders(auth, visitor, otherHeaders), params: params);

    return getResponse(response);
  }

  @override
  Future<Map<String, dynamic>> post(String url,
      {dynamic data,
      dynamic queryParams,
      bool auth = true,
      bool visitor = false,
      bool isExternal = false,
      Map<String, String>? headers}) async {
    if (kDebugMode) {
      print("------ request url ${baseUrl+url}");
      print("------ request body is $data");
    }
    savePostRequest(url, data);
    if (queryParams != null) {
      final response = await networkClient.post(
        baseUrl + url,
        data: data,
        headers: await getHeaders(auth, visitor, headers),
        queryParam: queryParams,
      );
      return getResponse(response);
    } else {
      final response = await networkClient.post(
        url,
        data: data,
        headers: await getHeaders(auth, visitor, headers),
      );
      return getResponse(response);
    }
  }

  @override
  Future<Map<String, dynamic>> put(String url,
      {dynamic data, bool auth = true, bool visitor = false}) async {
    savePutRequest(url, data);
    final response = await networkClient.put(
      baseUrl + url,
      data: data,
      headers: await getHeaders(auth, visitor, null),
    );

    return getResponse(response);
  }

  Future<Map<String, dynamic>> getResponseFromStreamedResponse(
      http.StreamedResponse response) async {
    if (kDebugMode) {
      print("------ the status code is : ${response.statusCode}");
    }
    String jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      disposeOldRequest();
      return json.decode(jsonString);
    }
    if (response.statusCode == 401) {
      if (kDebugMode) {
        print(
            "-------- other status code  status code is : ${response.statusCode}");
        print(
            "-------- other status code response is ${json.decode(jsonString)}");
      }
      throw UnAuthorizedException();
    }
    if (oldRequest != null && trailsCounter == 0) {
      return retryRequest(isHttp: true);
    }
    throw const ServerException("something went wrong");
  }

  Future<Map<String, dynamic>> getResponse(NetworkResposne response) async {
    //final responseData = json.decode(utf8.decode(response.data));
    if (kDebugMode) {
      print("------ the status code is : ${response.statusCode}");
    }
    if (response.statusCode == 200) {
      disposeOldRequest();

      return {"data":response.data};
    } else if (response.statusCode == 401) {
      if (refreshToken == null || refreshToken == "") {
        if (response.data == "TOKEN_IS_REQUIRED" ||
            response.data == "INVALID_TOKEN") {
          throw UnAuthorizedException();
        }
        throw ServerException(response.data["message"]);
      }
      return retryRequest();

      //throw UnAuthorizedException();
    } else {
      // disposeOldRequest();
      if (kDebugMode) {
        print(
            "-------- other status code  status code is : ${response.statusCode}");
        print("-------- other status code ${response.data}");
      }
      throw const ServerException("something went wrong");
    }
  }

  Future<Map<String, dynamic>> getHeaders(
      bool auth, bool visitor, Map<String, String>? otherHeaders) async {
    Map<String, dynamic> headers = {};
    PreferenceManager preferenceManager = PreferenceManager();
    String? token = Properties.supaBaseBearerToken;
    headers.addAll({
      "Content-Type": "application/json; charset=Utf-8",
      "accept": "*/*",
      "Accept-Encoding": "application/json; charset=Utf-8",
      HttpHeaders.authorizationHeader: "Bearer $token",
      "apiKey": token,
    });
    if (otherHeaders != null) {
      headers.addAll(otherHeaders);
    }

    return headers;
  }

  @override
  Future<Map<String, dynamic>> getAccessToken(String refreshToken) {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }
}

class RetrialRequest extends Equatable {
  int counter = 0;
  RequestType method;
  String url;
  dynamic data;
  RetrialRequest({
    required this.method,
    required this.url,
    this.data,
  }) {
    counter++;
  }

  @override
  List<Object?> get props => [counter, method, url, data];
}
