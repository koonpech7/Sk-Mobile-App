class ListKey {
  int? id;
  String? title;
  bool? status;
  bool? iftailing;
  ListKey({this.id, this.title, this.status});

  ListKey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    iftailing = json['iftailing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['status'] = status;
    data['iftailing'] = iftailing;
    return data;
  }
}
