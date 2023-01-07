class Room {
  int? id;
  String? title;
  String? subtitle;
  bool? status;

  Room({this.id, this.title, this.subtitle, this.status});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['status'] = status;
    return data;
  }
}
