class CancelTicket {
  CancelTicket({
    this.code,
    this.data,
    this.message,
  });

  int? code;
  Data? data;
  String? message;

  factory CancelTicket.fromJson(Map<String, dynamic> json) => CancelTicket(
        code: json["code"],
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  int? ticketId;

  Data({
    this.ticketId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ticketId: json["ticketId"],
      );

  Map<String, dynamic> toMap() => {
        "ticketId": ticketId,
      };
}
