import 'package:equatable/equatable.dart';
import 'package:torath/models/filters/get_all_places_times_response.dart';

abstract class GetAllPlacesState extends Equatable {
  const GetAllPlacesState();
}

class GetAllPlacesInitialState extends GetAllPlacesState {
  @override
  List<Object> get props => [];
}

class GetAllPlacesLoadingState extends GetAllPlacesState {
  @override
  List<Object> get props => [];
}

class GetAllPlacesSuccessState extends GetAllPlacesState {
  GetAllPlacesTimesResponse response;

  GetAllPlacesSuccessState(this.response);

  @override
  List<Object> get props => [];
}

class GetAllPlacesErrorState extends GetAllPlacesState {
  String message;

  GetAllPlacesErrorState(this.message);

  @override
  List<Object> get props => [];
}
