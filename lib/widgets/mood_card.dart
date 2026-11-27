import 'package:flutter/material.dart';
import '../models/mood_type.dart';
import 'mood_face.dart';

/// Kartu satu catatan mood di halaman utama.
class MoodCard extends StatelessWidget {
  final MoodType mood;
  final String time;
  final String note;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MoodCard({
    super.key,
    required this.mood,
    required this.time,
    this.note = '',
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final grey = Theme.of(context).colorScheme.onSurfaceVariant;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 12, right: 4),
        leading: MoodFace(mood, size: 40),
        title: Text(
          mood.label,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        subtitle: Text(
          note.isEmpty ? time : '$time · $note',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12, color: grey),
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, size: 20),
          onSelected: (value) {
            if (value == 'edit') onEdit?.call();
            if (value == 'delete') onDelete?.call();
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'delete', child: Text('Hapus')),
          ],
        ),
      ),
    );
  }
}