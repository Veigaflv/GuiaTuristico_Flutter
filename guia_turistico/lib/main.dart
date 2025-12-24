import 'package:flutter/material.dart';
import 'package:guia_turistico/services/weather_service.dart';
import 'package:guia_turistico/utils/weather_utils.dart';
import 'package:guia_turistico/screens/categorias_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guia Turístico',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

// -------------------- HomePage --------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? temperature;
  int? weatherCode;
  String weatherDescription = "A carregar...";
  IconData weatherIcon = Icons.help_outline;

  final String cityName = 'Cidade da Praia';
  final double latitude = 14.933;
  final double longitude = -23.513;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final service = WeatherService(latitude: latitude, longitude: longitude);
    final data = await service.fetchCurrentWeather();

    if (data != null) {
      setState(() {
        temperature = data['temperature'];
        weatherCode = data['weathercode'];
        weatherDescription = getWeatherDescription(weatherCode!);
        weatherIcon = getWeatherIcon(weatherCode!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/Praia.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cityName,
                  style: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                if (temperature != null)
                  Column(
                    children: [
                      Icon(
                        weatherIcon,
                        size: 64,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$temperature°C',
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        weatherDescription,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  )
                else
                  const CircularProgressIndicator(color: Colors.white),
                const SizedBox(height: 32),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CategoriasScreen(),
                        ),
                      );
                    },
                  child: const Text('Explorar categorias'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


