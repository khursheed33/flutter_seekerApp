import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:seeker/models/categoryModel.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categories = [
    // CategoryModel(
    //   userId: "xyz",
    //   categroyId: DateTime.now().toString(),
    //   categoryName: "programming",
    //   categoryCreatedDate: DateTime.now(),
    // ),
    // CategoryModel(
    //   categroyId: DateTime.now().toString(),
    //   categoryName: "gaming",
    //   categoryCreatedDate: DateTime.now(),
    // ),
    // CategoryModel(
    //   categroyId: DateTime.now().toString(),
    //   categoryName: "job",
    //   categoryCreatedDate: DateTime.now(),
    // ),
    // CategoryModel(
    //   categroyId: DateTime.now().toString(),
    //   categoryName: "quotes",
    //   categoryCreatedDate: DateTime.now(),
    // ),
  ];
  List<CategoryModel> get categories {
    return [..._categories];
  }

  // Fetch all the Categories from Firestore
  Future<void> fetchCategories(String userId) async {
    List<CategoryModel> _extractedCategory = [];
    await FirebaseFirestore.instance
        .collection('categories')
        .orderBy('createdAt', descending: true)
        .get()
        .then((QuerySnapshot _category) {
      _category.docs.forEach((QueryDocumentSnapshot _cat) {
        _extractedCategory.add(
          CategoryModel(
            userId: _cat['userId'],
            categroyId: _cat['categoryId'],
            categoryName: _cat['categoryName'],
            categoryCreatedDate: DateTime.parse(_cat['createdAt']),
          ),
        );
      });
      print("Category Leng: ${_extractedCategory.length}");
      // Assign extracted List
      _categories = _extractedCategory;
      _extractedCategory = [];
      notifyListeners();
    });
  }

  // Add new Categories to Firebase
  Future<void> addNewCategory(
    String userId,
    String title,
    String date,
  ) async {
    await FirebaseFirestore.instance.collection('categories').doc().set({
      'userId': userId,
      'categoryId': DateTime.now().toIso8601String(),
      'categoryName': title,
      'createdAt': date,
    });
  }
}

// https://hicglobalsolutions.com/wp-content/uploads/2020/09/Salesforce-Implementation-Services.png
// https://cynoteck.com/wp-content/uploads/2020/05/salesforce-Customization.png
// https://cynoteck.com/wp-content/uploads/2020/07/salesforce-professional-services-banner.png
