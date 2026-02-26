import 'package:flutter/material.dart';

void showWinDialog(BuildContext context, provider) {
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Congratulations!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: ${provider.score} in ${provider.attempts} attempts!',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              provider.resetGame();
            },
            child: const Text('Play Again'),
          ),
        ],
      );
    },
  );
}


void showLoseDialog(BuildContext context, provider) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'You Lose!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You ran out of attempts.\nBetter luck next time!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              provider.resetGame();
            },
            child: const Text('Try Again'),
          ),
        ],
      );
    },
  );
}

