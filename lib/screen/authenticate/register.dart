import 'package:flutter/material.dart';
import 'package:kendrick/services/auth.dart';
import 'package:kendrick/shared/constant.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({required this.toggleView, Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String password = '';
  final _Formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0,
          title: Center(child: Text('Register pge')),
          actions: [
            TextButton(
                onPressed: () {
                  widget.toggleView();
                },
                child: Text('signin'))
          ],
        ),
        body: Form(
            key: _Formkey,
            child: Column(
              spacing: 20,
              children: [
                TextFormField(
                  decoration: textInputDeco,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter email";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                TextFormField(
                  decoration: textEmailDeco.copyWith(
                      hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 58, 58, 58),
                  )),
                  validator: (val) {
                    if (val == null || val.length < 6) {
                      return 'enter a password with 6 char';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_Formkey.currentState?.validate() ?? false) {
                        dynamic results =
                            await _auth.registerWithEmail(email, password);
                        if (results == null) {
                          setState(() {
                            error = 'enter the right email';
                          });
                        }
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: const Color.fromARGB(66, 56, 24, 24)),
                    )),
                Text(error)
              ],
            )));
  }
}
