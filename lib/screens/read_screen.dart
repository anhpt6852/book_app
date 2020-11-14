import 'package:flutter/material.dart';

class ReadScreen extends StatelessWidget {
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
                        Text("Chương 1: ..."),              
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
                  Stack(
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
                          padding:
                              EdgeInsets.only(left: 0, top: 0, right: 0),
                          height: 480,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ResumeChapter(size,context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Container ResumeChapter(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 45,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEAEAEA).withOpacity(.45),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}