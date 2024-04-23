class AppointementUpdateRequest {
  final String? date;
  final String? time;
  final String? state;

  AppointementUpdateRequest({
    this.date,
    this.time,
    this.state,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date ?? '',
      'time': time ?? '',
      '_status': state ?? '',
    };
  }
}
