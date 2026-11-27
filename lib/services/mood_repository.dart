import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/mood_entry.dart';

/// Semua akses ke Hive (create, read, update, delete) lewat sini.
class MoodRepository {
  static late Box _box;
  static late Box _settings;

  /// Dipanggil sekali di main() sebelum runApp.
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('moods');
    _settings = await Hive.openBox('settings');
  }

  /// Dipakai ValueListenableBuilder supaya UI otomatis update.
  static ValueListenable<Box> get listenable => _box.listenable();

  // READ: semua mood, terbaru di atas
  static List<MoodEntry> all() {
    final list = _box.keys
        .map((k) => MoodEntry.fromMap(k as int, _box.get(k) as Map))
        .toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  // CREATE
  static Future<void> add(MoodEntry e) => _box.add(e.toMap());

  // UPDATE
  static Future<void> update(MoodEntry e) => _box.put(e.key, e.toMap());

  // DELETE
  static Future<void> delete(int key) => _box.delete(key);

  /// Jumlah hari berturut-turut yang ada catatan mood (sampai hari ini/kemarin).
  static int streak(List<MoodEntry> entries) {
    final days = entries
        .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
        .toSet();
    final now = DateTime.now();
    var day = DateTime(now.year, now.month, now.day);
    if (!days.contains(day)) day = DateTime(day.year, day.month, day.day - 1);
    var count = 0;
    while (days.contains(day)) {
      count++;
      day = DateTime(day.year, day.month, day.day - 1);
    }
    return count;
  }

  // Onboarding cukup tampil sekali
  static bool get onboardingSeen =>
      _settings.get('onboardingSeen', defaultValue: false) as bool;
  static Future<void> setOnboardingSeen() =>
      _settings.put('onboardingSeen', true);
}