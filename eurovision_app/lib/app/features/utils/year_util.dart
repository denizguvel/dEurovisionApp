class YearUtil {
  static int getLatestAvailableYear() {
    final now = DateTime.now();
    return now.month >= 5 ? now.year : now.year - 1;
  }
}