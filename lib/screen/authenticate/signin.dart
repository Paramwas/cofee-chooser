import 'package:kendrick/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:kendrick/backup/authBack.dart';
import 'package:kendrick/shared/constant.dart';
import 'package:kendrick/shared/loading.dart';

class Signin extends StatefulWidget {
  final Function toggleView;
  const Signin({required this.toggleView, Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _auth = AuthService();
  final place _davido = place();
  String emaill = '';
  String passwordd = '';
  final _formKey = GlobalKey<FormState>();
  String error = 'waiting';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0,
              title: Center(child: Text('Signin pge')),
              actions: [
                TextButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: Text('Register'))
              ],
            ),
            body: Form(
                key: _formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    TextFormField(
                      decoration: textInputDeco,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Enter an email";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          emaill = val;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: textEmailDeco,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Enter password with 6 char';
                        }
                      },
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          passwordd = val;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        print("Email: $emaill, Password: $passwordd");

                        if (_formKey.currentState?.validate() ?? false) {
                          final results =
                              await _davido.SiginEasily(emaill, passwordd);

                          if (results != null) {
                            setState(() {
                              error = 'invalid email';
                            });
                            // print('Login successful: ${results.uid}');

                            // Navigate to next screen
                          }
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.black26),
                      ),
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                )));
  }
}
