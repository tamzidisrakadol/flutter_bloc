import 'package:flutter/material.dart';
import 'package:flutter_b_sm/SampleExample/UI/CounterPage.dart';
import 'package:flutter_b_sm/SampleExample/bloc/slider_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'SampleExample/bloc/CounterBloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CounterBloc()),
          BlocProvider(create: (context) => SliderBloc()),
        ],
        child: const CounterPage(),
      ),
    );
  }
}
