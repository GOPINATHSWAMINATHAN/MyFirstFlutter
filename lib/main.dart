import 'dart:convert';

import 'package:cidexclient/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());
//List mapData=new List();
List mapData;
var mapData1;

final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  List<Post> _places;

  void initState() {
    if (_places == null) {
      _getLocation().then((data) {
        this.setState(() {});
        _places = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "CidEx",
      home: Scaffold(
        appBar: AppBar(
          title: Text("CidEx"),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _places == null ? 0 : _places.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: Image.network(_places[index].icon),
                  title: Text(_places[index].placeName),
                  trailing: Text("kms"),
                  subtitle: RatingBar(
                    initialRating: double.parse(_places[index].ratingStar),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20.0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
//                  onRatingUpdate: (rating) {
//                    print(rating);
//                  },
                  ),
                ),
              );
            }),
//        body: ListView(
//          children: <Widget>[
//            Card(
//              child: ListTile(
//                leading: Image.asset("images/face.png"),
//                title: Text("Place Name"),
//                trailing: Text("kms"),
//                subtitle: RatingBar(
//                  initialRating: 3,
//                  direction: Axis.horizontal,
//                  allowHalfRating: true,
//
//                  itemCount: 5,
//                  itemSize: 20.0,
//                  itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
//                  itemBuilder: (context, _) => Icon(
//                    Icons.star,
//                    color: Colors.amber,
//                  ),
////                  onRatingUpdate: (rating) {
////                    print(rating);
////                  },
//                ),
//              ),
//            )
//          ],
//        ),
      ),
    );
  }

  Future<List<Post>> _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(currentLocation);
    String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentLocation.latitude.toString()},${currentLocation.longitude.toString()}&radius=10000&type=restaurant&keyword=cruise&key=AIzaSyBdmudFBAV9h2feld1X7CndGN-6VHsGn2g";
    var res = await get(url, headers: {"Accept": "application/json"});

    List data = json.decode(res.body)["results"];
    print(data);
    var places = <Post>[];
    data.forEach((f) => places.add(new Post(
        f["rating"].toString(),
        f["user_ratings_total"].toString(),
        f["latitude"].toString(),
        f["longitude"].toString(),
        f["name"].toString(),
        f["icon"].toString())));

//    if (res.statusCode == 200) {
//      setState(() {
//        mapData1 = json.decode(res.body);
//        mapData = mapData1['results'];
//      });
//
//    new Post(ratingStar: f["rating"],
//        numOfRatings: f["user_ratings_total"],
//        latitude: f["latitude"],
//        longitude: f["longitude"],
//        placeName: f["name"]))

    //print(mapData[1]['name']);
    return places;
  }
}

// This widget is the root of your application.

class Post {
  final String numOfRatings;
  final String latitude, longitude, ratingStar;
  String placeName, icon;

  Post(this.ratingStar, this.numOfRatings, this.latitude, this.longitude,
      this.placeName, this.icon);

//  factory Post.fromJson(Map<String, dynamic> json) {
//    return Post(
//      ratingStar: json['rating'] as String,
//      numOfRatings: json['user_ratings_total'] as String,
//      latitude: json['latitude'] as String,
//      longitude: json['longitude'] as String,
//      placeName: json['name'] as String,
//    );
//}
}
