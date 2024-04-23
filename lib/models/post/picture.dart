class Picture {
  final int? pictureId;
  final String link;

  Picture({
    this.pictureId,
    required this.link,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      pictureId: json['picture_id'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'link': link,
    };

    if (pictureId != null) {
      map['picture_id'] = pictureId;
    }

    return map;
  }
}
