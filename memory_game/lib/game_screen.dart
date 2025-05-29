import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'main.dart'; // to access ThemeController

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> imagePaths = [
    'assets/1.jpeg', 'assets/2.jpeg', 'assets/3.jpeg', 'assets/4.jpeg',
    'assets/5.jpeg', 'assets/6.jpeg', 'assets/7.jpeg', 'assets/8.jpeg',
  ];
  List<bool> revealed = List.filled(16, false);
  List<bool> matched = List.filled(16, false);
  List<String> gridImages = [];
  int? firstIndex;
  int score = 0;
  int timeLeft = 30;
  Timer? countdownTimer;
  bool gameEnded = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<int> topScores = [];

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    gridImages = List.from(imagePaths)..addAll(imagePaths);
    gridImages.shuffle(Random());
    revealed = List.filled(16, true);
    matched = List.filled(16, false);
    score = 0;
    gameEnded = false;
    timeLeft = 30;

    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft--;
      });
      if (timeLeft == 0) {
        timer.cancel();
        gameEnded = true;
        showResultDialog();
      }
    });

    Timer(Duration(seconds: 3), () {
      setState(() {
        revealed = List.filled(16, false);
      });
    });
  }

  void onTap(int index) {
    if (revealed[index] || matched[index]) return;

    setState(() {
      revealed[index] = true;
    });

    if (firstIndex == null) {
      firstIndex = index;
    } else {
      int secondIndex = index;
      if (gridImages[firstIndex!] == gridImages[secondIndex]) {
        setState(() {
          matched[firstIndex!] = true;
          matched[secondIndex] = true;
          score += 100;
        });
        _audioPlayer.play(AssetSource('sounds/match.mp3'));
        if (matched.every((m) => m)) {
          Future.delayed(Duration(milliseconds: 500), showResultDialog);
        }
      } else {
        _audioPlayer.play(AssetSource('sounds/mismatch.mp3'));
        Timer(Duration(seconds: 1), () {
          setState(() {
            revealed[firstIndex!] = false;
            revealed[secondIndex] = false;
          });
        });
      }
      firstIndex = null;
    }
  }

  void showResultDialog() {
    String message = '';
    if (score == 800) {
      message = '🏆 Winner!';
    } else if (score > 600) {
      message = '👏 Well Played!';
    } else if (score > 300) {
      message = '🙂 Nice Try!';
    } else {
      message = '🤔 Keep Practicing!';
    }

    _audioPlayer.play(AssetSource('sounds/gameover.mp3'));

    // Update leaderboard
    topScores.add(score);
    topScores.sort((a, b) => b.compareTo(a));
    if (topScores.length > 5) topScores = topScores.sublist(0, 5);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text("Game Over"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Score: $score\n$message"),
            SizedBox(height: 10),
            Text("🏅 Top Scores:"),
            ...topScores.map((s) => Text("- $s")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                startGame();
              });
            },
            child: Text("Play Again"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('MI 💙 - Score: $score | Time: $timeLeft'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeController?.isDarkTheme.value == true
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              themeController?.isDarkTheme.value =
                  !(themeController.isDarkTheme.value);
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: 16,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.grey[200],
              ),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: revealed[index] || matched[index]
                    ? Image.asset(
                        gridImages[index],
                        fit: BoxFit.cover,
                        key: ValueKey(gridImages[index]),
                      )
                    : Container(color: Colors.blue),
              ),
            ),
          );
        },
      ),
    );
  }
}
