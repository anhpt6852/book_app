import 'package:book_app/consttants.dart';
import 'package:book_app/screens/details_screen.dart';
import 'package:book_app/screens/read_screen.dart';
import 'package:book_app/widgets/book_rating.dart';
import 'package:book_app/widgets/reading_card_list.dart';
import 'package:book_app/widgets/two_side_rounded_button.dart';
import 'package:requests/requests.dart';
import 'package:flutter/material.dart';
import 'package:book_app/widgets/search_bar.dart';
// import 'package:requests/requests.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => new _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List dataBook = [
    // ["son", "1", "2"],
    // {'name':"Cõi mộng","chapterNumber":1,"tag":"Thi cử thôi mà cũng mệt"},
    // {'name':"Tin dữ","chapterNumber":2,"tag":"Hai người cảnh sát đó"},
    // {'name':"Mật thất","chapterNumber":3,"tag":"Một chiếc taxi bình thường"},
  ];
  int _selectedIndex = 0;
  int checked = 0;
  Future<void> getData() async {
    try {
      var request =
          await Requests.get("http://192.168.2.142:5000/api/list-book?filter=")
              .timeout(
        Duration(seconds: 10),
        onTimeout: () {
          return null;
        },
      );
      var dataRes = request.json();
      print(dataRes);
      for (int i = 0; i < dataRes['data'].length; i++) {
        var items = new Map();
        var nameBook = dataRes['data'][i]["name"];
        var authorBook = dataRes['data'][i]['author'];
        var voteBook = dataRes['data'][i]['votes'][0]['vote'];
        items["nameBook"] = nameBook;
        items["authorBook"] = authorBook;
        items["voteBook"] = voteBook;
        print(items);
        dataBook.add(items);
      }
      if (checked == 0) {
        setState(() {});
        checked = 1;
      }
    } on Exception {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index==1){
        HomeScreen();
      }
      if(index==3){
        SearchBar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search')
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/main_page.png"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * .1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.display1,
                        children: [
                          TextSpan(text: "Đề xuất cho "),
                          TextSpan(
                              text: "bạn",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        for (var i in dataBook)
                          ReadingListCard(
                            image: "assets/images/truyen-2.png",
                            title: i["nameBook"].toString(),
                            auth: i["authorBook"].toString(),
                            rating: double.parse(i["voteBook"]),
                            pressRead: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ReadScreen();
                                  },
                                ),
                              );
                            },
                            pressDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailsScreen();
                                  },
                                ),
                              );
                            },
                          ),
                        SizedBox(height: 10),
                        ReadingListCard(
                          image: "assets/images/truyen-1.png",
                          title: "Điệp viên kỳ quái",
                          auth: "Ngô Thái Sơn",
                          rating: 4.9,
                          pressRead: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ReadScreen();
                                },
                              ),
                            );
                          },
                          pressDetails: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailsScreen();
                                },
                              ),
                            );
                          },
                        ),
                        ReadingListCard(
                          image: "assets/images/truyen-2.png",
                          title: "Cách một cánh cửa",
                          auth: "Phạm Tuấn Anh",
                          rating: 4.8,
                          pressRead: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ReadScreen();
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.display1,
                            children: [
                              TextSpan(text: "Xu "),
                              TextSpan(
                                text: "hướng",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        bestOfTheDayCard(size, context),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.display1,
                            children: [
                              TextSpan(text: "Đọc "),
                              TextSpan(
                                text: "tiếp...",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/bg5.png"),
                              fit: BoxFit.fitWidth,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(38.5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 33,
                                color: Color(0xFFD3D3D3).withOpacity(.84),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(38.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 25),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Điệp viên kỳ quái",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Ngô Thái Sơn",
                                                style: TextStyle(
                                                  color: kLightBlackColor,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  "Chapter 7 of 10",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: kLightBlackColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          "assets/images/truyen-1.png",
                                          width: 55,
                                          height: 60,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 7,
                                  width: size.width * .65,
                                  decoration: BoxDecoration(
                                    color: kProgressIndicator,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40),                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Scaffold(
            //   bottomNavigationBar: BottomNavigationBar(
            //               items: const <BottomNavigationBarItem>[
            //               BottomNavigationBarItem(
            //                 icon: Icon(Icons.home),
            //                 title: Text('a'),
            //               ),
            //               BottomNavigationBarItem(
            //                 icon: Icon(Icons.business),
            //                 title: Text('b')
            //               ),
            //               BottomNavigationBarItem(
            //                 icon: Icon(Icons.school),
            //                 title: Text('c')
            //               ),
            //             ],
            //           ),
            // )
          ],
        ),
      ),
    );
  }

  Container bestOfTheDayCard(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 245,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                top: 24,
                right: size.width * .35,
              ),
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg7.png"),
                  fit: BoxFit.fitWidth,
                ),
                color: Color(0xFFEAEAEA).withOpacity(.45),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      "Hà Nội, 6 tháng Mười Một 2020",
                      style: TextStyle(
                        fontSize: 9,
                        color: kLightBlackColor,
                      ),
                    ),
                  ),
                  Text(
                    "Ngày nắng \nchói chang",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    "Ngô Thái Sơn",
                    style: TextStyle(color: kLightBlackColor),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: BookRating(score: 4.9),
                        ),
                        Expanded(
                          child: Text(
                            "Lớp 12 năm ấy, Cố Tu Nhiên vẫn nhớ rõ có một cô gái xinh xắn, làn da trắng….",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              color: kLightBlackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "assets/images/truyen-3.png",
              width: size.width * .37,
              height: size.height * .27,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size.width * .3,
              child: TwoSideRoundedButton(
                text: "Đọc",
                radious: 24,
                press: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
