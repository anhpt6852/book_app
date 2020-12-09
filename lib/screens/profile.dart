import 'package:flutter/material.dart';
import 'package:book_app/widgets/info_card.dart';

const email = 'anhphamtuan31081999@gmail.com';


class UserProfile extends StatelessWidget {
  String emailUser = "";
  String nameProfile = "";
  UserProfile({
    Key key,
    this.emailUser,
    this.nameProfile
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Thông tin người dùng'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.brown.shade800,
              child: Text(nameProfile.substring(0,1),style: TextStyle(fontSize: 60)),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Text(nameProfile),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.teal.shade700,
              ),
            ),
            InfoCard(
              text: emailUser,
              icon: Icons.email,
            ),
            InfoCard(
              text: 'Truyện đã đọc: Điệp viên kỳ quái, Cách một cánh cửa', 
              icon: Icons.book,
              ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}