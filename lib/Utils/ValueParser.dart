class ValueParser {
  static String distance(int meters) {
    if (meters >= 1000) {
      return (((meters / 1000) * 2).round() / 2).toString() + " km";
    } else {
      return meters.toString() + " m";
    }
  }
}
