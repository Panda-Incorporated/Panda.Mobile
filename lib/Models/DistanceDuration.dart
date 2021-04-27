class DistanceDuration {
  DistanceKind distanceKind = DistanceKind.km;
  getDistanceString() {
   String str = distanceKind.toString();
    return str.substring(str.indexOf(".")+1, str.length);
  }

  DurationKind durationKind = DurationKind.minutes;
  getDurationString() {
    String str = durationKind.toString();
    return str.substring(str.indexOf(".")+1, str.length);
  }

  getCombination(int distance, int duration) {
    return distance.toString() +" "+
        getDistanceString() +" in "+
        duration.toString() +" "+
        getDurationString();
  }
}

enum DurationKind {
  seconds,
  minutes,
  hours,
}
enum DistanceKind {
  m,
  km,
}
