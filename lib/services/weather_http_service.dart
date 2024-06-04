import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lesson50/models/weather_model.dart';

class WeatherService {
  final String apiKey = '3e9ffa11fbf6ddf965a955282dd45513';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    print(response.body);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
