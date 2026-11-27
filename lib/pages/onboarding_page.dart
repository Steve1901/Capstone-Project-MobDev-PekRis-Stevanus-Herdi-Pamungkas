import 'package:flutter/material.dart';
import '../models/mood_type.dart';
import '../widgets/mood_face.dart';
import 'home_page.dart';

/// Satu elemen ilustrasi: lingkaran berwarna (color) atau wajah mood (mood).
/// x dan y adalah posisi dengan skala -1..1 di area ilustrasi.
class _Item {
  final double x, y, size;
  final Color? color;
  final int? mood;
  const _Item(this.x, this.y, this.size, {this.color, this.mood});
}

class _OnboardData {
  final String title;
  final String desc;
  final List<_Item> items;
  const _OnboardData(this.title, this.desc, this.items);
}

const _pages = [
  _OnboardData(
    'Kenali Setiap\nPerasaanmu',
    'Setiap mood yang kamu rasakan itu berharga. Catat, pahami, dan rayakan perjalanan emosimu.',
    [
      _Item(-1.0, -0.6, 250, color: Color(0xFFF277B0)),
      _Item(1.0, 0.4, 230, color: Color(0xFF4DC9B8)),
      _Item(-0.65, -0.45, 90, mood: 5),
      _Item(0.0, 0.0, 120, mood: 0),
      _Item(0.85, 0.5, 60, mood: 3),
    ],
  ),
  _OnboardData(
    'Catat Mood dalam\nHitungan Detik',
    'Pilih mood, tambahkan catatan singkat, dan selesai. Secepat itu untuk mengenal dirimu lebih baik.',
    [
      _Item(-1.1, 0.35, 210, color: Color(0xFF5B8DEF)),
      _Item(1.05, -0.55, 230, color: Color(0xFFF7C35F)),
      _Item(-0.45, -0.5, 80, mood: 3),
      _Item(-0.6, 0.3, 90, mood: 1),
      _Item(0.6, -0.45, 85, mood: 0),
      _Item(0.15, 0.6, 90, mood: 5),
    ],
  ),
  _OnboardData(
    'Temukan Pola\n& Pemicunya',
    'Lihat tren emosimu dari waktu ke waktu dan pahami apa yang memengaruhi harimu.',
    [
      _Item(-1.05, -0.1, 230, color: Color(0xFFA98BEB)),
      _Item(1.1, 0.65, 200, color: Color(0xFFEF6C57)),
      _Item(-0.7, -0.55, 62, mood: 0),
      _Item(0.0, -0.75, 70, mood: 1),
      _Item(0.7, -0.6, 70, mood: 2),
      _Item(-0.75, 0.25, 62, mood: 3),
      _Item(-0.1, 0.2, 80, mood: 4),
      _Item(0.6, 0.0, 62, mood: 5),
    ],
  ),
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  bool get _isLast => _index == _pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  void _next() {
    if (_isLast) {
      _goHome();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _goHome,
                child: const Text('Lewati', style: TextStyle(fontSize: 12)),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) {
                  final p = _pages[i];
                  return Column(
                    children: [
                      Expanded(child: _Illustration(p.items)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Text(
                              p.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              p.desc,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _index ? 22 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: i == _index ? scheme.primary : const Color(0xFFD9D9E3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: FilledButton(
                onPressed: _next,
                child: Text(_isLast ? 'Mulai Sekarang' : 'Lanjut'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Illustration extends StatelessWidget {
  final List<_Item> items;
  const _Illustration(this.items);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          for (final it in items)
            Align(
              alignment: Alignment(it.x, it.y),
              child: it.color != null
                  ? Container(
                      width: it.size,
                      height: it.size,
                      decoration: BoxDecoration(
                        color: it.color,
                        shape: BoxShape.circle,
                      ),
                    )
                  : MoodFace(moodTypes[it.mood!], size: it.size),
            ),
        ],
      ),
    );
  }
}