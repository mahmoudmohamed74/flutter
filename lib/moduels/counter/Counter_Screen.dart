// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, avoid_print, must_be_immutable

//idea of statefull widget
import 'package:first/moduels/counter/cubit/cubit.dart';
import 'package:first/moduels/counter/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1 build BlocProvider
// 2 create el cubit
// 3 make consumer
//      * listener
//      ** builder => scafold bt3k

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if (state is CounterPlusState) {
            print("Plus State ${state.counter}");
          }
          if (state is CounterMinusState) {
            print("Minus State ${state.counter}");
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("counter"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: Text("MINUS")),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      "${CounterCubit.get(context).counter}",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: Text("PLUS")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
