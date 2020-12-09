import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:book_app/screens/details_screen.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import "package:book_app/screens/drop_down.dart";
// import 'package:dropdown_formfield/dropdown_formfield.dart';
// import "package:book_app/screens/drop_form.dart";

class ReadScreen extends StatefulWidget {
  final String linkPdf;
  List chapters = [];
  ReadScreen({Key key, this.linkPdf, this.chapters}) : super(key: key);
  @override
  _ReadScreen createState() => _ReadScreen();
}

class _ReadScreen extends State<ReadScreen> {
  bool _isLoading = true;
  PDFDocument document;
  void initState() {
    super.initState();
    loadDocument(widget.linkPdf);
    cutData();
  }

  List<dynamic> nameChapters = [];
  List linkPDFs = [];
  cutData() {
    print(widget.chapters.length);
    for (int i = 0; i < widget.chapters.length; i++) {
      nameChapters.add(widget.chapters[i]["nameChapter"]);
      linkPDFs.add(widget.chapters[i]["linkPdf"]);
    }
    setState(() {
      dataChapter = nameChapters;
    });
    print(nameChapters);
    print(linkPDFs);
  }

  loadDocument(String linkpdf) async {
    document = await PDFDocument.fromURL(linkpdf);

    setState(() => _isLoading = false);
  }
  changePDF(String value) async {
    setState(() => _isLoading = true);
      document = await PDFDocument.fromURL(
        value,
      );
    setState(() => _isLoading = false);
  }
  bool checkData = false;
  List<dynamic> dataChapter = [
    'Chương 1:...',
    'Chương 2:...',
    'Chương 3:...',
    'Chương 4:...'
  ];
  dynamic dropdownValue = 'Chương 1:...';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return DetailsScreen();
                                //     },
                                //   ),
                                // );
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: <Widget>[
                            DropdownButton<dynamic>(
                              isExpanded: true,
                              value: checkData ? dropdownValue : null,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (dynamic newValue) {
                                setState(() {
                                  checkData = true;
                                  dropdownValue = newValue;
                                  print(dataChapter.indexOf(dropdownValue));
                                  print(linkPDFs[
                                      dataChapter.indexOf(dropdownValue)]);
                                  changePDF(linkPDFs[dataChapter.indexOf(dropdownValue)]);
                                });
                              },
                              items: dataChapter.map((dynamic value) {
                                return DropdownMenuItem<dynamic>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.volume_up),
                                color: Colors.amber,
                                onPressed: null),
                          ],
                        ),
                      ),
                    ],
                  ),
                  presentChapter(size, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container presentChapter(Size size, BuildContext context) {
    return Container(
      // child: _isLoading
      //         ? Center(child: CircularProgressIndicator())
      //         : PDFViewer(
      //             document: document,)
      // zoomSteps: 1,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.89,
            // width: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : PDFViewer(
                      document: document,
                      zoomSteps: 1,
                      // lazyLoad: false,
                      scrollDirection: Axis.vertical,
                    ),
              padding: EdgeInsets.only(left: 0, top: 0, right: 0),
              height: MediaQuery.of(context).size.height * 0.9,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class DropDownList extends StatefulWidget {
//   List chapters = [];
//   DropDownList({
//     Key key,
//     this.chapters,
//   }) : super(key: key);

//   @override
//   _DropDownListState createState() => _DropDownListState();
// }

// class _DropDownListState extends State<DropDownList> {
//   @override
//   void initState() {
//     super.initState();
//     // cutData();
//     setState(() {
//       dataChapter = widget.chapters;

//     });
//   }

//   bool checkData = false;
//   List<dynamic> dataChapter = [
//     'Chương 1:...',
//     'Chương 2:...',
//     'Chương 3:...',
//     'Chương 4:...'
//   ];
//   dynamic dropdownValue = 'Chương 1:...';
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<dynamic>(
//       isExpanded: true,
//       value: checkData ? dropdownValue : null,
//       icon: Icon(Icons.arrow_drop_down),
//       iconSize: 24,
//       elevation: 16,
//       style: TextStyle(color: Colors.deepPurple),
//       underline: Container(
//         height: 2,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (dynamic newValue) {
//         setState(() {
//           checkData = true;
//           dropdownValue = newValue;
//           print(dataChapter.indexOf(dropdownValue));
//         });
//       },
//       items: dataChapter.map((dynamic value) {
//         return DropdownMenuItem<dynamic>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
