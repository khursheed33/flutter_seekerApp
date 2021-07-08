import 'package:flutter/foundation.dart';

class CourseModel {
  final String courseId;
  // final int courseDuration;
  final String courseCategory;
  final String courseTitle;
  final String courseAuthor;
  // final String courseAuthorId;
  final String courseCreatedDate;
  final String pdfUrl;
  // final String courseImage;
  // final String courseDescription;

  CourseModel({
    @required this.courseId,
    // @required this.courseDuration,
    @required this.courseCategory,
    @required this.courseAuthor,
    // @required this.courseAuthorId,
    @required this.courseCreatedDate,
    @required this.pdfUrl,
    // @required this.courseDescription,
    // @required this.courseImage,
    @required this.courseTitle,
  });
}
