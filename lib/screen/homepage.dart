import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seeker/screen/profile.dart';
import 'package:seeker/widgets/categoryCard.dart';

class Homepage extends StatelessWidget {
  static const routeName = '/homepage';
  @override
  Widget build(BuildContext context) {
    final User _currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      drawer: Drawer(
        elevation: 5,
      ),
      backgroundColor: Colors.grey[50],
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(SeekerProfileScreen.routeName);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://img.icons8.com/bubbles/2x/user-male.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //Name of the User
                    Text(
                      _currentUser.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(50, 56, 99, 1),
                      ),
                    ),
                    // Notifications
                    Spacer(),
                    Icon(
                      Icons.notifications_active,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),

                // Title Text for App
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 0.0,
                  ),
                  // margin: const EdgeInsets.all(0),

                  child: Text(
                    "Find your Favorite Courses Here",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(50, 56, 99, 1),
                    ),
                  ),
                ),
                // Search
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            size: 35,
                            color: Colors.grey[400],
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: "Search....",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // Filter Button
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(50, 56, 99, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.sort_sharp,
                          size: 35,
                          color: Colors.grey[50],
                        ),
                        onPressed: () {
                          print("Searching for you.");
                        },
                      ),
                    ),
                  ],
                ),

                // My Courses
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My Categories",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color.fromRGBO(50, 56, 99, 1),
                    ),
                  ),
                ),
                // Courses Cards
                Container(
                  height: 280,
                  child: SeekerCoursesCard(),
                )
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigate to Create Course or Category
      //     Navigator.of(context).pushNamed(CreateCourses.routeName);
      //   },
      //   child: Icon(
      //     Icons.create,
      //   ),
      // ),
    );
  }
}
