class MyTicket {
  int? code;
  Data? data;
  String? message;

  MyTicket({
    this.code,
    this.message,
    this.data,
  });

  factory MyTicket.fromJson(Map<String, dynamic> json) => MyTicket(
        code: json["code"] ?? "",
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  int? page;
  int? limit;
  String? search;
  dynamic sortBy;
  dynamic sortType;
  int? size;
  List<Content>? content;
  int? totalElements;
  int? number;
  int? numberOfElements;
  int? totalPages;
  bool? first;
  bool? last;

  Data({
    this.page,
    this.limit,
    this.search,
    this.sortBy,
    this.sortType,
    this.size,
    this.content,
    this.totalElements,
    this.number,
    this.numberOfElements,
    this.totalPages,
    this.first,
    this.last,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json['page'],
        limit: json['limit'],
        search: json['search'],
        sortBy: json['sortBy'],
        sortType: json['sortType'],
        size: json['size'],
        content: json["content"] != null
            ? List<Content>.from(
                json["content"].map((e) => Content.fromJson(e)))
            : null,
        totalElements: json['totalElements'],
        number: json['number'],
        numberOfElements: json['numberOfElements'],
        totalPages: json['totalPages'],
        first: json['first'],
        last: json['last'],
      );
  Map<String, dynamic> toMap() => {
        "page": page,
        "limit": limit,
        "search": search,
        "sortBy": sortBy,
        "sortType": sortType,
        "size": size,
        "content": content,
        "totalElements": totalElements,
        "number": number,
        "numberOfElements": numberOfElements,
        "totalPages": totalPages,
        "first": first,
        "last": last,
      };
}

class Content {
  String? ticketTitle;
  int? ticketStartedTime;
  int? ticketFinishTime;
  int? ticketCreatedTime;
  int? ticketEndTime;
  String? procServiceName;
  String? endKey;
  String? ticketStartUserId;
  List<TicketTaskDtoList>? ticketTaskDtoList;
  String? ticketProcDefId;
  String? ticketStatus;
  double? ticketRating;
  // Null? ticketEditTime;
  // Null? ticketClosedTime;
  // Null? comment;
  int? id;
  int? ticketCanceledTime;
  int? serviceId;
  double? slaFinish;
  // Null? cancelReason;
  String? ticketId;
  double? slaResponse;

  Content({
    this.ticketTitle,
    this.ticketStartedTime,
    this.ticketFinishTime,
    this.ticketCreatedTime,
    this.ticketEndTime,
    this.procServiceName,
    this.endKey,
    this.ticketStartUserId,
    this.ticketTaskDtoList,
    this.ticketProcDefId,
    this.ticketStatus,
    this.ticketRating,
    // this.ticketEditTime,
    // this.ticketClosedTime,
    // this.comment,
    required this.id,
    this.ticketCanceledTime,
    this.serviceId,
    this.slaFinish,
    // this.cancelReason,
    this.ticketId,
    this.slaResponse,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        ticketTitle: json['ticketTitle'],
        ticketStartedTime: json['ticketStartedTime'],
        ticketFinishTime: json['ticketFinishTime'],
        ticketCreatedTime: json['ticketCreatedTime'],
        // ticketEndTime: json['ticketEndTime'],
        procServiceName: json['procServiceName'],
        endKey: json['endKey'],
        ticketStartUserId: json['ticketStartUserId'],

        ticketTaskDtoList: json["ticketTaskDtoList"] == null
            ? null
            : List<TicketTaskDtoList>.from(json["ticketTaskDtoList"]
                .map((e) => TicketTaskDtoList.fromJson(e))),

        ticketProcDefId: json['ticketProcDefId'],
        ticketStatus: json['ticketStatus'],
        ticketRating: json['ticketRating'],
        // ticketEditTime: json['ticketEditTime'],
        // ticketClosedTime: json['ticketClosedTime'],
        // comment: json['comment'],
        id: json['id'],
        ticketCanceledTime: json['ticketCanceledTime'],
        serviceId: json['serviceId'],
        slaFinish: json['slaFinish'],
        // cancelReason: json['cancelReason'],
        ticketId: json['ticketId'],
        slaResponse: json['slaResponse'],
      );

  Map<String, dynamic> toMap() => {
        "ticketTitle": ticketTitle,
        "ticketStartedTime": ticketStartedTime,
        // "ticketFinishTime": ticketFinishTime,
        "ticketCreatedTime": ticketCreatedTime,
        // "ticketEndTime": ticketEndTime,
        "procServiceName": procServiceName,
        "endKey": endKey,
        "ticketStartUserId": ticketStartUserId,
        // "ticketTaskDtoList": ticketTaskDtoList,
        "ticketProcDefId": ticketProcDefId,
        "ticketStatus": ticketStatus,
        "ticketRating": ticketRating,
        // "ticketEditTime": ticketEditTime,
        // "ticketClosedTime": this.ticketClosedTime,
        // "comment": this.comment,
        "id": id,
        "ticketCanceledTime": ticketCanceledTime,
        "serviceId": serviceId,
        "slaFinish": slaFinish,
        // "cancelReason": this.cancelReason,
        "ticketId": ticketId,
        "slaResponse": slaResponse,
      };
}

class TicketTaskDtoList {
  String taskDefKey;

  TicketTaskDtoList({
    required this.taskDefKey,
  });

  factory TicketTaskDtoList.fromJson(Map<String, dynamic> json) =>
      TicketTaskDtoList(
        taskDefKey: json['taskDefKey'],
      );

  Map<String, dynamic> toMap() => {
        "taskDefKey": taskDefKey,
      };
}
