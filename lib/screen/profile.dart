import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seeker/screen/authentication.dart';
import 'package:seeker/screen/createCourse.dart';

class SeekerProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _SeekerProfileScreenState createState() => _SeekerProfileScreenState();
}

class _SeekerProfileScreenState extends State<SeekerProfileScreen> {
  String _selectedItem = "English";
  bool _isSigningOut = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // First Container for the Image Avatar
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1511512578047-dfb367046420?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Z2FtaW5nfGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://img.icons8.com/bubbles/2x/user-male.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // List of Activities that use can perform in the profile section
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              // color: Colors.grey[500],
              child: Column(
                children: [
                  ListTile(
                    tileColor: Colors.grey[100],
                    leading: Icon(
                      Icons.person,
                      color: Colors.teal,
                    ),
                    title: Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                        letterSpacing: 1.3,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  ListTile(
                    tileColor: Colors.grey[100],
                    leading: Icon(
                      Icons.mobile_screen_share_outlined,
                      color: Colors.teal,
                    ),
                    title: Text(
                      "Change Mobile No.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                        letterSpacing: 1.3,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  ListTile(
                    tileColor: Colors.grey[100],
                    leading: Icon(
                      Icons.lock_open,
                      color: Colors.teal,
                    ),
                    title: Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                        letterSpacing: 1.3,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(CreateCourses.routeName);
                    },
                    tileColor: Colors.grey[100],
                    leading: Icon(
                      Icons.create,
                      color: Colors.teal,
                    ),
                    title: Text(
                      "Create Courses",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                        letterSpacing: 1.3,
                      ),
                    ),
                    trailing: Icon(
                      Icons.create_new_folder_rounded,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  ListTile(
                    tileColor: Colors.grey[100],
                    leading: Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.teal,
                    ),
                    title: Text(
                      _isSigningOut ? "Logging Out..." : "Logout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                        letterSpacing: 1.3,
                      ),
                    ),
                    trailing: Icon(
                      Icons.verified_user_rounded,
                      color: Colors.grey[300],
                    ),
                    onTap: () async {
                      try {
                        setState(() {
                          _isSigningOut = true;
                        });
                        await FirebaseAuth.instance.signOut().then((value) {
                          setState(() {
                            _isSigningOut = false;
                          });
                        });
                        Navigator.of(context).pushReplacementNamed(
                            AuthenticationScreen.routeName);
                      } catch (err) {
                        print("SignOut: $err");
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
