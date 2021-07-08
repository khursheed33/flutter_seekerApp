import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:seeker/models/courseModel.dart';

class CourseProvier with ChangeNotifier {
  // List<CourseModel> _courses = [];
  // List<CourseModel> get courses {
  //   return [..._courses];
  // }

  List<CourseModel> _categoryCourses = [];
  List<CourseModel> get categoryCourses {
    return [..._categoryCourses];
  }

  Future<void> fetchCoursesWithCategory(String _categoryName) async {
    print("fetching Courses");
    List<CourseModel> _extractedCourses = [];
    await FirebaseFirestore.instance
        .collection('courses')
        .where('courseCategory', isEqualTo: _categoryName)
        .get()
        .then((QuerySnapshot _coursesSnap) {
      _coursesSnap.docs.forEach((QueryDocumentSnapshot _course) {
        _extractedCourses.add(
          CourseModel(
            courseId: _course.id,
            courseCategory: _course['courseCategory'],
            courseAuthor: _course['courseCreator'],
            courseCreatedDate: _course['courseCreatedAt'],
            courseTitle: _course['courseTitle'],
            pdfUrl: _course['pdfUrl'],
          ),
        );
      });
      _categoryCourses = _extractedCourses;
      print("Courses Loaded: ${_categoryCourses.length}");
      notifyListeners();
    });
  }

  void getCategoryCourses(String _categoryName) {
    List<CourseModel> filteredCourses = [];
    _categoryCourses.forEach((_course) {
      if (_course.courseCategory == _categoryName) {
        filteredCourses.add(_course);
      }
    });
    _categoryCourses = filteredCourses;
    notifyListeners();
  }
}

// https://hicglobalsolutions.com/wp-content/uploads/2020/09/Salesforce-Implementation-Services.png
// https://cynoteck.com/wp-content/uploads/2020/05/salesforce-Customization.png
// https://cynoteck.com/wp-content/uploads/2020/07/salesforce-professional-services-banner.png
