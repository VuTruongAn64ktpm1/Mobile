class SpamService {
  static final Set<String> _reportedSpam = {};

  static Future<bool> isSpam(String phoneNumber) async {
    return _reportedSpam.contains(phoneNumber);
  }

  static Future<void> reportSpam(String phoneNumber) async {
    _reportedSpam.add(phoneNumber);
  }
}
