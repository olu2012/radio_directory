import 'package:flutter/material.dart';
import 'package:radio_streaming_app/model/radio_station.dart';

class StationListPage extends StatelessWidget {
final List<Station> stations;

StationListPage({Key? key, required this.stations}) : super(key: key);

@override
Widget build(BuildContext context) {
return ListView.builder(
itemCount: stations.length,
itemBuilder: (context, index) {
final station = stations[index];
return ListTile(
leading: Image.network(station.logoUrl),
title: Text(station.name),
subtitle: Text(station.description),
onTap: () => Navigator.push(
context,
MaterialPageRoute(
builder: (context) => StationPage(station: station),
),
),
);
},
);
}
}
