import 'package:clima_weather_flutter/services/location.dart';
import 'package:clima_weather_flutter/services/networking.dart';

const String apiKey = '1d931b610ea125c7e78c075d7bfbe4a5';
const String openWeatherMapURL =
    'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    // Instantiate Location object
    Location location = Location();

    // Gather lat / long via getCurrentLocation()
    await location.getCurrentLocation();

    // Generate a Uri for API call
    var url = Uri.parse(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=imperial');

    // Instantiate NetworkHelper object with Uri
    NetworkHelper networkHelper = NetworkHelper(url);

    // Gather jsonDecoded weatherData
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    // Generate a Uri for API call
    var url = Uri.parse(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=imperial');

    var weatherData = await NetworkHelper(url).getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 70) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 60) {
      return 'Time for shorts and ๐';
    } else if (temp < 50) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
