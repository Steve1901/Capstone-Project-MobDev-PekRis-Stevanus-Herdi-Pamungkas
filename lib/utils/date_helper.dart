const _bulan = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
];

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Contoh: 23 November 2026
String formatDate(DateTime d) => '${d.day} ${_bulan[d.month - 1]} ${d.year}';

/// Contoh: 08:05
String formatTime(DateTime d) =>
    '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

/// Judul grup di halaman utama: Hari Ini, Kemarin, atau tanggal lengkap.
String dayLabel(DateTime d) {
  final now = DateTime.now();
  if (isSameDay(d, now)) return 'Hari Ini';
  if (isSameDay(d, DateTime(now.year, now.month, now.day - 1))) return 'Kemarin';
  return formatDate(d);
}