import 'package:flutter/material.dart';

class PokemonLoadError extends StatelessWidget {
  const PokemonLoadError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 48),
          Text(
            message,
            style: const TextStyle(color: Colors.red, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
            onPressed: onRetry,
            child: const Text(
              'Retry',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
