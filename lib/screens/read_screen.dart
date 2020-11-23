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
                        flex: 13,                                              
                        child: Column(
                          children: <Widget>[  
                            Padding(
                              padding: EdgeInsets.only(left: 10),
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
                              onPressed: null
                            ),                   
                          ],
                        ),
                      ),
                      Expanded(    
                        flex: 4,                    
                        child: Column(
                          children: <Widget>[                                                                
                            IconButton(
                              icon: Icon(Icons.translate), 
                              color: Colors.amber,
                              onPressed: null
                            ),                   
                          ],
                        ),
                      ),
                    ],
                  ),
                  presentChapter(size,context),
                  Row(
                    children: <Widget>[
                      Expanded(       
                        flex: 4,                                         
                        child: Column(
                          children: <Widget>[                                                                
                            IconButton(
                              icon: Icon(Icons.navigate_before), 
                              color: Colors.amber,
                              onPressed: null
                            ),                   
                          ],
                        ),
                      ),
                      Text("Chương 1: ..."), 
                      Expanded(    
                        flex: 4,                    
                        child: Column(
                          children: <Widget>[                                                                
                            IconButton(
                              icon: Icon(Icons.navigate_next), 
                              color: Colors.amber,
                              onPressed: null
                            ),                   
                          ],
                        ),
                      ),                    
                    ],
                  ),
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