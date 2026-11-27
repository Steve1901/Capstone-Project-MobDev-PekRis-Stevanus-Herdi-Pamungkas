import 'package:flutter/material.dart';
import '../models/mood_type.dart';
import 'mood_face.dart';

/// Kotak pilihan mood: wajah + label. Saat dipilih, latar berwarna mood
/// dan label menjadi tebal (seperti desain Figma).
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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: selected ? mood.color : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? mood.color : const Color(0xFFE6E6EE),
          ),
          boxShadow: selected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha(12),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MoodFace(mood, size: 40),
            const SizedBox(height: 8),
            Text(
              mood.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}