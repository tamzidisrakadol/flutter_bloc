import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b_sm/SampleExample/bloc/ImagePickerBloc/image_picker_bloc.dart';
import 'package:flutter_b_sm/SampleExample/bloc/counterBloc/CounterEvent.dart';
import 'package:flutter_b_sm/SampleExample/bloc/SliderBloc/slider_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/counterBloc/CounterBloc.dart';
import '../bloc/counterBloc/CounterState.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final counterBloc = context.read<CounterBloc>();
    final switchBloc = context.read<SliderBloc>();
    final imageBloc = context.read<ImagePickerBloc>();

    return Scaffold(
      appBar: AppBar(title: Text("Sample Bloc Example")),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                Text(state.count.toString(), style: TextStyle(fontSize: 32)),

                BlocBuilder<SliderBloc, SliderInitial>(
                  builder: (context, state) {
                    return Container(
                      height: 200,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(state.sliderValue),
                      ),
                    );
                  },
                ),

                BlocBuilder<SliderBloc, SliderInitial>(
                  builder: (context, state) {
                    return Slider(
                      value: state.sliderValue,
                      onChanged: (newValue) {
                        switchBloc.add(SliderValueChanged(newValue));
                      },
                    );
                  },
                ),

                BlocBuilder<ImagePickerBloc,ImagePickerState>(builder: (context,state){
                  if(state is ImageInitial){
                    return ElevatedButton(onPressed: (){
                      imageBloc.add(CaptureImage());
                    }, child: Text("Pick Images"));
                  }else if(state is ImagePickedSuccess){
                    return CircleAvatar(
                      radius: 50,
                      child: Image.file(File(state.image.path))
                    );
                  }else{
                    return Text("Something went wrong");
                  }
                })


              ],
            ),
          );
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
