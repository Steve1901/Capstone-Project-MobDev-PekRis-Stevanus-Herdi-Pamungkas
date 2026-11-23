import 'package:flutter/material.dart';
import '../models/mood_type.dart';

/// Wajah mood dari gambar asset. Kalau gambar tidak ketemu, tampil emoji.
class MoodFace extends StatelessWidget {
  final MoodType mood;
  final double size;

  const MoodFace(this.mood, {super.key, this.size = 44});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      mood.image,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stack) => Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: mood.color,
          borderRadius: BorderRadius.circular(size * 0.28),
        ),
        child: Text(mood.emoji, style: TextStyle(fontSize: size * 0.5)),
      ),
    );
  }
}