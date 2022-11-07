class Filter {
  int? code;
  Data? data;
  String? message;

  Filter({
    this.code,
    this.data,
    this.message,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        code: json['code'] ?? '',
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
        message: json['message'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  List<String>? listServices;
  List<String>? listDates;

  Data({
    this.listServices,
    this.listDates,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        listServices: json["listServices"] != null
            ? List<String>.from(json["listServices"].map((e) => e))
            : null,
        listDates: json["listDates"] != null
            ? List<String>.from(json["listDates"].map((e) => e))
            : null,
      );

  Map<String, dynamic> toMap() => {
        'listServices': listServices,
        'listDates': listDates,
      };
}
