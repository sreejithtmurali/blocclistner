part of 'api_bloc.dart';
abstract class ApiState extends Equatable {
  @override
  List<Object> get props => [];
}

class ApiInitialState extends ApiState {}

class ApiLoadingState extends ApiState {
  final int progress;
  final Color color;

  ApiLoadingState({required this.progress, required this.color});

  @override
  List<Object> get props => [progress, color];
}

class ApiSuccessState extends ApiState {
  final List<dynamic> data;

  ApiSuccessState(this.data);

  @override
  List<Object> get props => [data];
}

class ApiErrorState extends ApiState {
  final String errorMessage;

  ApiErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}