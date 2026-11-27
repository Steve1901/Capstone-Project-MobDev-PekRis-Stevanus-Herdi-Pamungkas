import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../models/mood_type.dart';
import '../services/mood_repository.dart';
import '../utils/date_helper.dart';
import '../widgets/mood_card.dart';
import '../widgets/mood_face.dart';
import 'add_mood_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openForm(BuildContext context, {MoodEntry? entry}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AddMoodPage(entry: entry)),
    );
  }

  Future<void> _confirmDelete(BuildContext context, MoodEntry entry) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus mood?'),
        content: const Text('Catatan mood ini akan dihapus permanen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await MoodRepository.delete(entry.key!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mood dihapus')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: MoodRepository.listenable,
          builder: (context, _, __) {
            final entries = MoodRepository.all();
            final streak = MoodRepository.streak(entries);

            // Kelompokkan per hari (urutan sudah terbaru dulu)
            final groups = <String, List<MoodEntry>>{};
            for (final e in entries) {
              groups.putIfAbsent(dayLabel(e.date), () => []).add(e);
            }

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
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
                if (streak > 0) ...[
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Chip(
                      label: Text('🔥 $streak hari berturut-turut mencatat mood'),
                      backgroundColor: scheme.primaryContainer,
                      side: BorderSide.none,
                    ),
                  ),
                ],
                if (entries.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        MoodFace(moodTypes[0], size: 80),
                        const SizedBox(height: 16),
                        const Text(
                          'Belum ada catatan mood',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tekan tombol + untuk mencatat perasaanmu.',
                          style: TextStyle(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  )
                else
                  for (final g in groups.entries) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 8),
                      child: Text(
                        g.key,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    for (final e in g.value)
                      MoodCard(
                        mood: moodTypes[e.mood],
                        time: formatTime(e.date),
                        note: e.note,
                        onEdit: () => _openForm(context, entry: e),
                        onDelete: () => _confirmDelete(context, e),
                      ),
                  ],
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}