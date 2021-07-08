import 'package:flutter/foundation.dart';

class CategoryModel {
  final String userId;
  final String categroyId;
  final String categoryName;
  // final String categoryImage;
  final DateTime categoryCreatedDate;
  // final int categoryCourses;
  // final double categoryRating;
  // final String categoryBannerImage;

  CategoryModel({
    @required this.userId,
    @required this.categroyId,
    @required this.categoryName,
    @required this.categoryCreatedDate,
    // @required this.categoryCourses,
    // @required this.categoryImage,
    // @required this.categoryRating,
    // @required this.categoryBannerImage,
  });
}
