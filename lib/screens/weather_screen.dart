import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weathertesting/Widgets/weather_card.dart';
import 'package:weathertesting/weather_icons/icon_mapping.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String key = '5861f5e99ec5235d04ab2bdfab4da8a1';
  late WeatherFactory ws;
  Weather? _weather;
  List<Weather> _forecast = [];
  String cityName = '';

  @override
  void initState() {
    super.initState();
    ws = WeatherFactory(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF3D2C8E), Color(0xFF9D52AC)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                style: const TextStyle(color: Colors.white),
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
                  _weather = await ws.currentWeatherByCityName(cityName);
                  _forecast = await ws.fiveDayForecastByCityName(cityName);
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
                              '${_weather!.temperature!.celsius!.toStringAsFixed(0)}°C',
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
                            SizedBox(height: 10),
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
