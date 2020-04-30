import 'networking.dart';
import 'location.dart';
import '../key.dart';

class WeatherModel {
  final String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather?units=imperial&';

  Future<dynamic> getCityData({String city}) async {
    Networker networker = Networker(url: baseUrl + 'q=$city&appid=$apiKey');
    var data = await networker.get();

    return data;
  }

  Future<dynamic> getWeatherData() async {
    CustomLocation location = CustomLocation();
    await location.getCurrentLocation();

    Networker networker = Networker(
        url: baseUrl +
            'lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');
    var data = await networker.get();
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 85) {
      return 'It\'s 🍦 time';
    } else if (temp > 60) {
      return 'Time for shorts and 👕';
    } else if (temp < 60) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
