import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeker/providers/courseContentProvider.dart';
import 'package:seeker/widgets/contentCardIndexes.dart';

class CourseCategoryItems extends StatelessWidget {
  static const routeName = 'courseCategoryItems';
  @override
  Widget build(BuildContext context) {
    final categoryTitle =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final contents = Provider.of<CourseContentProvider>(context, listen: false)
        .courseContents;
    // Return of Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle['title'].toUpperCase(),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: contents.length,
          itemBuilder: (BuildContext ctx, int index) {
            return ContentCardIndexes(
              content: contents[index],
            );
          },
        ),
      ),
    );
  }
}
