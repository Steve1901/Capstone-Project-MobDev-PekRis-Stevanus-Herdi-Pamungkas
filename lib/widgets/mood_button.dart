import 'package:flutter/material.dart';
import '../models/mood_type.dart';
import '../widgets/mood_face.dart';

/// Tombol pilihan mood (emoji + label).
class MoodButton extends StatelessWidget {
  final MoodType mood;
  final bool selected;
  final VoidCallback? onTap;

  const MoodButton({
    super.key,
    required this.mood,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: selected ? mood.color : scheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? mood.color : scheme.outlineVariant,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MoodFace(mood, size: 40),
            const SizedBox(height: 6),
            Text(
              mood.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? mood.color.withAlpha(90) : scheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}