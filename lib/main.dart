import 'dart:convert';

import 'package:cidexclient/Home.dart';
import 'package:cidexclient/LoginPage.dart';
import 'package:cidexclient/ShipmentList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

void main() => runApp(GetLogin());
//List mapData=new List();
List mapData;
var mapData1;
List myData;

//final List<String> entries = <String>['A', 'B', 'C'];
//final List<int> colorCodes = <int>[600, 500, 100];

class GetLogin extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home: new LoginPage());
  }
}

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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset("images/face.png"),
                title: Text('Hotels Near you'),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 80.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Card(
                    //
                    child: InkWell(
                      onTap: () {
                        String check =
                            _places[index].photos[0]['photo_reference'];
                        print(
                            "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${_places[index].photos[0]['photo_reference']}&sensor=false&key=AIzaSyBdmudFBAV9h2feld1X7CndGN-6VHsGn2g");
                        print(_places[index].photos[0]['photo_reference']);
                        // print("PHOTO DATAaaaa($photos[index].photoReference)");
                        _settingModalBottomSheet(context);
                      },
                      child: ListTile(
                        leading: _places[index].photos == null ||
                                _places[index].photos[0]["photo_reference"] ==
                                    null
                            ? Image.asset("images/face.png")
                            : Container(
                                width: 80,
                                child: Image.network(
                                    "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${_places[index].photos[0]['photo_reference']}&sensor=false&key=AIzaSyBdmudFBAV9h2feld1X7CndGN-6VHsGn2g")),
                        //_places[index].icon
                        title: Text(_places[index].placeName),
                        subtitle: Container(
                          width: 100,
                          child: Text(_places[index].address,
                              overflow: TextOverflow.ellipsis),
                        ),
                        trailing: RatingBar(
                          initialRating:
                              double.parse(_places[index].ratingStar),
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 13.0,
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
                    ),
                  );
                },
                childCount: _places == null ? 0 : _places.length,
              ),
            ),
          ],
        ),
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
        f["icon"].toString(),
        f["vicinity"].toString(),
        f["photos"])));

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
  String placeName, icon, address;
  List photos;

  Post(this.ratingStar, this.numOfRatings, this.latitude, this.longitude,
      this.placeName, this.icon, this.address, this.photos);

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

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Please add the items to buy from shop!"),
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter some text';
                    }
                    return null;
                  },
                ),
                Text("Gopinath"),
                Text("Manickam"),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('Buy'),
                    ))
              ],
            ),
          ),
        );
      });

//  ListView.builder(
//
//
//      padding: const EdgeInsets.all(8),
//      itemCount: _places == null ? 0 : _places.length,
//      itemBuilder: (BuildContext context, int index) {
//        return
//      })
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Login/Signup',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(),
    );
  }
}
