class ValueParser {
  static String distance(int meters) {
    if (meters >= 1000) {
      return (((meters / 1000) * 2).round() / 2).toString() + " km";
    } else {
      return meters.toString() + " m";
    }
  }

  static String distanceDouble(double meters) {
    if (meters >= 1000) {
      return (((meters / 1000) * 2).round() / 2).toString() + " km";
    } else {
      return meters.toString() + " m";
    }
  }

  static String distanceDoublePrecise(double meters) {
    if (meters >= 1000) {
      return (meters / 1000.0).toStringAsFixed(2) + " km";
    } else {
      return meters.toString() + " m";
    }
  }

  static String duration(Duration duration) {
    if (duration.inDays.round() > 0) {
      if (duration.inDays > 1)
        return duration.inDays.toString() + " dagen";
      else
        return duration.inDays.toString() + " dag";
    } else if (duration.inHours.round() > 0) {
      return duration.inHours.toString() + " uur";
    } else if (duration.inMinutes.round() > 0) {
      if (duration.inMinutes > 1)
        return duration.inMinutes.toString() + " minuten";
      else
        return duration.inMinutes.toString() + " minuut";
    } else if (duration.inSeconds.round() > 0) {
      if (duration.inSeconds > 1)
        return duration.inSeconds.toString() + " seconden";
      else
        return duration.inSeconds.toString() + " seconde";
    } else {
      return duration.toString();
    }
  }
}
