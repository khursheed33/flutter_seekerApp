import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seeker/screen/homepage.dart';
import 'package:seeker/screen/loadingScreen.dart';
import 'package:seeker/widgets/authForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationScreen extends StatefulWidget {
  static const routeName = '/authentication';

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isLaoding = false;

  Future<void> loginWithGoogle(BuildContext _context) async {
    // Sign In
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      setState(() {
        _isLaoding = true;
      });
      GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

      AuthCredential _credetials = GoogleAuthProvider.credential(
        idToken: gSA.idToken,
        accessToken: gSA.accessToken,
      );

      await _auth.signInWithCredential(_credetials).then((value) {
        setState(() {
          _isLaoding = false;
        });
        Navigator.of(context).pushReplacementNamed('/');
      });
    } else {
      // USer does not exists
    }
  }

  void loginWithEmailandPassword({
    bool isSignIn,
    String email,
    String password,
    BuildContext context,
  }) async {
    // final GoogleSignIn _googleSignIn = GoogleSignIn();

    if (isSignIn) {
      // Sign In user with credential entered by user.
      try {
        setState(() {
          _isLaoding = true;
        });
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          setState(() {
            _isLaoding = false;
          });
          Navigator.of(context).pushReplacementNamed(Homepage.routeName);
        });
      } catch (err) {
        print(err.toString());

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("${err.message}"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Okay"),
                  ),
                ],
              );
            });
      }
    } else {
      // Sign Up user
      try {
        setState(() {
          _isLaoding = true;
        });
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((UserCredential _userCredential) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_userCredential.user.uid)
              .set({
            'userId': _userCredential.user.uid,
            'email': email,
          }).then((value) {
            setState(() {
              _isLaoding = false;
            });
          });

          Navigator.of(context).pushReplacementNamed(Homepage.routeName);
        });
      } catch (err) {
        print(err.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLaoding
          ? SeekerLoadingSpinner()
          : AuthForm(loginWithEmailandPassword, loginWithGoogle),
    );
  }
}
