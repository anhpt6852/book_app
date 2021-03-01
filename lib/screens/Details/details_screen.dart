import 'package:book_app/consttants.dart';
import 'package:book_app/screens/Details/components/book_info.dart';
import 'package:book_app/screens/Details/components/chapter_card.dart';
import 'package:book_app/screens/Read/read_screen.dart';
import 'package:book_app/widgets/card_widgets/book_rating.dart';
import 'package:book_app/widgets/card_widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:book_app/screens/Details/components/comment_screen.dart';

class DetailsScreen extends StatefulWidget {
  List chapters = [];
  List comments = [];
  final double rating;
  final String nameBook;
  final String image;
  final String tokenUser;
  final int userID;
  final int idBook;
  DetailsScreen({
    Key key,
    this.chapters,
    this.comments,
    this.rating,
    this.nameBook,
    this.image,
    this.tokenUser,
    this.userID,
    this.idBook,
  }) : super(key: key);
  @override
  _DetailsScreen createState() => new _DetailsScreen();
}

class _DetailsScreen extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    print("--------");
    print(widget.chapters);
    print(widget.userID);
    print(widget.comments);
  }

  var lists = [
    {'name': "Cõi mộng", "chapterNumber": 1, "tag": "Thi cử thôi mà cũng mệt"},
    {'name': "Tin dữ", "chapterNumber": 2, "tag": "Hai người cảnh sát đó"},
    {
      'name': "Mật thất",
      "chapterNumber": 3,
      "tag": "Một chiếc taxi bình thường"
    },
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                        top: size.height * .12,
                        left: size.width * .1,
                        right: size.width * .02),
                    height: size.height * .5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg3.png"),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: BookInfo(
                      size: size,
                      image: widget.image,
                      rating: widget.rating,
                      nameBook: widget.nameBook,
                      chapters: widget.chapters,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: size.height * .48 - 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (var i in widget.chapters)
                          ChapterCard(
                            name: i['nameChapter'],
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (content) {
                                    return ReadScreen(
                                      linkPdf: i["linkPdf"],
                                      chapters: widget.chapters,
                                      idChapter: i["idChapter"],
                                      tokenUser: widget.tokenUser,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        SizedBox(height: 10),
                      ],
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headline5,
                        children: [
                          TextSpan(
                            text: "Nhận xét và đánh giá...",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          CommentScreen(
                            token: widget.tokenUser,
                            userId: widget.userID,
                            idBook: widget.idBook,
                            cmtUser: widget.comments,
                            nameBook: widget.nameBook,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headline5,
                      children: [
                        TextSpan(
                          text: "Có thể bạn sẽ ",
                        ),
                        TextSpan(
                          text: "thích….",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 180,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 24, top: 24, right: 150),
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            image: DecorationImage(
                              image: AssetImage("assets/images/bg4.png"),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: kBlackColor),
                                  children: [
                                    TextSpan(
                                      text: "Ngày nắng chói chang \n",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Ngô Thái Sơn",
                                      style: TextStyle(color: kLightBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  BookRating(
                                    score: widget.rating,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: RoundedButton(
                                      text: "Đọc",
                                      verticalPadding: 10,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.network(
                          widget.image,
                          width: 130,
                          height: 160,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
