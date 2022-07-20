// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, avoid_types_as_parameter_names, unused_local_variable, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:js';

import 'package:first/shared/components/components.dart';
import 'package:first/shared/components/constants.dart';
import 'package:first/shared/cubit/cubit.dart';
import 'package:first/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  AppCubit cubit = AppCubit.get(context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[currentIndex]),
            ),
            body: true
                ? cubit.screens[cubitcurrentIndex]
                : Center(child: CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    ).then((value) {
                      getDataFromDatabase(database).then((value) {
                        Navigator.pop(context);
                        // setState(() {
                        //   tasks = value;
                        //   fabIcon = Icons.edit;
                        //   isBottomSheetShown = false;
                        // });
                      });
                    });
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet((context) => Container(
                            color: Colors.grey[100],
                            padding: EdgeInsets.all(20),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFormField(
                                      controller: titleController,
                                      type: TextInputType.text,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "title must not be empty";
                                        }
                                        return null;
                                      },
                                      lable: "Task Title",
                                      prefix: Icons.title),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  defaultFormField(
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                        print(value.format(context));
                                      });
                                    },
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return "time must not be empty";
                                      }
                                      return null;
                                    },
                                    lable: "Task Time",
                                    prefix: Icons.watch_later_outlined,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  defaultFormField(
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2022-7-30'))
                                          .then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return "date must not be empty";
                                      }
                                      return null;
                                    },
                                    lable: "Task Date",
                                    prefix: Icons.calendar_today,
                                  )
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    isBottomSheetShown = false;
                    // setState(() {
                    //   fabIcon = Icons.edit;
                    // });
                  });
                  isBottomSheetShown = true;
                  // setState(() {
                  //   fabIcon = Icons.add;
                  // });
                }
              },
              child: Icon(fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.currentIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Tasks"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: "Done"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: "Archive"),
                ]),
          );
        },
      ),
    );
  }

  Future<String> getname() async {
    return "volt";
  }

  void createDatabase() async {
    database = await openDatabase("todo.db", version: 1,
        onCreate: (database, version) {
      print("database created");

      database
          .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print("table created");
      }).catchError((error) {
        print("error when creating table ${error.toString()} ");
      });
    }, onOpen: (database) {
      print("database opened");
      print(tasks);
    });
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) {
      return txn
          .rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")', //sensetave fsh5555555
      )
          .then((value) {
        print(" $value inserted successfully");
      }).catchError((error) {
        print("error when insearting new record ${error.toString()} ");
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
