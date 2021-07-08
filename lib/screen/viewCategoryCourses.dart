import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeker/providers/courseProvider.dart';
import 'package:seeker/screen/viewPDF.dart';
import 'package:seeker/widgets/courseGridItem.dart';

class ViewCategoryCourses extends StatefulWidget {
  static const routeName = '/categoryCourses';

  @override
  _ViewCategoryCoursesState createState() => _ViewCategoryCoursesState();
}

class _ViewCategoryCoursesState extends State<ViewCategoryCourses> {
  bool _isLoading = false;
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _categoryName =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CourseProvier>(context, listen: false)
          .fetchCoursesWithCategory(_categoryName['categoryName'])
          .then((_) {
        setState(() {
          _isLoading = false;
          print("Data Loaded: viewCategoryCourses");
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final _categoryName =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final _courses =
        Provider.of<CourseProvier>(context, listen: false).categoryCourses;
    print("LenOfCourses: ${_courses.length}");
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1499257398700-43669759a540?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8cmVhZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.chevron_left_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Navigate to previous screen
                              Navigator.of(context).pop();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _categoryName['categoryName'].toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _courses.length <= 0
                        ? Center(
                            child: Text(
                              "Courses not added yet!",
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _courses.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    SeekerViewPDF.routeName,
                                    arguments: {
                                      'title': _courses[index].courseTitle,
                                      'pdfUrl': _courses[index].pdfUrl,
                                    },
                                  );
                                },
                                child: CourseGridItem(
                                  _courses[index],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
