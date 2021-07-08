import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:seeker/models/courseModel.dart';

class CourseGridItem extends StatelessWidget {
  final CourseModel course;
  CourseGridItem(this.course);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
          ),
          Container(
            height: 200,
            margin: const EdgeInsets.only(bottom: 5, top: 5),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://media.istockphoto.com/videos/teahnology-abstract-background-concept-video-id1154035820?s=640x640'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 3,
                  offset: Offset(2, 2),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(10)),
            ),
          ),
          // Positioned(
          //   // top: 40,
          //   bottom: 5,
          //   right: 20,
          //   child: Container(
          //     width: MediaQuery.of(context).size.width * 0.4,
          //     child: Stack(
          //       children: [
          //         Image.network(
          //           'https://i.pinimg.com/originals/b5/bb/80/b5bb80994bc3ecdcd5b989250e6b7746.png',
          //           fit: BoxFit.cover,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Title
          Positioned(
            top: 30,
            left: 10,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                course.courseTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          // Rating and other informations
          Positioned(
            top: 100,
            left: 10,
            child: Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "4.6 rating",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "34 views",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "122 likes",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Navigation
          Positioned(
            bottom: 30,
            left: 10,
            child: GestureDetector(
              onTap: () {
                print("${course.courseTitle}");
              },
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Explore ",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
