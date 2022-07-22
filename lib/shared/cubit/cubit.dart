// ignore_for_file: avoid_print

import 'package:first/moduels/archived_tasks/archived_tasks_screen.dart';
import 'package:first/moduels/done_tasks/done_tasks_screen.dart';
import 'package:first/moduels/new_tasks/new_tasks_screen.dart';
import 'package:first/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitalState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = ['Tasks', "Done Tasks", "Archived Tasks"];

  late Database database;

  List<Map> tasks = [];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase("todo.db", version: 1, onCreate: (database, version) {
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
      getDataFromDatabase(database).then(
        (value) {
          tasks = value;
          print(tasks);
          emit(AppGetDatabaseState());
        },
      );

      print("database opened");
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")', //sensetave fsh5555555
      )
          .then((value) {
        print(" $value inserted successfully");
        emit(AppInsertDatabaseState());
        // b3d m 3mal insert bystore el gded & print & emit
        getDataFromDatabase(database).then(
          (value) {
            tasks = value;
            print(tasks);
            emit(AppGetDatabaseState());
          },
        );
      }).catchError((error) {
        print("error when insearting new record ${error.toString()} ");
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    // emit(AppGetDatabaseLoadingState());
    return await database.rawQuery('SELECT * FROM tasks');
  }

  void updateDatabase({
    required String? status,
    required int? id,
  }) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      emit(AppUpdateDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
