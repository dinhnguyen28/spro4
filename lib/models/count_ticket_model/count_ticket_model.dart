class Count {
  int? code;
  String? message;
  Data? data;

  Count({
    this.code,
    this.message,
    this.data,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        code: json["code"] ?? "",
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? deletedByRu;
  int? completed;
  int? shared;
  int? closed;
  int? draft;
  int? cancel;
  int? processing;
  int? opened;

  Data({
    this.deletedByRu,
    this.completed,
    this.shared,
    this.closed,
    this.draft,
    this.cancel,
    this.processing,
    this.opened,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        deletedByRu: json["DELETED_BY_RU"],
        completed: json["COMPLETED"],
        shared: json["SHARED"],
        closed: json["CLOSED"],
        draft: json["DRAFT"],
        cancel: json["CANCEL"],
        processing: json["PROCESSING"],
        opened: json["OPENED"],
      );

  Map<String, dynamic> toJson() => {
        "DELETED_BY_RU": deletedByRu,
        "COMPLETED": completed,
        "SHARED": shared,
        "CLOSED": closed,
        "DRAFT": draft,
        "CANCEL": cancel,
        "PROCESSING": processing,
        "OPENED": opened,
      };
}
