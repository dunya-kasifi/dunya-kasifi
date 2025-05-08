import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';

class SkyMathRaceScreen extends StatefulWidget {
  const SkyMathRaceScreen({super.key});

  @override
  State<SkyMathRaceScreen> createState() => _SkyMathRaceScreenState();
}

class _SkyMathRaceScreenState extends State<SkyMathRaceScreen> {
  int score = 0;
  int currentQuestionIndex = 0;
  String currentQuestion = '';
  int correctAnswer = 0;
  List<int> options = [];
  final Random random = Random();
  bool showConfetti = false;
  bool isGameOver = false;
  final int totalQuestions = 10;
  bool isProcessingAnswer =
      false; // Cevap işlenirken yeni cevap verilmesini engellemek için

  @override
  void initState() {
    super.initState();
    generateNewQuestion();
  }

  void generateNewQuestion() {
    try {
      // Daha basit sayılar ve sadece toplama/çıkarma
      final num1 = random.nextInt(10) + 1; // 1-10 arası
      final num2 = random.nextInt(10) + 1; // 1-10 arası
      final operation = random.nextInt(2); // 0: toplama, 1: çıkarma

      // Çıkarma işleminde büyük sayıdan küçük sayıyı çıkar
      if (operation == 1 && num1 < num2) {
        currentQuestion = '$num2 - $num1 = ?';
        correctAnswer = num2 - num1;
      } else {
        currentQuestion = '$num1 + $num2 = ?';
        correctAnswer = num1 + num2;
      }

      // Seçenekleri oluştur
      final Set<int> uniqueOptions = {correctAnswer};
      while (uniqueOptions.length < 4) {
        final option = correctAnswer + random.nextInt(5) - 2;
        if (option > 0 && option <= 20) {
          uniqueOptions.add(option);
        }
      }
      options = uniqueOptions.toList()..shuffle();
    } catch (e) {
      // Hata durumunda varsayılan değerler
      currentQuestion = '1 + 1 = ?';
      correctAnswer = 2;
      options = [1, 2, 3, 4];
    }
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.celebration,
                  size: 80,
                  color: Colors.amber,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tebrikler! 🎉',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Toplam Puanın: $score',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Doğru Cevap: ${score ~/ 10}/$totalQuestions',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context); // Dialog'u kapat
                        restartGame();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Tekrar Oyna'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.back(); // Ana sayfaya dön
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('Ana Sayfa'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> checkAnswer(int selectedAnswer) async {
    if (isProcessingAnswer) return;

    setState(() {
      isProcessingAnswer = true;
    });

    try {
      if (selectedAnswer == correctAnswer) {
        setState(() {
          score += 10;
          currentQuestionIndex++;
          showConfetti = true;
        });

        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          setState(() {
            showConfetti = false;
            if (currentQuestionIndex >= totalQuestions) {
              isGameOver = true;
              showGameOverDialog(); // Oyun bittiğinde dialog'u göster
            } else {
              generateNewQuestion();
            }
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tekrar dene! Sen yapabilirsin! 💪'),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bir hata oluştu, lütfen tekrar deneyin.'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isProcessingAnswer = false;
        });
      }
    }
  }

  void restartGame() {
    if (isProcessingAnswer)
      return; // Oyun yeniden başlatılırken cevap işleniyorsa engelle

    setState(() {
      score = 0;
      currentQuestionIndex = 0;
      isGameOver = false;
      showConfetti = false;
      isProcessingAnswer = false;
      generateNewQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!isGameOver) {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Oyundan Çık'),
              content: const Text('Oyundan çıkmak istediğinize emin misiniz?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Hayır'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Evet'),
                ),
              ],
            ),
          );
          return shouldPop ?? false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gökyüzü Matematik Yarışı'),
          backgroundColor: Colors.lightBlue,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '$score',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            // Arka plan
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.lightBlue, Colors.blue],
                ),
              ),
              child: Center(
                child: isGameOver
                    ? _buildGameOverScreen()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Bulut şeklinde soru numarası
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Soru ${currentQuestionIndex + 1}/$totalQuestions',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Soru kutusu
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.cloud,
                                  size: 40,
                                  color: Colors.blue,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  currentQuestion,
                                  style: const TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Cevap seçenekleri
                          ...options.map((option) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ElevatedButton(
                                  onPressed: isProcessingAnswer
                                      ? null
                                      : () => checkAnswer(option),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 15,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    option.toString(),
                                    style: const TextStyle(
                                      fontSize: 28,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
              ),
            ),
            // Konfeti efekti
            if (showConfetti)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.celebration,
                      size: 100,
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Harika! 🌟',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameOverScreen() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.celebration,
            size: 100,
            color: Colors.amber,
          ),
          const SizedBox(height: 20),
          const Text(
            'Tebrikler! 🎉',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  'Toplam Puanın: $score',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Doğru Cevap: ${score ~/ 10}/$totalQuestions',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: isProcessingAnswer ? null : restartGame,
            icon: const Icon(Icons.refresh),
            label: const Text('Tekrar Oyna'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
