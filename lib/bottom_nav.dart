import 'package:flutter/material.dart';

import 'package:trinit_disater_apk/Home.dart';
import 'package:trinit_disater_apk/const.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

// import 'CONST/Color.dart';

// ignore: non_constant_identifier_names
int current_index = 0;
int selectedTileIndex = 0;
final screens = [
  const MyHome(),
  const AccelerometerWidget(),
  const MagnetometerWidget(),
  WeatherPage(),
];

// bottom_nav_bar() {
class buttom_nav_bar extends StatefulWidget {
  const buttom_nav_bar({super.key});

  @override
  State<buttom_nav_bar> createState() => _buttom_nav_barState();
}

class _buttom_nav_barState extends State<buttom_nav_bar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: screens[current_index],
      bottomNavigationBar: Container(
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: GNav(
            gap: 8,
            backgroundColor: white,
            color: blgrey,
            activeColor: lightblue,
            tabBackgroundColor: const Color(0xffeff7ff),
            selectedIndex: current_index,
            padding: const EdgeInsets.all(14.0),
            haptic: true,
            onTabChange: (index) {
              setState(() {
                // print('$index hii');
                current_index = index;
                selectedTileIndex = index;
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                leading: icon_(
                  height: height * 0.028,
                  imgStr: 'assets/gy.png',
                  width: width * 0.1,
                  // color: selectedTileIndex == 0 ? lightblue : blgrey
                ),
                text: 'Gyroscope..',
              ),
              GButton(
                icon: Icons.calendar_month_outlined,
                leading: icon_(
                  height: height * 0.028,
                  imgStr: 'assets/ac.png',
                  width: width * 0.1,
                  // color: selectedTileIndex == 1 ? lightblue : blgrey
                ),
                text: 'Accelerometer..',
              ),
              GButton(
                icon: Icons.message,
                leading: icon_(
                  height: height * 0.028,
                  imgStr: 'assets/compass.png',
                  width: width * 0.1,
                  // color: selectedTileIndex == 2 ? lightblue : blgrey
                ),
                text: 'Magnetometer..',
              ),
              GButton(
                icon: Icons.message,
                leading: icon_(
                  height: height * 0.028,
                  imgStr: 'assets/weather.png',
                  width: width * 0.1,
                  // color: selectedTileIndex == 2 ? lightblue : blgrey
                ),
                text: 'Weather',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void onTileSelected(int index) {
  //   setState(() {
  //     selectedTileIndex = index;
  //     print(index);
  //   });
  // }
}

class icon_ extends StatelessWidget {
  const icon_({
    super.key,
    required this.height,
    required this.imgStr,
    required this.width,
    // required this.color,
  });

  final double height;
  final String imgStr;
  final double? width;
  // final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Image.asset(
        imgStr,
        // color: color,
      ),
    );
  }
}
