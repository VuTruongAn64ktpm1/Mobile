import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlockService {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static String? get _uid => _auth.currentUser?.uid;

  static DocumentReference<Map<String, dynamic>> _ref(String uid) {
    return _db.collection('users').doc(uid);
  }

  // ===== KEYS LOCAL =====
  static const _kPhones = 'blocked_phones';
  static const _kSeries = 'blocked_series';
  static const _kNames = 'blocked_names';
  static const _kCountries = 'blocked_countries';

  /// ===== INIT (GỌI SAU LOGIN) =====
  static Future<void> syncFromFirestore() async {
    final uid = _uid;
    if (uid == null) return;

    final snap = await _ref(uid).get();
    if (!snap.exists) return;

    final data = snap.data()?['blocks'];
    if (data == null) return;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_kPhones, List<String>.from(data['phones'] ?? []));
    await prefs.setStringList(_kSeries, List<String>.from(data['series'] ?? []));
    await prefs.setStringList(_kNames, List<String>.from(data['names'] ?? []));
    await prefs.setStringList(_kCountries, List<String>.from(data['countries'] ?? []));
  }

  /// ===== SAVE FIRESTORE =====
  static Future<void> _saveToFirestore() async {
    final uid = _uid;
    if (uid == null) return;

    final prefs = await SharedPreferences.getInstance();

    await _ref(uid).set({
      'blocks': {
        'phones': prefs.getStringList(_kPhones) ?? [],
        'series': prefs.getStringList(_kSeries) ?? [],
        'names': prefs.getStringList(_kNames) ?? [],
        'countries': prefs.getStringList(_kCountries) ?? [],
      },
      'updatedAt': Timestamp.now(),
    }, SetOptions(merge: true));
  }

  /// ===== LOCAL HELPERS =====
  static Future<List<String>> _get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  static Future<void> _add(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    if (!list.contains(value)) {
      list.add(value);
      await prefs.setStringList(key, list);
      await _saveToFirestore(); // ⭐ SYNC
    }
  }

  static Future<void> _remove(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    list.remove(value);
    await prefs.setStringList(key, list);
    await _saveToFirestore(); // ⭐ SYNC
  }

  /// ===== API GIỮ NGUYÊN CHO UI =====
  static Future<void> blockPhone(String v) => _add(_kPhones, v);
  static Future<void> blockSeries(String v) => _add(_kSeries, v);
  static Future<void> blockName(String v) => _add(_kNames, v.toLowerCase());
  static Future<void> blockCountry(String v) => _add(_kCountries, v);

  static Future<void> unblockPhone(String v) => _remove(_kPhones, v);
  static Future<void> unblockSeries(String v) => _remove(_kSeries, v);
  static Future<void> unblockName(String v) => _remove(_kNames, v.toLowerCase());
  static Future<void> unblockCountry(String v) => _remove(_kCountries, v);

  static Future<List<String>> getBlockedPhones() => _get(_kPhones);
  static Future<List<String>> getBlockedSeries() => _get(_kSeries);
  static Future<List<String>> getBlockedNames() => _get(_kNames);
  static Future<List<String>> getBlockedCountries() => _get(_kCountries);

  /// ===== CHECK DÙNG TRONG CallFilter =====
  static Future<bool> isBlocked({
    required String phone,
    String? name,
  }) async {
    final phones = await getBlockedPhones();
    if (phones.contains(phone)) return true;

    final series = await getBlockedSeries();
    for (final s in series) {
      if (phone.startsWith(s)) return true;
    }

    final countries = await getBlockedCountries();
    for (final c in countries) {
      if (phone.startsWith(c)) return true;
    }

    if (name != null) {
      final names = await getBlockedNames();
      if (names.contains(name.toLowerCase())) return true;
    }

    return false;
  }
}
