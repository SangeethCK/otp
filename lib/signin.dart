// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController _mobileController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String smsCode = '';

  @override
  void dispose() {
    _mobileController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  _Signin() async {
    User user;

    _signInWithMobileNumber() async {
      UserCredential _credential;
      //var valid = _formKey.currentState.validate();
      User user;
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: '+91' + _mobileController.text.trim(),
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            print('AUTH CREDENTIAL');
            print(authCredential);
            await _auth.signInWithCredential(authCredential).then((value) {
              if (value != null) {
                print(value);
              }
            });
          },
          verificationFailed: ((error) {
            print(error);
          }),
          codeSent: (String verificationId, [int forceResendingToken]) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text("Enter OTP"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("Done"),
                    onPressed: () {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      smsCode = _codeController.text.trim();
                      PhoneAuthCredential _credential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId, smsCode: smsCode);
                    },
                  ),
                ],
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
            print(verificationId);
            print("Timout");
          },
        );
      } catch (e) {}
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Firebase Sign in',
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                      ),
                      controller: _mobileController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter mobile";
                        }
                        if (!value.contains('@')) {
                          return "Invalid mobile number";
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _signInWithMobileNumber,
                    child: Text(
                      'Send OTP ',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Center(
                    child: Text('or'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _Signin,
                    child: Text(
                      'Signin ',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
          
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
