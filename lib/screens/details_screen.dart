import 'package:book_app/consttants.dart';
import 'package:book_app/screens/read_screen.dart';
import 'package:book_app/widgets/book_rating.dart';
import 'package:book_app/widgets/rounded_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreen createState() => new _DetailsScreen();
}

class _DetailsScreen extends State<DetailsScreen> {
  List dataBook = [];
  int checked = 0;
  Future<void> getData() async {
    try {
      var request = await Requests.get("http://192.168.2.142:5000/api/list-book?filter=")
          .timeout(
        Duration(seconds: 10),
        onTimeout: () {
          return null;
        },
      );
      var dataRes = request.json();
      print(dataRes);
      // for (int i = 0; i < dataRes['data'].length; i++) {
      var items = new Map();
      var nameBook = dataRes['data'][0]["name"];
      var authorBook = dataRes['data'][0]['author'];
      var voteBook = dataRes['data'][0]['votes'][0]['vote'];
      var chapters = dataRes['data'][0]['chapters'];
      print(chapters.length);
      // for (int j = 0; j < chapters.length; j++) {
      //   var chapter = new Map();
      //   chapter["chapter"] =
      // }
      items["nameBook"] = nameBook;
      items["authorBook"] = authorBook;
      items["voteBook"] = voteBook;
      print(items);
      dataBook.add(items);
      // }
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
                    )),
                Padding(
                    padding: EdgeInsets.only(top: size.height * .48 - 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (var i in lists)
                          ChapterCard(
                            name: i['name'],
                            chapterNumber: i["chapterNumber"],
                            tag: i["tag"],
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (content) {
                                    return ReadScreen();
                                  },
                                ),
                              );
                            },
                          ),
                        SizedBox(height: 10),
                      ],
                    )
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: <Widget>[
                    //     ChapterCard(
                    //       name: "Cõi mộng",
                    //       chapterNumber: 1,
                    //       tag: "Thi cử thôi mà cũng mệt",
                    //       press: () {},
                    //     ),
                    //     ChapterCard(
                    //       name: "Tin dữ",
                    //       chapterNumber: 2,
                    //       tag: "Hai người cảnh sát đó ",
                    //       press: () {},
                    //     ),
                    //     ChapterCard(
                    //       name: "Mật thất",
                    //       chapterNumber: 3,
                    //       tag: "Một chiếc taxi bình thường ",
                    //       press: () {},
                    //     ),
                    //     ChapterCard(
                    //       name: "Nhân vật thần bí",
                    //       chapterNumber: 4,
                    //       tag: "Sau một hồi ồn ào vang lên",
                    //       press: () {},
                    //     ),
                    //     SizedBox(height: 10),
                    //   ],
                    // ),
                    ),
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
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),                         
                        ),
                      ],
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [ 
                        CommentScreen(),
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
                                    score: 4.9,
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
                          'https://googleflutter.com/sample_image.jpg',
                          // "assets/images/truyen-3.png",
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
class ChapterCard extends StatelessWidget {
  final String name;
  final String tag;
  final int chapterNumber;
  final Function press;
  const ChapterCard({
    Key key,
    this.name,
    this.tag,
    this.chapterNumber,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      margin: EdgeInsets.only(bottom: 16),
      width: size.width - 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 20),
            blurRadius: 15,
            color: Color(0xFFD3D3D6).withOpacity(.84),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Chương $chapterNumber : $name \n",
                  style: TextStyle(
                    fontSize: 16,
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: tag,
                  style: TextStyle(color: kLightBlackColor),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onPressed: press,
          )
        ],
      ),
    );
  }
}

class BookInfo extends StatelessWidget {
  const BookInfo({
    Key key,
    this.size,
  }) : super(key: key);

  final Size size;

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
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Điệp viên",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 28),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: this.size.height * .005),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      "kỳ quái",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: this.size.width * .3,
                            padding:
                                EdgeInsets.only(top: this.size.height * .02),
                            child: Text(
                              "Lâm Ngữ Đường vẫn như mọi người, thong thả từ trường về nhà, không ngờ lại gặp phải chuyện kỳ quái...",
                              maxLines: 5,
                              style: TextStyle(
                                fontSize: 10,
                                color: kLightBlackColor,
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: this.size.height * .015),
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
                                      return ReadScreen();
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
                          BookRating(score: 4.9),
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
                  'https://googleflutter.com/sample_image.jpg',
                  height: 180,
                  width: 200,
                ),
              )),
        ],
      ),
    );
  }
}
class CommentScreen extends StatefulWidget {
  @override
  createState() => new CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> { 
  List<String> _Comments = ['Truyen hay qua', 'Ad cap nhat truyen di', 'Khi nao ra chuong moi vay'];
  List<String> _name =['anh', 'son', 'hieu'];
  void _addComment(String val){
    setState(() {
      _Comments.add(val);
    });
  }
void _addName(String val){
  setState(() {
    _name.add(val);
  });
}

  Widget _buildCommentList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if(index < _Comments.length) {
          return _buildCommentItem(_Comments[index], _name[index]);
        }
      }
    );
  }

  Widget _buildCommentItem(String comment, String name) {
    return ListTile(title: Text(name), subtitle: Text(comment),);
  }


  @override 
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: <Widget>[
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
            },
          ),
          Expanded(
            child: 
                _buildCommentList(),            
          ),        
          TextField(
            onSubmitted: (String submittedStr) {
              _addComment(submittedStr);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20.0),
              hintText: 'Nhận xét...',
            ),
          ),
        ],
      ),
      );
  }
}
