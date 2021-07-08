import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeker/providers/categoryProvider.dart';
import 'package:seeker/providers/courseProvider.dart';
import 'package:seeker/screen/viewCategoryCourses.dart';

class SeekerCoursesCard extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<CategoryProvider>(context, listen: false)
            .fetchCategories(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final courses = Provider.of<CategoryProvider>(context).categories;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  Provider.of<CourseProvier>(context, listen: false)
                      .getCategoryCourses(courses[index].categoryName);
                  // Navigate to Courses Screen
                  Navigator.of(ctx).pushNamed(
                    ViewCategoryCourses.routeName,
                    arguments: {
                      'categoryName': courses[index].categoryName,
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 5,
                          offset: Offset(-1, -1),
                        ),
                        BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 5,
                          offset: Offset(3, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Image
                        Container(
                          width: 200,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://blog.glisser.com/hubfs/blog-3-steps-dealing-01.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Divider(),
                        // Title and Author
                        Row(
                          children: [
                            // Title
                            Column(
                              children: [
                                Text(
                                  courses[index].categoryName.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 5),
                                // Author
                                Text(
                                  "- Explore Now",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            // Play or Navigation Button
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.orange[600],
                                ),
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
