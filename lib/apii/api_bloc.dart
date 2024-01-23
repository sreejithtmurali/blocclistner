

import 'dart:convert';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'api_event.dart';
part 'api_state.dart';
// BLoC// BLoC
class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/todos';

  ApiBloc() : super(ApiInitialState()) {
    // Register event handler for FetchDataEvent
    on<FetchDataEvent>((event, emit) async {
      emit(ApiLoadingState(progress: 0, color:Colors.blue ));

      try {
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);
          emit(ApiSuccessState(data));
        } else {
          emit(ApiErrorState('Failed to fetch data'));
        }
      } catch (e) {
        emit(ApiErrorState('Network error'));
      }
    });
  }
}