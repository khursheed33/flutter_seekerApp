import 'package:flutter/material.dart';
import 'package:seeker/models/courseContentModel.dart';
import 'package:seeker/screen/viewPDF.dart';

class ContentCardIndexes extends StatelessWidget {
  ContentCardIndexes({this.content});
  final CourseContentModel content;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(SeekerViewPDF.routeName);
        },
        leading: Text(content.contentNumber.toString()),
        title: Text(content.contentTitle),
        subtitle: Text("Sub Title of the Text"),
        trailing: Icon(
          Icons.play_arrow_rounded,
          color: Colors.orange,
        ),
      ),
    );
  }
}
