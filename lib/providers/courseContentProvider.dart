import 'package:flutter/cupertino.dart';
import 'package:seeker/models/courseContentModel.dart';

class CourseContentProvider with ChangeNotifier {
  List<CourseContentModel> _courseContents = [];
  List<CourseContentModel> get courseContents {
    return [..._courseContents];
  }
}
