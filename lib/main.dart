import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:seeker/providers/categoryProvider.dart';
import 'package:seeker/providers/courseContentProvider.dart';
import 'package:seeker/providers/courseProvider.dart';
import 'package:seeker/screen/authentication.dart';
import 'package:seeker/screen/courseCategoryItems.dart';
import 'package:seeker/screen/courseContents.dart';
import 'package:seeker/screen/createCourse.dart';
import 'package:seeker/screen/homepage.dart';
import 'package:seeker/screen/profile.dart';
import 'package:seeker/screen/splashScreen.dart';
import 'package:seeker/screen/viewCategoryCourses.dart';
import 'package:seeker/screen/viewPDF.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => CourseProvier(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CourseContentProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Seeker",

        // home: Homepage(),
        routes: {
          '/': (ctx) => StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, _authData) {
                if (_authData.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                }
                if (!_authData.hasData) {
                  return AuthenticationScreen();
                }
                return Homepage();
              }),
          AuthenticationScreen.routeName: (ctx) => AuthenticationScreen(),
          ViewCategoryCourses.routeName: (ctx) => ViewCategoryCourses(),
          CreateCourses.routeName: (ctx) => CreateCourses(),
          CourseCategoryItems.routeName: (ctx) => CourseCategoryItems(),
          CourseContents.routeName: (ctx) => CourseContents(),
          SeekerViewPDF.routeName: (ctx) => SeekerViewPDF(),
          SeekerProfileScreen.routeName: (ctx) => SeekerProfileScreen(),
        },
      ),
    );
  }
}
