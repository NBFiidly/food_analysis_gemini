# 🔐 Struktur Folder Aman untuk API Key

## Deskripsi Perubahan

Struktur baru menggunakan `.env` file untuk menyimpan API key secara aman, bukan hardcoded di dalam file Dart.

## Struktur Folder Baru

```
food_analysis_gemini/
├── .env                          # ❌ JANGAN COMMIT (berisi API key asli)
├── .env.example                  # ✅ COMMIT (template tanpa nilai asli)
├── .gitignore                    # ✅ File diperbaharui untuk ignore .env
├── lib/
│   ├── main.dart                 # ✅ Updated: load .env
│   ├── core/
│   │   └── constants/
│   │       └── api_key.dart      # ✅ Updated: baca dari .env
│   └── services/
│       └── gemini_services.dart  # ✅ Tetap sama (ambil dari getter)
├── pubspec.yaml                  # ✅ Updated: tambah flutter_dotenv
└── ...
```

## Perubahan yang Dilakukan

### 1. **`pubspec.yaml`**

- ✅ Tambah dependency: `flutter_dotenv: ^5.1.0`
- ✅ Tambah `.env` ke `flutter.assets`

### 2. **`.env` (ROOT FOLDER)**

```
GEMINI_API_KEY=YOUR_GEMINI_API_KEY_HERE
```

**⚠️ PENTING**: File ini berisi API key asli, JANGAN di-commit ke Git!

### 3. **`.env.example` (ROOT FOLDER)**

```
# Gemini API Configuration
# Dapatkan API key dari https://aistudio.google.com/app/apikey
GEMINI_API_KEY=YOUR_GEMINI_API_KEY_HERE
```

**✅ File ini boleh di-commit** - berfungsi sebagai template

### 4. **`.gitignore`**

Ditambah:

```
# Environment variables
.env
.env.local
.env.*.local
```

### 5. **`lib/main.dart`**

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();  // Load .env file
  runApp(const MainApp());
}
```

### 6. **`lib/core/constants/api_key.dart`**

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

String get apiKey {
  final key = dotenv.env['GEMINI_API_KEY'];
  if (key == null || key.isEmpty) {
    throw Exception('GEMINI_API_KEY tidak ditemukan di .env file');
  }
  return key;
}
```

## Keamanan: Sebelum vs Sesudah

### ❌ SEBELUM (Tidak Aman)

```dart
// Hardcoded di file yang bisa di-commit
const String apiKey = 'YOUR_GEMINI_API_KEY_HERE';
```

- ⚠️ API key terlihat di version control
- ⚠️ Riwayat Git akan menyimpan key selamanya
- ⚠️ Risiko terekspos jika repository dipublikkan

### ✅ SESUDAH (Aman)

```
.env file (tidak di-commit):
GEMINI_API_KEY=YOUR_GEMINI_API_KEY_HERE

.env.example (di-commit):
GEMINI_API_KEY=YOUR_GEMINI_API_KEY_HERE
```

- ✅ API key hanya di mesin lokal
- ✅ Tidak ada di version control
- ✅ Aman untuk publik repository
- ✅ Tim bisa share `.env.example` untuk setup

## Instruksi Setup untuk Tim

### 1️⃣ First Time Setup

```bash
# Clone repository
git clone <repo-url>
cd food_analysis_gemini

# Copy template ke file .env
cp .env.example .env

# Edit .env dan ganti YOUR_GEMINI_API_KEY_HERE dengan API key asli
nano .env
# atau gunakan text editor favorit
```

### 2️⃣ Jalankan Aplikasi

```bash
flutter pub get
flutter run
```

## Best Practices ✨

1. **Jangan pernah commit `.env`**
   - `.gitignore` sudah dikonfigurasi

2. **Selalu update `.env.example`**
   - Jika menambah variable environment baru
   - Tapi JANGAN include nilai asli

3. **Untuk CI/CD Pipeline**
   - Set environment variables di CI/CD settings
   - Jangan hardcode di file

4. **Untuk Development Local**
   - Setiap developer membuat `.env` masing-masing
   - Jangan di-share via Slack/Email

## Keamanan Tambahan (Opsional)

Untuk keamanan maksimal:

### A. Gunakan Secret Manager (Production)

```dart
// Contoh dengan flutter_secure_storage
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();
final apiKey = await secureStorage.read(key: 'gemini_api_key');
```

### B. Backend API + Proxy

- Simpan API key di backend (tidak di frontend)
- Frontend komunikasi ke backend saja
- Backend mengelola Gemini API

## Troubleshooting

**Error: "GEMINI_API_KEY tidak ditemukan"**

- ✅ Pastikan file `.env` ada di root folder
- ✅ Pastikan `dotenv.load()` dipanggil di main.dart
- ✅ Check file `.env` berisi: `GEMINI_API_KEY=xxxxx`

**Error: "Unexpected result of environment"**

- ✅ Run: `flutter clean`
- ✅ Run: `flutter pub get`
- ✅ Run: `flutter run`

---

**✨ Setup selesai! API key Anda sekarang aman disimpan.**
