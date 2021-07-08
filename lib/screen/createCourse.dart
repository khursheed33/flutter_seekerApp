import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeker/models/categoryModel.dart';
import 'package:seeker/providers/categoryProvider.dart';

// qny-ebjf-ryu
class CreateCourses extends StatefulWidget {
  static const routeName = '/createCourses';
  @override
  _CreateCoursesState createState() => _CreateCoursesState();
}

class _CreateCoursesState extends State<CreateCourses> {
  // List<String> _categories = [];
  String _currentCategory;
  String _filePath;
  String _fileName;
  bool _isInit = true;
  bool _categoryLoading = false;
  List<CategoryModel> _allCat;

  // String _pdfUrl;
  // File _pdfFile;
  bool _isUploading = false;
  final _titleController = TextEditingController();
  final _creatorController = TextEditingController();
  final _categoryNameController = TextEditingController();
  final String userId = FirebaseAuth.instance.currentUser.uid;

  Future<void> _pickPDF() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        // File file = File(result.files.single.path);
        PlatformFile file = result.files.first;
        print(file.name);
        // print(file.bytes);
        // print(file.size);
        // print(file.extension);
        print(file.path);
        setState(() {
          _fileName = file.name;
          _filePath = file.path;
          // pdfFile = file as File;
        });
      } else {
        // User canceled the picker
      }
    } catch (err) {
      print(err.toString());
    }
  }

  void _uploadPDF({
    String fileName,
    String filePath,
    String category,
    String title,
    String creator,
  }) async {
    try {
      if ((_titleController.text != null && _titleController.text.length > 5) &&
          (_creatorController.text != null &&
              _creatorController.text.length > 5) &&
          (_fileName != null)) {
        setState(() {
          _isUploading = true;
        });
        final fileRef = FirebaseStorage.instance
            .ref()
            .child(_currentCategory)
            .child("${fileName.replaceAll(new RegExp(r"\s+"), "_")}");

        UploadTask uploadTask = fileRef.putFile(File(filePath));
        String pdfUrl = await (await uploadTask.whenComplete(() {
          print("PDF Uploaded Successfully!");
        }))
            .ref
            .getDownloadURL();
        // Upload Data to the Firestore
        await FirebaseFirestore.instance.collection('courses').doc().set({
          'courseTitle': title,
          'courseCreator': creator,
          'courseCategory': category,
          'pdfUrl': pdfUrl,
          'courseCreatedAt': DateTime.now().toIso8601String(),
        }).whenComplete(() {
          setState(() {
            _isUploading = false;
          });
          print("Uploaded Successfully!");
          _titleController.text = '';
          _creatorController.text = '';
          _categoryNameController.text = '';
          _fileName = 'Pick the PDF';
          _filePath = null;
        });
      } else {
        print("Inavlid Entries");
      }
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (_isInit) {
      setState(() {
        _categoryLoading = true;
      });
      await Provider.of<CategoryProvider>(context, listen: false)
          .fetchCategories(userId)
          .then((_) {
        setState(() {
          _categoryLoading = false;
        });
        _allCat =
            Provider.of<CategoryProvider>(context, listen: false).categories;
        _currentCategory = _allCat[0].categoryName;
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false)
        .fetchCategories(userId);
    // get All Categories
    _allCat = Provider.of<CategoryProvider>(context, listen: false).categories;
    // _currentCategory = _allCat[0].categoryName;

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  alignment: Alignment.topLeft,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.freepik.com/free-photo/isolated-shot-woman-uses-smartphone-application-enjoys-browsing-social-media-creats-news-content-makes-online-order-wears-spectacles-casual-jumper-poses-beige-studio-wall_273609-44111.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                // Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      // Title
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          "Create a new Course".toUpperCase(),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              BoxShadow(
                                color: Colors.grey[400],
                                blurRadius: 2,
                                offset: Offset(2, 2),
                              )
                            ],
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      // Category
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: _categoryLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : DropdownButton(
                                    value: _currentCategory,
                                    onChanged: (String val) {
                                      setState(() {
                                        _currentCategory = val;
                                      });
                                    },
                                    items: _allCat
                                        .map(
                                          (catItem) => DropdownMenuItem<String>(
                                            value: catItem.categoryName,
                                            child: Text(catItem.categoryName
                                                .toUpperCase()),
                                          ),
                                        )
                                        .toList(),
                                  ),
                          ),
                          // Add New Categories
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: TextButton.icon(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: Text(
                                          "Add a new Category",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal,
                                          ),
                                        ),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "* Only one Word, don't use space (e.g: sports)",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .errorColor,
                                              ),
                                            ),
                                            TextField(
                                              controller:
                                                  _categoryNameController,
                                              decoration: InputDecoration(
                                                labelText: "Category Name",
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                if (_categoryNameController
                                                        .text !=
                                                    null) {
                                                  Provider.of<CategoryProvider>(
                                                          context,
                                                          listen: false)
                                                      .addNewCategory(
                                                          DateTime.now()
                                                              .toIso8601String(),
                                                          _categoryNameController
                                                              .text,
                                                          DateTime.now()
                                                              .toString());
                                                  _titleController.text = '';
                                                  // Close
                                                  Navigator.of(ctx).pop(true);
                                                }
                                              });
                                            },
                                            child: Text("Okay"),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(Icons.add_box_rounded),
                              label: Text("Add Category"),
                            ),
                          )
                        ],
                      ),
                      // Form Items
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: "Title"),
                      ),
                      TextFormField(
                        controller: _creatorController,
                        decoration:
                            InputDecoration(labelText: "Course Creator"),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        decoration: BoxDecoration(
                          color: _fileName == null
                              ? Colors.deepOrange.withOpacity(0.2)
                              : Colors.teal.withOpacity(0.1),
                          border: Border.all(
                            color: _fileName == null
                                ? Colors.deepOrange
                                : Colors.teal,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(_fileName != null
                                  ? _fileName
                                  : "Select PDF File"),
                            ),
                            GestureDetector(
                              onTap: _pickPDF,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: _fileName == null
                                        ? Colors.deepOrange
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  _fileName != null
                                      ? Icons.file_download_done
                                      : Icons.file_copy_outlined,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                // Create Now
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.teal,
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 50,
                      ),
                    ),
                  ),
                  onPressed: () {
                    print("CatName: $_currentCategory");
                    _uploadPDF(
                      fileName: _fileName,
                      filePath: _filePath,
                      category: _currentCategory,
                      title: _titleController.text,
                      creator: _creatorController.text,
                    );
                  },
                  child: Text(
                    _isUploading ? "Loading..." : "Create Course",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
