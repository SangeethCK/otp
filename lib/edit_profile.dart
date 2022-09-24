import 'package:flutter/material.dart';


class EditProfile extends StatelessWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                TextFormField(),
                TextFormField(),
                TextFormField(),TextFormField(),
              ]))
        ],
      ),
    );
  }
}
