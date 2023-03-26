// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

NotificationLog notificationFromJson(String str) =>
    NotificationLog.fromJson(json.decode(str));

String notificationToJson(NotificationLog data) => json.encode(data.toJson());

class NotificationLog {
  NotificationLog({
    required this.items,
    required this.page,
    required this.totalCount,
    required this.totalPages,
  });

  final List<Item> items;
  final int page;
  final int totalCount;
  final int totalPages;

  factory NotificationLog.fromJson(Map<String, dynamic> json) =>
      NotificationLog(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        page: json["page"],
        totalCount: json["total_count"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "page": page,
        "total_count": totalCount,
        "total_pages": totalPages,
      };
}

class Item {
  Item({
    required this.id,
    required this.personCount,
    required this.comOnCount,
    required this.accurency,
    required this.roomLabel,
    required this.reportTime,
    required this.reportDate,
    required this.image,
    required this.status,
    required this.lamp1Status,
    required this.lamp2Status,
    required this.lamp3Status,
    required this.lamp4Status,
    required this.lamp5Status,
    required this.lamp6Status,
    required this.doorStatus,
    required this.airStatus,
  });

  final int id;
  final int personCount;
  final int comOnCount;
  final String accurency;
  final String roomLabel;
  final String reportTime;
  final String reportDate;
  final String image;
  final String status;
  final String lamp1Status;
  final String lamp2Status;
  final String lamp3Status;
  final String lamp4Status;
  final String lamp5Status;
  final String lamp6Status;
  final String doorStatus;
  final String airStatus;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        personCount: json["person_count"],
        comOnCount: json["com_on_count"],
        accurency: json["accurency"],
        roomLabel: json["room_label"],
        reportTime: json["report_time"],
        reportDate: json["report_date"],
        image: json["image"],
        status: json["status"],
        lamp1Status: json["lamp_1_status"],
        lamp2Status: json["lamp_2_status"],
        lamp3Status: json["lamp_3_status"],
        lamp4Status: json["lamp_4_status"],
        lamp5Status: json["lamp_5_status"],
        lamp6Status: json["lamp_6_status"],
        doorStatus: json["door_status"],
        airStatus: json["air_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "person_count": personCount,
        "com_on_count": comOnCount,
        "accurency": accurency,
        "room_label": roomLabel,
        "report_time": reportTime,
        "report_date": reportDate,
        "image": image,
        "status": status,
        "lamp_1_status": lamp1Status,
        "lamp_2_status": lamp2Status,
        "lamp_3_status": lamp3Status,
        "lamp_4_status": lamp4Status,
        "lamp_5_status": lamp5Status,
        "lamp_6_status": lamp6Status,
        "door_status": doorStatus,
        "air_status": airStatus,
      };
}

// enum ReportDate { THE_26032023, THE_25032023, EMPTY }

// final reportDateValues = EnumValues({
//   "": ReportDate.EMPTY,
//   "25/03/2023": ReportDate.THE_25032023,
//   "26/03/2023": ReportDate.THE_26032023
// });

// enum Status { DETECTED }

// final statusValues = EnumValues({"detected": Status.DETECTED});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
