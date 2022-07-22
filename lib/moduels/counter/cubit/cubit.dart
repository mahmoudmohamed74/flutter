import 'package:first/moduels/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1 b3ml parent class  ha form mnh states bt3ty => states.dart
// 2 create cubit"bloc"
//        * create super
//       ** make object mnh for easy use in all app
//       *** methods bt3ty "logic"

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitalState());
  //method for using object in all app ***imp***
  static CounterCubit get(context) => BlocProvider.of(context);
  int counter = 1;

  void minus() {
    counter--;
    emit(CounterMinusState(counter));
  }

  void plus() {
    counter++;
    emit(CounterPlusState(counter));
  }
}
