import 'package:flutter/material.dart';
import '../models/mood_type.dart';
import '../widgets/mood_button.dart';

/// Halaman tambah mood. Kalau [isEdit] true, dipakai sebagai halaman edit.
class AddMoodPage extends StatefulWidget {
  final bool isEdit;
  const AddMoodPage({super.key, this.isEdit = false});

  @override
  State<AddMoodPage> createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  late int? _selected = widget.isEdit ? 0 : null;

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: Theme.of(context).textTheme.bodySmall),
      );

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.isEdit ? 'Edit Mood' : 'Tambah Mood',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _label('Tanggal'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: scheme.outlineVariant),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 18),
                        SizedBox(width: 8),
                        Expanded(child: Text('Hari ini, 23 November 2026')),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _label('Bagaimana perasaanmu?'),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      for (var i = 0; i < moodTypes.length; i++)
                        MoodButton(
                          mood: moodTypes[i],
                          selected: _selected == i,
                          onTap: () => setState(() => _selected = i),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _label('Catatan (opsional)'),
                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Ceritakan apa yang kamu rasakan...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Simpan Mood'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}