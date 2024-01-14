import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weathertesting/weather_icons/icon_mapping.dart';

class WeatherCard extends StatelessWidget {
  final Weather _weather;
  const WeatherCard({super.key, required Weather weather}) : _weather = weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      height: 172,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF3D2C8E), Color(0xFF9D52AC)],
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconMapping[_weather.weatherIcon],
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            '${_weather.temperature!.celsius!.toStringAsFixed(0)}°C',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text(
            '${_weather.weatherMain}',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
