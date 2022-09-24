import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_signup/edit_profile.dart';

import 'package:flutter/material.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    EditProfile();
                  }));
                },
                icon: Icon(Icons.edit_note))
          ],
          backgroundColor: Colors.lightGreen,
          title: Text('Profile'),
          centerTitle: true,
        ),
        backgroundColor: const Color(0XFFf5f6fa),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          AccountInformationWidget(
                            title: 'name',
                            name: snapshot.data.docs[index]['name'],
                          ),
                          SizedBox(height: 10),
                          AccountInformationWidget(
                            title: 'L.name',
                            name: snapshot.data.docs[index]['lastname'],
                          ),
                          SizedBox(height: 10),
                          AccountInformationWidget(
                            title: 'Email',
                            name: snapshot.data.docs[index]['email'],
                          ),
                          SizedBox(height: 10),
                          AccountInformationWidget(
                            title: 'DOB',
                            name: snapshot.data.docs[index]['dob'],
                          ),
                          SizedBox(height: 10),
                          AccountInformationWidget(
                            title: 'Phone Number',
                            name: snapshot.data.docs[index]['phone'],
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    });
              }),
        ));
  }
}

class AccountInformationWidget extends StatelessWidget {
  String name;
  String title;
  AccountInformationWidget({Key key, this.name, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 65,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.grey),
                  ),
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 13,
                      ))
                ],
              ),
            )
          ],
        ));
  }

}
