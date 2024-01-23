// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'apii/api_bloc.dart';
import 'circular_persent_indicator.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Integration with BLoC',
      home: BlocProvider(
        create: (context) => ApiBloc(),
        child: MyHomePage(),
      ),
    );
  }
}
// Modify your StatefulWidget to use BlocConsumer
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Integration with BLoC'),
      ),
      body: BlocConsumer<ApiBloc, ApiState>(
        listener: (context, state) {
          // Add any listeners if needed
        },
        builder: (context, state) {
          if (state is ApiInitialState) {
            return Center(child: Text('Press the button to fetch data.'));
          } else if (state is ApiLoadingState) {
            return Center(
              child: CircularPercentIndicator(
                radius: 45.0,
                lineWidth: 4.0,
                animation: true,
                animationDuration: 1200,
                percent: state.progress / 100,
                center: Text("${state.progress}%"),
                progressColor: Colors.green,
              ),
            );
          } else if (state is ApiSuccessState) {
            final List<dynamic> data = state.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]['title']),
                );
              },
            );
          } else if (state is ApiErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ApiBloc>().add(FetchDataEvent());
        },
        tooltip: 'Fetch Data',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
