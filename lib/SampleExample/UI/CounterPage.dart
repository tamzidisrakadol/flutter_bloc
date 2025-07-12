import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b_sm/SampleExample/bloc/CounterEvent.dart';
import 'package:flutter_b_sm/SampleExample/bloc/CounterState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/CounterBloc.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final counterBloc = context.read<CounterBloc>();

    return Scaffold(
      appBar: AppBar(title: Text("Sample Bloc Example")),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Center(child: Text(state.count.toString(),style: TextStyle(fontSize: 32),));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterBloc.add(CounterDecrement());
        },
        child: Icon(Icons.plus_one),
      ),
    );
  }
}
