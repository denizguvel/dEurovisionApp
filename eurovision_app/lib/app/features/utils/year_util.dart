/// Utility class that returns the latest available year.
/// Returns current year if after May, otherwise previous year.
class YearUtil {
  static int getLatestAvailableYear() {
    final now = DateTime.now();
    return now.month >= 5 ? now.year : now.year - 1;
  }
}