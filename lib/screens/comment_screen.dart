import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentScreen extends StatefulWidget {
  @override
  createState() => new CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> { 
  List<String> _Comments = [];
  
  void _addComment(String val){
    setState(() {
      _Comments.add(val);
    });
  }


  Widget _buildCommentList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if(index< _Comments.length) {
          return _buildCommentItem(_Comments[index]);
        }
      }
    );
  }

  Widget _buildCommentItem(String comment) {
    return ListTile(title: Text(comment),);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhận xét'),
      ),
      body: Column(
        children: <Widget>[
          RatingBar.builder(
            initialRating: 3,
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
            child: _buildCommentList()
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