import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:requests/requests.dart';

class CommentScreen extends StatefulWidget {
  final String token;
  final int userId;
  final int idBook;
  final String nameBook;
  List cmtUser = [];
  CommentScreen(
      {Key key,
      this.token,
      this.userId,
      this.idBook,
      this.cmtUser,
      this.nameBook})
      : super(key: key);
  @override
  createState() => new CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {
  List listCmt = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      listCmt = widget.cmtUser;
    });
  }

  Future<void> postVote(double rating) async {
    try {
      var request = await Requests.post("http://192.168.43.187:5000/api/vote",
              headers: {"x-access-token": widget.token},
              body: {
                "vote": rating,
                "bookId": widget.idBook,
                "userId": widget.userId
              },
              bodyEncoding: RequestBodyEncoding.JSON)
          .timeout(
        Duration(seconds: 10),
        onTimeout: () {
          return null;
        },
      );
      var dataReponse = request.json();
      print(dataReponse);
    } on Exception {
      rethrow;
    }
  }

  Future<void> postComment(String comment) async {
    try {
      var request = await Requests.post(
              "http://192.168.43.187:5000/api/create-comment",
              headers: {"x-access-token": widget.token},
              body: {
                "comment": comment,
                "bookId": widget.idBook,
                "userId": widget.userId
              },
              bodyEncoding: RequestBodyEncoding.JSON)
          .timeout(
        Duration(seconds: 10),
        onTimeout: () {
          return null;
        },
      );
      updateComment();
    } on Exception {
      rethrow;
    }
  }

  Future<void> updateComment() async {
    try {
      String linkRequest = "http://192.168.43.187:5000/api/list-book?name=" +
          widget.nameBook +
          "&author=";
      var request = await Requests.get(linkRequest).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          return null;
        },
      );
      var dataReponse = request.json();
      print(dataReponse["data"][0]["comments"].length);
      List dataComment = [];
      for (int i = 0; i < dataReponse["data"][0]["comments"].length; i++) {
        var comments = new Map();
        var content = dataReponse["data"][0]["comments"][i]["comment"];
        var userCmt = dataReponse["data"][0]["comments"][i]["user"]["name"];
        comments["content"] = content;
        comments["userCmt"] = userCmt;
        dataComment.add(comments);
      }
      setState(() {
        listCmt = dataComment;
      });
    } on Exception {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.6,
      child: Column(
        children: <Widget>[
          TextField(
            onSubmitted: (String submittedStr) {
              postComment(submittedStr);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20.0),
              hintText: 'Nhận xét...',
            ),
          ),
          SizedBox(height: 10),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
              postVote(rating);
            },
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (var i in listCmt)
                  ListTile(
                    leading: Container(
                      child: Text(i["userCmt"].substring(0, 1),
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(30, 136, 229, 1),
                      ),
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(left: 0),
                    ),
                    title: Text(i["userCmt"]),
                    subtitle: Text(i["content"]),
                  ),
                SizedBox(height: 10),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
