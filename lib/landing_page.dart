import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signup/profile_page.dart';
import 'package:firebase_signup/signin_with_phone.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          'Home Page',
        ),
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                await auth.signOut();

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SigninWithPhone();
                }));
              },
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AccountInformation();
                    }));
                  },
                  icon: Icon(Icons.person))),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text('Welcome',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 30)))
        ],
      ),
    );
  }
}
