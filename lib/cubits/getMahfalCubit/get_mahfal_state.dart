import 'package:equatable/equatable.dart';
import 'package:torath/models/getMahfal/get_mahfal_response.dart';

abstract class GetMahfalState extends Equatable {
  const GetMahfalState();
}

class GetMahfalInitialState extends GetMahfalState {
  @override
  List<Object> get props => [];
}

class GetMahfalLoadingState extends GetMahfalState {
  @override
  List<Object> get props => [];
}

class GetMahfalSuccessState extends GetMahfalState {
  GetMahfalResponse response;

  GetMahfalSuccessState(this.response);

  @override
  List<Object> get props => [];
}

class GetMahfalErrorState extends GetMahfalState {
  String message;

  GetMahfalErrorState(this.message);

  @override
  List<Object> get props => [];
}
