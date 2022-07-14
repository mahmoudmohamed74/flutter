// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_string_interpolations

import 'package:first/models/user/user_model.dart';
import 'package:flutter/material.dart';
// create class to riceve data from database
// instructor to re use data

class UsersScreen extends StatelessWidget {
  // list to store data
  List<UserModel> users = [
    UserModel(id: 1, name: "Mahmoud Mohamed", phone: "+201091402997"),
    UserModel(id: 2, name: "Mahmoud Mo", phone: "+201091402997"),
    UserModel(id: 3, name: "Mahmoud volt", phone: "+201091402997"),
    UserModel(id: 4, name: "Mahmoud ", phone: "+201091402997"),
    UserModel(id: 1, name: "Mahmoud Mohamed", phone: "+201091402997"),
    UserModel(id: 2, name: "Mahmoud Mo", phone: "+201091402997"),
    UserModel(id: 3, name: "Mahmoud volt", phone: "+201091402997"),
    UserModel(id: 4, name: "Mahmoud ", phone: "+201091402997"),
    UserModel(id: 1, name: "Mahmoud Mohamed", phone: "+201091402997"),
    UserModel(id: 2, name: "Mahmoud Mo", phone: "+201091402997"),
    UserModel(id: 3, name: "Mahmoud volt", phone: "+201091402997"),
    UserModel(id: 4, name: "Mahmoud ", phone: "+201091402997"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) =>
              buildUserItem(users[index]), //الانديكس بتاع الداتا
          separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
          itemCount: users.length //show list length (number of elements shown)
          ),
    );
  }

// store model bt3ak f datatype zayh
  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 15,
              child: Text(
                "${user.id}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.name}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${user.phone}",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ],
        ),
      );
}

// create item
// create list
// تحطهم ف بعض
