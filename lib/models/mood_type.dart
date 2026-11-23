import 'package:flutter/material.dart';

/// Satu jenis mood (sesuai desain Figma: 6 mood).
class MoodType {
  final String emoji; // cadangan kalau gambar tidak ketemu
  final String label;
  final Color color;
  final String image; // path asset

  const MoodType(this.emoji, this.label, this.color, this.image);
}

// GANTI nama file di bawah sesuai nama file gambar kamu di assets/images/
const moodTypes = [
  MoodType('😊', 'Senang', Color(0xFFF7C35F), 'assets/images/senang.png'),
  MoodType('😢', 'Sedih', Color(0xFF5B8DEF), 'assets/images/sedih.png'),
  MoodType('😠', 'Marah', Color(0xFFEF6C57), 'assets/images/marah.png'),
  MoodType('😌', 'Tenang', Color(0xFF4DC9B8), 'assets/images/tenang.png'),
  MoodType('😰', 'Cemas', Color(0xFFA98BEB), 'assets/images/cemas.png'),
  MoodType('🤩', 'Bersemangat', Color(0xFFF277B0), 'assets/images/bersemangat.png'),
];