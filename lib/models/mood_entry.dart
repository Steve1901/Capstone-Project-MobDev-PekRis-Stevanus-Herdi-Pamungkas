/// Satu catatan mood yang disimpan di Hive.
class MoodEntry {
  final int? key; // key Hive (null kalau belum disimpan)
  final int mood; // index ke moodTypes
  final String note;
  final DateTime date;

  const MoodEntry({
    this.key,
    required this.mood,
    this.note = '',
    required this.date,
  });

  Map<String, dynamic> toMap() => {
        'mood': mood,
        'note': note,
        'date': date.toIso8601String(),
      };

  factory MoodEntry.fromMap(int key, Map map) => MoodEntry(
        key: key,
        mood: map['mood'] as int,
        note: (map['note'] ?? '') as String,
        date: DateTime.parse(map['date'] as String),
      );
}