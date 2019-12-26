import 'package:flutter/material.dart';

import 'Choice.dart';
import 'main.dart';

class Home extends StatelessWidget {
  List<Choice> choices = const <Choice>[
    const Choice(title: 'Car', icon: Icons.directions_car),
    const Choice(title: 'Bicycle', icon: Icons.directions_bike),
    const Choice(title: 'Boat', icon: Icons.directions_boat),
    const Choice(title: 'Bus', icon: Icons.directions_bus),
    const Choice(title: 'Train', icon: Icons.directions_railway),
    const Choice(title: 'Walk', icon: Icons.directions_walk),
    const Choice(title: 'Car', icon: Icons.directions_car),
    const Choice(title: 'Bicycle', icon: Icons.drafts),
    const Choice(title: 'Boat', icon: Icons.dvr),
    const Choice(title: 'Bus', icon: Icons.copyright),
    const Choice(title: 'Train', icon: Icons.cloud_off),
    const Choice(title: 'Car', icon: Icons.directions_car),
    const Choice(title: 'Bicycle', icon: Icons.directions_bike),
    const Choice(title: 'Boat', icon: Icons.directions_boat),
    const Choice(title: 'Bus', icon: Icons.directions_bus),
    const Choice(title: 'Train', icon: Icons.directions_railway),
    const Choice(title: 'Walk', icon: Icons.directions_walk),
    const Choice(title: 'Car', icon: Icons.directions_car),
    const Choice(title: 'Bicycle', icon: Icons.drafts),
    const Choice(title: 'Boat', icon: Icons.dvr),
    const Choice(title: 'Bus', icon: Icons.copyright),
    const Choice(title: 'Train', icon: Icons.cloud_off),
    const Choice(title: 'Car', icon: Icons.directions_car),
    const Choice(title: 'Bicycle', icon: Icons.directions_bike),
    const Choice(title: 'Boat', icon: Icons.directions_boat),
    const Choice(title: 'Bus', icon: Icons.directions_bus),
    const Choice(title: 'Train', icon: Icons.directions_railway),
    const Choice(title: 'Walk', icon: Icons.directions_walk),
    const Choice(title: 'Car', icon: Icons.directions_car),
    const Choice(title: 'Bicycle', icon: Icons.drafts),
    const Choice(title: 'Boat', icon: Icons.dvr),
    const Choice(title: 'Bus', icon: Icons.copyright),
    const Choice(title: 'Train', icon: Icons.cloud_off),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("CidEx"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              child: Image.asset("images/face.png"),
              height: 150,
            ),
          ),
          SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                 // mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: Center(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Icon(choices[index].icon),
                              ),
                              Text(
                                choices[index].title,
                                style: TextStyle(fontSize: 22),
                              )
                            ],
                          )),
                        )),
                  );
                },
                childCount: choices.length,
              )),
        ],
      ),
    ));
  }
}
