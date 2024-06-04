import 'package:flutter/material.dart';
import 'package:lesson50/models/weather_model.dart';
import 'package:lesson50/services/weather_http_service.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather? _weather;
  Weather? get weather => _weather;


  final WeatherService _weatherService = WeatherService();

  Future<void> fetchWeather(String cityName) async {
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(cityName);
      print(_weather);
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
  
}


