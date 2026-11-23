import 'package:flutter/material.dart';
import '../models/mood_type.dart';
import '../widgets/mood_face.dart';

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
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: MoodFace(mood, size: 44),
        title: Text(mood.label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          note.isEmpty ? time : '$time · $note',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton<String>(
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