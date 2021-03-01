import 'package:book_app/consttants.dart';
import 'package:flutter/material.dart';

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
          Expanded(
            flex: 9,
            child: Text(
              "$name",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: kLightBlackColor,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onPressed: press,
            ),
          ),
        ],
      ),
    );
  }
}
