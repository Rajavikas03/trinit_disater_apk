import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:firebase_database/firebase_database.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  // double dx = 200, dy = 400, dz = 200;
  // final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double dx = width / 2, dy = height / 2, dz = 200;
    return Scaffold(
      body: StreamBuilder(
          stream: SensorsPlatform.instance.gyroscopeEventStream(),
          builder: (_, snapshots) {
            if (snapshots.hasData) {
              dx = dx + snapshots.data!.y;
              dy = dy + snapshots.data!.x;
              dz = dz + snapshots.data!.z;

              // _updateFirebaseData(dx, dy);
              //
              //
            }
            return Transform.translate(
                offset: Offset(dx, dy),
                child: CircleAvatar(
                  backgroundColor: Colors.deepPurpleAccent,
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          dx.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 8),
                        ),
                        Text(
                          dy.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 8),
                        ),
                        Text(
                          dz.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }

  // void _updateFirebaseData(double dx, double dy) {
  //   _databaseReference.child('coordinates').set({
  //     'dx': dx,
  //     'dy': dy,
  //   });
  // }
}

class AccelerometerWidget extends StatefulWidget {
  const AccelerometerWidget({Key? key}) : super(key: key);

  @override
  _AccelerometerWidgetState createState() => _AccelerometerWidgetState();
}

class _AccelerometerWidgetState extends State<AccelerometerWidget> {
  List<double> accelerometerValues = [0.0, 0.0, 0.0]; // x, y, z

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accelerometer Data'),
      ),
      body: StreamBuilder(
        stream: SensorsPlatform.instance.accelerometerEventStream(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            AccelerometerEvent event = snapshot.data as AccelerometerEvent;
            accelerometerValues = [event.x, event.y, event.z];
          }

          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Accelerometer Data:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'X: ${accelerometerValues[0].toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                Text(
                  'Y: ${accelerometerValues[1].toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                Text(
                  'Z: ${accelerometerValues[2].toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // @override
  // void dispose() {
  //   SensorsPlatform.instance.dispose();
  //   super.dispose();
  // }
}

// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';

class MagnetometerWidget extends StatefulWidget {
  const MagnetometerWidget({Key? key}) : super(key: key);

  @override
  _MagnetometerWidgetState createState() => _MagnetometerWidgetState();
}

class _MagnetometerWidgetState extends State<MagnetometerWidget> {
  List<double> magnetometerValues = [0.0, 0.0, 0.0]; // x, y, z

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magnetometer Data'),
      ),
      body: StreamBuilder(
        stream: SensorsPlatform.instance.magnetometerEventStream(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            MagnetometerEvent event = snapshot.data as MagnetometerEvent;
            magnetometerValues = [event.x, event.y, event.z];
          }

          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Magnetometer Data:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'X: ${magnetometerValues[0].toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  'Y: ${magnetometerValues[1].toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  'Z: ${magnetometerValues[2].toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Weather Forecast',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: WeatherPage(),
//     );
//   }
// }

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _apiKey = 'fe0247751a1a4681599b831f5170e635';
  String _cityName = 'Chennai';
  String _weatherDescription = '';
  double _temperature = 0.0;
  Future<void> _fetchWeather() async {
    print('hii');
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$_cityName&appid=$_apiKey&units=metric'));
    print(response);

    if (response.statusCode == 200) {
      print('true');
      final data = json.decode(response.body);
      print('Weather data: $data');

      // Check if 'weather' list exists and has at least one element
      if (data.containsKey('weather') &&
          data['weather'] is List &&
          data['weather'].isNotEmpty) {
        print(data['weather']);
        _weatherDescription = data['weather'][0]['description'];
      } else {
        _weatherDescription = 'Unknown';
        print('No weather description found');
      }

      // Check if 'main' object exists
      if (data.containsKey('main')) {
        _temperature = data['main']['temp'];
      } else {
        _temperature = 0.0;
        print('No temperature data found');
      }

      setState(() {
        // Update UI with fetched data
      });
    } else {
      throw Exception('Failed to load weather forecast');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Weather Forecast'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            Text(
              _cityName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              _weatherDescription,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Temperature: $_temperature°C',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
