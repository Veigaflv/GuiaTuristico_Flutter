import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final double latitude;
  final double longitude;

  WeatherService({required this.latitude, required this.longitude});

  // usa o serviço METEO que foi sugerido no enunciado
  Future<Map<String, dynamic>?> fetchCurrentWeather() async {
    final url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //a função decode converte Json em Map<String, dynamic> --> dynamic porque podem ser de vários tipos diferentes
      final data = json.decode(response.body);
      return data['current_weather'];
    } else {
      return null;
    }
  }
}
