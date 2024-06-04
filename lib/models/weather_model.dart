class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String imageUrl;
  final int sunset;
  final int sunrise;
  final double wind;
  final int timeZone;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.imageUrl,
    required this.sunrise,
    required this.sunset,
    required this.timeZone,
    required this.wind,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'],
      description: json['weather'][0]['main'],
      imageUrl: json['weather'][0]['icon'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      wind: json['wind']['speed'],
      timeZone: json['timezone'],
    );
  }
}
