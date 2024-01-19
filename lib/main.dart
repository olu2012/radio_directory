
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'radio_model.dart';
import 'radio_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio Stations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<RadioModel> stations = allStations;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DS Tuner'),
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(station.logo),
            ),
            title: Text(station.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StationDetail(station: station),
                ),  
              );
            },
          );
        },
      ),
    );
  }
}

class StationDetail extends StatefulWidget {

  final RadioModel station;

  StationDetail({required this.station});

  @override
  _StationDetailState createState() => _StationDetailState();
}

class _StationDetailState extends State<StationDetail> {

  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.station.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.station.logo,
              height: 240,
            ),
            SizedBox(height: 16),
            Text(
              widget.station.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(widget.station.description),
            Spacer(),
            if (_isPlaying)
              ElevatedButton(
                onPressed: () {
                  _audioPlayer.stop();
                  setState(() {
                    _isPlaying = false;  
                  });
                },
                child: Text('STOP'),
              )
            else
              ElevatedButton(
                onPressed: () async {
                  await _audioPlayer.play(widget.station.url as Source);
                  setState(() {
                    _isPlaying = true;
                  });
                },
                child: Text('PLAY'),
              ),
          ],
        ),
      ),
    );
  }
}