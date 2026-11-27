import 'package:flutter/material.dart';
import '../main.dart';
import '../models/mood_entry.dart';
import '../models/mood_type.dart';
import '../services/mood_repository.dart';
import '../utils/date_helper.dart';
import '../widgets/mood_button.dart';

/// Halaman tambah mood. Kalau [entry] diisi, dipakai sebagai halaman edit.
class AddMoodPage extends StatefulWidget {
  final MoodEntry? entry;
  const AddMoodPage({super.key, this.entry});

  bool get isEdit => entry != null;

  @override
  State<AddMoodPage> createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  late int? _selected = widget.entry?.mood;
  late DateTime _date = widget.entry?.date ?? DateTime.now();
  late final TextEditingController _noteCtrl =
      TextEditingController(text: widget.entry?.note ?? '');

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      // Ganti tanggalnya saja, jam tetap
      setState(() {
        _date = DateTime(picked.year, picked.month, picked.day, _date.hour, _date.minute);
      });
    }
  }

  Future<void> _save() async {
    if (_selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih mood dulu ya')),
      );
      return;
    }

    final entry = MoodEntry(
      key: widget.entry?.key,
      mood: _selected!,
      note: _noteCtrl.text.trim(),
      date: _date,
    );

    if (widget.isEdit) {
      await MoodRepository.update(entry);
    } else {
      await MoodRepository.add(entry);
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(widget.isEdit ? 'Mood diperbarui' : 'Mood tersimpan')),
    );
    Navigator.of(context).pop();
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final dateText = isSameDay(_date, DateTime.now())
        ? 'Hari ini, ${formatDate(_date)}'
        : formatDate(_date);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Edit Mood' : 'Tambah Mood',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
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
                  Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: kBorder),
                    ),
                    child: InkWell(
                      onTap: _pickDate,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 18),
                            const SizedBox(width: 8),
                            Expanded(child: Text(dateText)),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _label('Bagaimana perasaanmu?'),
                  GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1.15,
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
                  TextField(
                    controller: _noteCtrl,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Ceritakan apa yang kamu rasakan...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: kBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: kBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: kPrimary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: FilledButton(
                onPressed: _save,
                child: const Text('Simpan Mood'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}