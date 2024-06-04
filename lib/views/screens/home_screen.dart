import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lesson50/utils/translate_to_uzbek.dart';
import 'package:lesson50/viewmodel/weather_view_model.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final weatherViewModel = WeatherViewModel();
  Future<void>? _weatherFuture;

  DateTime? sunriseTime;
  DateTime? sunsetTime;
  DateTime? now;

  void _fetchWeather() {
    setState(() {
      _weatherFuture = weatherViewModel.fetchWeather(_controller.text);
    });
  }

  double _calculateSunProgress(int sunrise, int sunset, int timeZone) {
    now = DateTime.now().toUtc().add(Duration(seconds: timeZone));
    sunriseTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000)
        .toUtc()
        .add(Duration(seconds: timeZone));
    sunsetTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000)
        .toUtc()
        .add(Duration(seconds: timeZone));

    if (now!.isBefore(sunriseTime!)) return 0.0;
    if (now!.isAfter(sunsetTime!)) return 1.0;

    final totalDuration = sunsetTime!.difference(sunriseTime!).inSeconds;
    final elapsedDuration = now!.difference(sunriseTime!).inSeconds;
    return elapsedDuration / totalDuration;
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '$hours soat $minutes minut';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                _fetchWeather();
              },
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: _weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error fetching weather');
                } else if (weatherViewModel.weather == null) {
                  return const Text('Shahar topilmadi iltimos shahar kiriting');
                } else {
                  final weather = weatherViewModel.weather!;
                  final sunProgress = _calculateSunProgress(
                      weather.sunrise, weather.sunset, weather.timeZone);
                  final duration = sunsetTime!.difference(sunriseTime!);
                  final durationFormatter = _formatDuration(duration);
                  return Column(
                    children: [
                      Text(
                        weather.cityName,
                        style: const TextStyle(fontSize: 32),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${weather.temperature}',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            "°C",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weatherDict[weather.description] ??
                                "Tarjima qilinmagan",
                            style: const TextStyle(fontSize: 24),
                          ),
                          Image.network(
                            "https://openweathermap.org/img/wn/${weather.imageUrl}@2x.png",
                            width: 50.0,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              weather.wind.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Image.asset(
                            "icons/wind.png",
                            width: 50.0,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                          "Hozirigi soat: ${DateFormat("hh-mm").format(now!)}"),
                      const SizedBox(height: 40),
                      Text("Kunning uzunligi: $durationFormatter"),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: LinearPercentIndicator(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          animation: true,
                          lineHeight: 4.0,
                          animationDuration: 2000,
                          percent: sunProgress,
                          barRadius: const Radius.circular(16),
                          progressColor: Colors.blue,
                          backgroundColor: Colors.blue.withOpacity(0.2),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Quyosh chiqishi: ${DateFormat("hh-mm").format(sunriseTime!)}"),
                          Text(
                              "Quyosh Botishi: ${DateFormat("hh-mm").format(sunsetTime!)}"),
                        ],
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
