import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

List<ShipmentData> myLists;

class ShipmentList extends StatefulWidget {
  @override
  _ShipmentListState createState() => _ShipmentListState();
}

class _ShipmentListState extends State<ShipmentList> {
  void initState() {
    if (myLists == null) {
      _getData().then((data) {
        this.setState(() {});
        myLists = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Shipment Lists'),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 200.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                child: Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text("Receiver Name"),
                          ),
                          Container(
                            child: Text(myLists[index].receiverName == null
                                ? ""
                                : myLists[index].receiverName),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text("Address"),
                          ),
                          Container(
                            child: Text(myLists[index].address == null
                                ? ""
                                : myLists[index].address),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text("City"),
                          ),
                          Container(
                            child: Text(myLists[index].city == null
                                ? ""
                                : myLists[index].city),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text("Shipment Date"),
                          ),
                          Container(
                            child: Text(myLists[index].date==null ? ""
                                :myLists[index].date),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text("Phone Number"),
                          ),
                          Container(
                            child: Text(myLists[index].phoneno==null ? ""
                                :myLists[index].phoneno),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text("Status"),
                          ),
                          Container(
                            child: Text(myLists[index].status==null ? ""
                                :myLists[index].status),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: myLists==null?0:myLists.length,
          ),
        ),
      ],
    )));
  }
}

//url:

Future<List<ShipmentData>> _getData() async {
  String url =
      "http://ec2-52-66-181-239.ap-south-1.compute.amazonaws.com:2090/shipment";
  var res = await get(url, headers: {"Accept": "application/json"});

  List data = json.decode(res.body);
  var shipmentLists = <ShipmentData>[];
  data.forEach((f) => shipmentLists.add(new ShipmentData(
      f["receivername"].toString(),
      f["AddressLine1"].toString(),
      f["city"].toString(),
      f["date"].toString(),
      f["contactnumber"].toString(),
      f["status"])));
  return shipmentLists;
}

class ShipmentData {
  String receiverName, address, city, date, phoneno, status;

  ShipmentData(this.receiverName, this.address, this.city, this.date,
      this.phoneno, this.status);
}
