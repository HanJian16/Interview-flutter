import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ListTile(
        leading: Image.asset('assets/images/weatherIcon.png'),
        title: const Text(
          'WeatherForemost',
          style: TextStyle(color: Colors.white),
        ),

      ),
      backgroundColor: Colors.black,
    );
  }
}
