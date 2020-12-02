import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';


class ReadScreen extends StatefulWidget {
  @override
  _ReadScreen createState() => _ReadScreen();
}

class _ReadScreen extends State<ReadScreen> {
  bool _isLoading = true;
  PDFDocument document;
  void initState() {
    super.initState();
    loadDocument();
  }
  loadDocument() async {
    document = await PDFDocument.fromURL('http://www.pdf995.com/samples/pdf.pdf');

    setState(() => _isLoading = false);
  }
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
                        flex: 5,                                              
                        child: Column(
                          children: <Widget>[
                            DropDownList(),                   
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
                              onPressed: null
                            ),                   
                          ],
                        ),
                      ),
                    ],
                  ),
                  presentChapter(size,context),
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
                        height: 480,
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

                          padding:
                              EdgeInsets.only(left: 0, top: 0, right: 0),
                          height: 480,
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
class DropDownList extends StatefulWidget {
  DropDownList({Key key}) : super(key: key);

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  String dropdownValue = 'Chương 1:...';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Chương 1:...', 'Chương 2:...', 'Chương 3:...', 'Chương 4:...']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}