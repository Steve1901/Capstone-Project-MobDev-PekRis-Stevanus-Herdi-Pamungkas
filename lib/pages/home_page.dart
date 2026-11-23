import 'package:flutter/material.dart';
import '../models/mood_type.dart';
import '../widgets/mood_card.dart';
import 'add_mood_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Data dummy. Nanti diganti data asli dari Hive (final submission).
  static final _today = [
    (mood: moodTypes[5], time: '14:20', note: 'Dapat kabar baik dari klien'),
    (mood: moodTypes[3], time: '11:00', note: 'Meditasi pagi terasa menenangkan'),
    (mood: moodTypes[0], time: '08:30', note: 'Pagi yang cerah dan menyenangkan'),
  ];
  static final _yesterday = [
    (mood: moodTypes[1], time: '20:15', note: 'Kangen rumah tiba-tiba'),
    (mood: moodTypes[4], time: '09:00', note: 'Deadline bikin deg-degan'),
  ];

  void _openForm(BuildContext context, {bool isEdit = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AddMoodPage(isEdit: isEdit)),
    );
  }

  Widget _section(BuildContext context, String title,
      List<({MoodType mood, String time, String note})> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        for (final e in items)
          MoodCard(
            mood: e.mood,
            time: e.time,
            note: e.note,
            onEdit: () => _openForm(context, isEdit: true),
            onDelete: () {}, // TODO: hapus mood (final submission)
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, Stevanus 👋',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      const Text('Bagaimana perasaanmu hari ini?'),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: scheme.primaryContainer,
                  child: const Text('S'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                label: const Text('🔥 5 hari berturut-turut mencatat mood'),
                backgroundColor: scheme.primaryContainer,
                side: BorderSide.none,
              ),
            ),
            _section(context, 'Hari Ini', _today),
            _section(context, 'Kemarin', _yesterday),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}