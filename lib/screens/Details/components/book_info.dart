import 'package:book_app/screens/Read/read_screen.dart';
import 'package:book_app/widgets/card_widgets/book_rating.dart';
import 'package:flutter/material.dart';

class BookInfo extends StatelessWidget {
  BookInfo(
      {Key key,
      this.size,
      this.image,
      this.rating,
      this.nameBook,
      this.chapters})
      : super(key: key);
  List chapters = [];
  final Size size;
  final String image;
  final double rating;
  final String nameBook;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$nameBook",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 26),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.only(top: this.size.height * .065),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (content) {
                                      return ReadScreen(
                                        linkPdf: chapters[0]["linkPdf"],
                                        chapters: chapters,
                                        idChapter: chapters[0]["idChapter"],
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Đọc",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              size: 20,
                              color: Colors.grey,
                            ),
                            onPressed: () {},
                          ),
                          BookRating(
                            score: rating,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.transparent,
                child: Image.network(
                  image,
                  height: 180,
                  width: 200,
                ),
              )),
        ],
      ),
    );
  }
}
