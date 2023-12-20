import 'package:equatable/equatable.dart';

class NetworkResposne<T> extends Equatable {
  T? data;

  int? statusCode;

  NetworkResposne({
    this.data,
    this.statusCode,
  });

  NetworkResposne<T> copyWith({
    T? data,
    int? statusCode,
  }) {
    return NetworkResposne<T>(
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [data, statusCode];
}
