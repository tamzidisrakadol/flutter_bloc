import 'package:flutter_b_sm/SampleExample/bloc/CounterEvent.dart';
import 'package:flutter_b_sm/SampleExample/bloc/CounterState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CounterBloc extends Bloc<CounterEvent,CounterState>{
  CounterBloc():super(CounterState(0)){
    on<CounterIncrement>((event, emit){
      emit(CounterState(state.count+1));
    });
    on<CounterDecrement>((event, emit){
      emit(CounterState(state.count-1));
    });
  }

}