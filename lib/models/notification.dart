class Notifications {
  String? name;
  String? time;
  bool? status;

  Notifications({this.name, this.time, this.status});

  Notifications.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = name;
    data['title'] = time;
    data['status'] = status;
    return data;
  }
}
