import 'package:flutter/material.dart';
// import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:requests/requests.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';



class SearchBarDemoHome extends StatefulWidget {
  @override
  _SearchBarDemoHomeState createState() => new _SearchBarDemoHomeState();
}

class _SearchBarDemoHomeState extends State<SearchBarDemoHome> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Tìm kiếm'),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) async{
    try {
      String linkRequest =
          "http://192.168.43.187:5000/api/list-book?name="+value+"&author=";
      var request = await Requests.get(linkRequest).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          return null;
        },
      );
      var dataReponse = request.json();
      print(dataReponse["data"].length);
      // List<String> dataBook = [];
      List dataBooks = [];
      for (int i = 0; i < dataReponse["data"].length; i++) {
        var listBooks = new Map();
        var nameBook = dataReponse["data"][i]["name"];
        var authorBook = dataReponse["data"][i]["author"];
        listBooks["nameBook"] = nameBook;
        listBooks["authorBook"] = authorBook;
        dataBooks.add(listBooks);
      }
      // print(dataBook);
      print(dataBooks);
      setState(() {
        // widget.list = dataBook;
        // listCmt = dataComment;
      });
    } on Exception {
      rethrow;
    }
    setState(() => _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!')))
        );
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
      body: new Center(
          child: new Text("Don't look at me! Press the search button!")),
    );
  }
}


// class SearchBar extends StatefulWidget {
//   // final List<String> list = List.generate(10, (index) => "Text $index");
//   List<String> list = ["text",];
//   SearchBar({
//     Key key,
//   }) : super(key: key);
//   @override
//   _SearchBar createState() => _SearchBar();
// }

// class _SearchBar extends State<SearchBar> {
//   // @override
//   // Widget build(BuildContext context) {
//   //   return MaterialApp(
//   //     home: FloatingSearchBar.builder(
//   //       itemCount: 10,
//   //       itemBuilder: (BuildContext context, int index) {
//   //         return ListTile(
//   //           leading: Text(index.toString()),
//   //         );
//   //       },
//   //       trailing: CircleAvatar(
//   //         child: Icon(Icons.search),
//   //       ),
//   //       drawer: Drawer(
//   //         child: Container(),
//   //       ),
//   //       onChanged: (String value) {},
//   //       onTap: () {},
//   //       decoration: InputDecoration.collapsed(
//   //         hintText: "Search...",
//   //       ),
//   //     ),
//   //     debugShowCheckedModeBanner: false,
//   //   );
//   // }
//   Future<void> getData() async {
//     try {
//       String linkRequest =
//           "http://192.168.43.187:5000/api/list-book?name=&author=";
//       var request = await Requests.get(linkRequest).timeout(
//         Duration(seconds: 10),
//         onTimeout: () {
//           return null;
//         },
//       );
//       var dataReponse = request.json();
//       print(dataReponse["data"].length);
//       List<String> dataBook = [];
//       List dataAuthor = [];
//       for (int i = 0; i < dataReponse["data"].length; i++) {
//         var nameBook = dataReponse["data"][i]["name"];
//         var authorBook = dataReponse["data"][i]["author"];
//         dataBook.add(nameBook);
//         dataAuthor.add(authorBook);
//       }
//       print(dataBook);
//       print(dataAuthor);
//       setState(() {
//         widget.list = dataBook;
//         // listCmt = dataComment;
//       });
//     } on Exception {
//       rethrow;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: <Widget>[
//           IconButton(
//             onPressed: () {
//               showSearch(context: context, delegate: Search(widget.list));
//             },
//             icon: Icon(Icons.search),
//           )
//         ],
//         centerTitle: true,
//         title: Text('Search Bar'),
//       ),
//       body: ListView.builder(
//         itemCount: widget.list.length,
//         itemBuilder: (context, index) => ListTile(
//           title: Text(
//             widget.list[index],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Search extends SearchDelegate {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return <Widget>[
//       IconButton(
//         icon: Icon(Icons.close),
//         onPressed: () {
//           query = "";
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );
//   }

//   String selectedResult = "a123";

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text(selectedResult),
//       ),
//     );
//   }

//   final List<String> listExample;
//   Search(this.listExample);

//   List<String> recentList = [""];

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> suggestionList = ["hihi"];
//     query.isEmpty
//         ? suggestionList = recentList //In the true case
//         : suggestionList.addAll(listExample.where(
//             // In the false case
//             (element) => element.contains(query),
//           ));

//     return ListView.builder(
//       itemCount: suggestionList.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(
//             suggestionList[index],
//           ),
//           leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
//           onTap: () {
//             selectedResult = suggestionList[index];
//             showResults(context);
//           },
//         );
//       },
//     );
//   }
// }
