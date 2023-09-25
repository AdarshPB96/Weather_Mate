class CurrentWeatherModel {
  String place;
  String main;
  String description;
  num temperature;
  num feelsLike;
  num minTemp;
  num maxTemp;
  num pressure;
  num visibility;
  num windSpeed;

  CurrentWeatherModel(
      {required this.place,
        required this.main,
      required this.description,
      required this.temperature,
      required this.feelsLike,
      required this.minTemp,
      required this.maxTemp,
      required this.pressure,
      required this.visibility,
      required this.windSpeed});

  factory CurrentWeatherModel.froJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      place: json["name"],
        main: json["weather"][0]["main"],
        description: json["weather"][0]["description"],
        temperature: json["main"]["temp"] - 273.15 as num,
        feelsLike: json["main"]["feels_like"]- 273.15 as num,
        minTemp: json["main"]["temp_min"] - 273.15 as num,
        maxTemp: json["main"]["temp_max"]- 273.15 as num,
        pressure: json["main"]["pressure"]as num,
        visibility: json["visibility"]as num,
        windSpeed: json["wind"]["speed"]as num);
  }
}
