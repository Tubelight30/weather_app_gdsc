import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weathertesting/Widgets/weather_card.dart';
import 'package:weathertesting/weather_icons/icon_mapping.dart';
import 'package:weathertesting/services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService ws = WeatherService();
  Weather? _weather;
  List<Weather> _forecast = [];
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF3D2C8E), Color.fromARGB(255, 120, 82, 172)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  cityName = value;
                },
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Enter city name',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(162, 255, 255, 255))),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  _weather = await ws.getCurrentWeather(cityName);
                  _forecast = await ws.getFiveDayForecast(cityName);
                  setState(() {});
                },
                child: const Text('Show Weather and Forecast'),
              ),
              _weather == null
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Icon(
                              iconMapping[_weather!.weatherIcon],
                              color: Colors.white,
                              size: 40,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '${_weather!.temperature!.celsius!.toStringAsFixed(0)}°C in ${_weather?.areaName}, ${_weather?.country}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${_weather!.weatherMain}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        _weather == null
                            ? Container()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: _forecast.take(3).map(
                                  (dayForecast) {
                                    return WeatherCard(
                                      weather: dayForecast,
                                    );
                                  },
                                ).toList(),
                              ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
