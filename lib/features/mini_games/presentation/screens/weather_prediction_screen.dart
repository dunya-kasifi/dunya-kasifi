import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class WeatherPredictionScreen extends StatefulWidget {
  const WeatherPredictionScreen({super.key});

  @override
  State<WeatherPredictionScreen> createState() =>
      _WeatherPredictionScreenState();
}

class _WeatherPredictionScreenState extends State<WeatherPredictionScreen> {
  int score = 0;
  int currentDay = 0;
  final int totalDays = 5;
  bool isGameOver = false;
  List<WeatherDay> weatherDays = [];
  List<WeatherType> userPredictions = [];
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    weatherDays = List.generate(totalDays, (index) {
      return WeatherDay(
        day: index + 1,
        temperature: Random().nextInt(30) + 5,
        weatherType:
            WeatherType.values[Random().nextInt(WeatherType.values.length)],
      );
    });
    userPredictions = List.filled(totalDays, WeatherType.sunny);
  }

  void _makePrediction(WeatherType prediction) {
    if (currentDay >= totalDays) return;

    setState(() {
      userPredictions[currentDay] = prediction;
      showResult = true;

      if (prediction == weatherDays[currentDay].weatherType) {
        score += 10;
      }

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            showResult = false;
            currentDay++;
            if (currentDay >= totalDays) {
              isGameOver = true;
            }
          });
        }
      });
    });
  }

  void _restartGame() {
    setState(() {
      score = 0;
      currentDay = 0;
      isGameOver = false;
      showResult = false;
      _initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hava Durumu Tahmini'),
        backgroundColor: Colors.blue[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _restartGame,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[100]!,
              Colors.blue[50]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Skor ve Gün Bilgisi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Skor: $score',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Gün ${currentDay + 1}/$totalDays',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                if (!isGameOver) ...[
                  // Tahmin Sonucu
                  if (showResult) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: userPredictions[currentDay] ==
                                weatherDays[currentDay].weatherType
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: userPredictions[currentDay] ==
                                  weatherDays[currentDay].weatherType
                              ? Colors.green
                              : Colors.red,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            userPredictions[currentDay] ==
                                    weatherDays[currentDay].weatherType
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: userPredictions[currentDay] ==
                                    weatherDays[currentDay].weatherType
                                ? Colors.green
                                : Colors.red,
                            size: 32,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            userPredictions[currentDay] ==
                                    weatherDays[currentDay].weatherType
                                ? 'Doğru Tahmin! +10 puan'
                                : 'Yanlış Tahmin! Doğru cevap: ${_getWeatherName(weatherDays[currentDay].weatherType)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: userPredictions[currentDay] ==
                                      weatherDays[currentDay].weatherType
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Hava Durumu Tahmin Kartları
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildWeatherCard(WeatherType.sunny),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildWeatherCard(WeatherType.cloudy),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildWeatherCard(WeatherType.rainy),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildWeatherCard(WeatherType.snowy),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  // Oyun Sonu Ekranı
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Oyun Bitti!',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Toplam Skorun: $score',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: _restartGame,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                            ),
                            child: const Text(
                              'Tekrar Oyna',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard(WeatherType type) {
    bool isSelected = type == userPredictions[currentDay];
    bool isCorrect = type == weatherDays[currentDay].weatherType;
    Color cardColor = Colors.white;

    if (showResult) {
      if (isSelected && !isCorrect) {
        cardColor = Colors.red.withOpacity(0.2);
      } else if (isCorrect) {
        cardColor = Colors.green.withOpacity(0.2);
      }
    }

    return Card(
      elevation: 4,
      child: InkWell(
        onTap: showResult ? null : () => _makePrediction(type),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: cardColor,
            border: showResult
                ? Border.all(
                    color: isSelected && !isCorrect
                        ? Colors.red
                        : isCorrect
                            ? Colors.green
                            : Colors.transparent,
                    width: 2,
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getWeatherIcon(type),
                size: 48,
                color: showResult && isSelected && !isCorrect
                    ? Colors.red
                    : showResult && isCorrect
                        ? Colors.green
                        : _getWeatherColor(type),
              ),
              const SizedBox(height: 8),
              Text(
                _getWeatherName(type),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: showResult && isSelected && !isCorrect
                      ? Colors.red
                      : showResult && isCorrect
                          ? Colors.green
                          : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getWeatherIcon(WeatherType type) {
    switch (type) {
      case WeatherType.sunny:
        return Icons.wb_sunny;
      case WeatherType.cloudy:
        return Icons.cloud;
      case WeatherType.rainy:
        return Icons.grain;
      case WeatherType.snowy:
        return Icons.ac_unit;
    }
  }

  Color _getWeatherColor(WeatherType type) {
    switch (type) {
      case WeatherType.sunny:
        return Colors.orange;
      case WeatherType.cloudy:
        return Colors.blueGrey;
      case WeatherType.rainy:
        return Colors.blue;
      case WeatherType.snowy:
        return Colors.lightBlue;
    }
  }

  String _getWeatherName(WeatherType type) {
    switch (type) {
      case WeatherType.sunny:
        return 'Güneşli';
      case WeatherType.cloudy:
        return 'Bulutlu';
      case WeatherType.rainy:
        return 'Yağmurlu';
      case WeatherType.snowy:
        return 'Karlı';
    }
  }
}

enum WeatherType {
  sunny,
  cloudy,
  rainy,
  snowy,
}

class WeatherDay {
  final int day;
  final int temperature;
  final WeatherType weatherType;

  WeatherDay({
    required this.day,
    required this.temperature,
    required this.weatherType,
  });
}
