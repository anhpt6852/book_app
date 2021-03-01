import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:book_app/widgets/card_widgets/search_card.dart';
import "package:book_app/screens/Details/details_screen.dart";

class SearchBarDemoHome extends StatefulWidget {
  final String tokenUser;
  final int userID;
  SearchBarDemoHome({
    Key key,
    this.tokenUser,
    this.userID,
  }) : super(key: key);
  @override
  _SearchBarDemoHomeState createState() => new _SearchBarDemoHomeState();
}

class _SearchBarDemoHomeState extends State<SearchBarDemoHome> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Tìm kiếm'),
        actions: [searchBar.getSearchAction(context)]);
  }

  List dataBooks = [];
  void onSubmitted(String value) async {
    setState(() => _isLoading = true);
    dataBooks = [];
    try {
      String linkRequest =
          "http://192.168.43.187:5000/api/list-book?name=" + value + "&author=";
      var request = await Requests.get(linkRequest).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          return null;
        },
      );
      var dataRes = request.json();
      if (dataRes["data"].length == 0) {
        String linkAuthor =
            "http://192.168.43.187:5000/api/list-book?name=&author=" + value;
        request = await Requests.get(linkAuthor).timeout(
          Duration(seconds: 10),
          onTimeout: () {
            return null;
          },
        );
        dataRes = request.json();
      }
      for (int i = 0; i < dataRes['data'].length; i++) {
        var items = new Map();
        var nameBook = dataRes['data'][i]["name"];
        var authorBook = dataRes['data'][i]['author'];
        var urlImgBook = dataRes["data"][i]["imageUrl"];
        var idBook = dataRes["data"][i]["id"];
        List dataChapter = [];
        for (int k = 0; k < dataRes["data"][i]["chapters"].length; k++) {
          var chapters = new Map();
          var nameChapter = dataRes["data"][i]["chapters"][k]["name"];
          var linkPdf = dataRes["data"][i]["chapters"][k]["linkPdf"];
          var idChapter = dataRes["data"][i]["chapters"][k]["id"];
          chapters["nameChapter"] = nameChapter;
          chapters["linkPdf"] = linkPdf;
          chapters["idChapter"] = idChapter;
          dataChapter.add(chapters);
        }
        List dataComment = [];
        for (int k = 0; k < dataRes["data"][i]["comments"].length; k++) {
          var comments = new Map();
          var content = dataRes["data"][i]["comments"][k]["comment"];
          var userCmt = dataRes["data"][i]["comments"][k]["user"]["name"];
          comments["content"] = content;
          comments["userCmt"] = userCmt;
          dataComment.add(comments);
        }

        print(dataComment);
        items["idBook"] = idBook;
        items["nameBook"] = nameBook;
        items["authorBook"] = authorBook;
        items["urlImgBook"] = urlImgBook;
        items["chapters"] = dataChapter;
        items["comments"] = dataComment;
        var voteBook = dataRes['data'][i]["votes"];
        double voteAverage = 0;
        for (int j = 0; j < voteBook.length; j++) {
          int votes = dataRes['data'][i]["votes"][j]["vote"];
          voteAverage += votes;
        }
        if (voteAverage == 0) {
          items["voteBook"] = 0.0;
        } else {
          double temp = voteAverage / voteBook.length;
          items["voteBook"] = double.parse(temp.toStringAsExponential(1));
        }
        dataBooks.add(items);
      }
      print(dataBooks.length);
    } on Exception {
      rethrow;
    }
    setState(() => _isLoading = false);
  }

  _SearchBarDemoHomeState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: new SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _isLoading
            ? Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.45, top: 100),
                height: 200,
                child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  for (var i in dataBooks)
                    SearchCard(
                      image: i["urlImgBook"].toString(),
                      title: i["nameBook"].toString(),
                      auth: i["authorBook"].toString(),
                      rating: i["voteBook"],
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsScreen(
                                chapters: i["chapters"],
                                nameBook: i["nameBook"].toString(),
                                image: i["urlImgBook"].toString(),
                                rating: i["voteBook"],
                                tokenUser: widget.tokenUser,
                                userID: widget.userID,
                                idBook: i["idBook"],
                                comments: i["comments"],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  SizedBox(height: 10),
                ],
              ),
      ),
    );
  }
}
