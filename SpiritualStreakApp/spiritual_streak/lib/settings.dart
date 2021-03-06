import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'main.dart';
import 'logIn.dart';
import 'forgotPassword.dart';
import 'about.dart';

bool isSwitched = false;

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black54,
      appBar: AppBar(
        title: const Text(
          'Spiritual Streak',
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Settings',
                    style: TextStyle(fontSize: 20),
                  )),
              TextButton(
                onPressed: () {
                  //forgot password screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Log Out'),
                    onPressed: () async {
                      try {
                        _auth.signOut();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const login()));
                      } catch (e) {
                        print(e);
                      }
                    },
                  )),
              Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  child: const Text('Reset'),
                  onPressed: () {
                    setState(() {
                      Alert(
                        style: AlertStyle(
                          // backgroundColor: Colors.blueGrey.shade900,
                          titleStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          descStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        context: context,
                        title: "Reset",
                        desc: "Are you sure you want to reset the counter?",
                        buttons: [
                          DialogButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                          DialogButton(
                            color: Colors.redAccent,
                            onPressed: () {
                              setState(() {
                                setCount(0);
                                resetHistory();
                              });

                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Reset",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ],
                      ).show();
                    });
                  },
                ),
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  child: const Text('About'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const about()));
                  },
                ),
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ElevatedButton(
                  child: const Text('Licenses'),
                  onPressed: () {
                    showLicensePage(
                      context: context,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
