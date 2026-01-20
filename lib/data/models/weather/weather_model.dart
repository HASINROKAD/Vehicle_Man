class WeatherModel {
  final String city;
  final double temp;
  final String condition;
  final String icon;

  WeatherModel({
    required this.city,
    required this.temp,
    required this.condition,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['location']['name'],
      temp: json['current']['temp_c'].toDouble(),
      condition: json['current']['condition']['text'],
      icon: json['current']['condition']['icon'],
    );
  }
}
