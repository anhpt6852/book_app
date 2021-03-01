import 'package:book_app/screens/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_app/Screens/Login/components/background.dart';
import 'package:book_app/Screens/Signup/signup_screen.dart';
import 'package:book_app/widgets/login_widgets/already_have_an_account_acheck.dart';
import 'package:book_app/widgets/login_widgets/rounded_button.dart';
import 'package:book_app/widgets/login_widgets/rounded_user_field.dart';
import 'package:book_app/widgets/login_widgets/rounded_password_field.dart';
import 'package:requests/requests.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => new _Body();
}

class _Body extends State<Body> {
  String username = "";
  String passWord = "";
  bool checkUser = false;
  String tokenLogin = "";
  String emailUser = "";
  String nameProfile = "";
  int userID;
  bool checkLogin = true;
  Future<void> checkRequest() async {
    try {
      var request = await Requests.post("http://192.168.43.187:5000/api/login",
              body: {
                'username': username,
                'password': passWord,
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
      if (dataReponse["success"] == true) {
        setState(() {
          checkUser = true;
          tokenLogin = dataReponse["data"];
          userID = dataReponse["userId"];
          emailUser = dataReponse["userEmail"];
          nameProfile = dataReponse["userName"];
        });
      } else {
        setState(() {
          checkLogin = false;
        });
      }
    } on Exception {
      rethrow;
    }
    print(username);
    print(passWord);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(height: size.height * 0.03),
            RoundedUserField(
              hintText: "User",
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  passWord = value;
                });
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                await checkRequest();
                if (checkUser) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen(
                          tokenUser: tokenLogin,
                          userId: userID,
                          emailUser: emailUser,
                          nameProfile: nameProfile,
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Text(
              (checkLogin) ? "" : "Sai tài khoản hoặc mật khẩu",
              style: TextStyle(color: Color.fromRGBO(255, 1, 1, 1)),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
