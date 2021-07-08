import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class SeekerViewPDF extends StatefulWidget {
  static const routeName = '/view-pdf';
  @override
  _SeekerViewPDFState createState() => _SeekerViewPDFState();
}

class _SeekerViewPDFState extends State<SeekerViewPDF> {
  var isLoading = false;
  var isInit = true;
  String urlPath;
  var _courseData;

  Future<File> getPdfFromUrl(String url) async {
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      print("Bytes: $bytes");
      var dir = await getApplicationDocumentsDirectory();
      print("DIR: $dir");
      File file = File("${dir.path}/mypdfonline.pdf");

      File urlFile = await file.writeAsBytes(bytes);

      return urlFile;
    } catch (err) {
      // print(err.toString());
      throw Exception("Something Went Wrong");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _courseData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    getPdfFromUrl(_courseData['pdfUrl']).then((value) {
      setState(() {
        urlPath = value.path;
      });
      print("URL PATH : $urlPath");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_courseData['title']),
      ),
      body: urlPath == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ViewPDFPage(urlPath),
    );
  }
}

class ViewPDFPage extends StatefulWidget {
  final String path;
  ViewPDFPage(this.path);
  @override
  _ViewPDFPageState createState() => _ViewPDFPageState();
}

class _ViewPDFPageState extends State<ViewPDFPage> {
  bool isLoading = false;
  int _totalPage = 0;
  int _currentPage = 0;
  PDFViewController _pdfController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PDFView(
            filePath: widget.path,
            onError: (e) {
              print(e.toString());
            },
            onRender: (int _pages) {
              setState(() {
                _totalPage = _pages;
                isLoading = true;
              });
            },
            onViewCreated: (PDFViewController controller) {
              _pdfController = controller;
            },
            onPageChanged: (int _current, int _total) {},
          ),
          !isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _currentPage > 0
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  onPressed: () {
                    setState(() {
                      _currentPage -= 1;
                      _pdfController.setPage(_currentPage);
                    });
                  },
                  label: Text("Go to ${_currentPage - 1}"),
                )
              : Offstage(),
          _currentPage < _totalPage
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    setState(() {
                      _currentPage += 1;
                      _pdfController.setPage(_currentPage);
                    });
                  },
                  label: Text("Go to ${_currentPage + 1}"),
                )
              : Offstage(),
        ],
      ),
    );
  }
}
