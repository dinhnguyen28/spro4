class IdData {
  int? code;
  Data? data;
  String? message;

  IdData({
    this.code,
    this.data,
    this.message,
  });

  factory IdData.fromJson(Map<String, dynamic> json) => IdData(
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
  int id;
  String? ticketId;
  String? ticketTitle;
  dynamic ticketCreatedUser;
  String? ticketProcDefId;
  dynamic ticketSla;
  String? endKey;
  String? startKey;
  dynamic ticketEndTime;
  dynamic ticketClosedTime;
  dynamic ticketStartedTime;
  dynamic ticketCanceledTime;
  int? ticketCreatedTime;
  int? ticketFinishTime;
  String? ticketStatus;
  String? procServiceName;
  String? ticketStartUserId;
  double? ticketRating;
  String? comment;
  List<String>? listOwner;
  dynamic listService;
  dynamic listStatus;
  dynamic listDate;
  dynamic user;
  List<dynamic>? ruData;
  int? serviceId;
  List<TicketTaskDtoList>? ticketTaskDtoList;
  bool? hideResult;
  bool? informTo;
  bool? updatePermission;
  bool? ruPermission;
  bool? newAndClone;
  // double? slaResponse;
  // double? slaFinish;
  // double? slaResponseTime;
  // double? slaFinishTIme;
  bool? editPermission;
  List<dynamic>? listSignForm;
  String? fullName;

  Data({
    required this.id,
    this.ticketId,
    this.ticketTitle,
    this.ticketCreatedUser,
    this.ticketProcDefId,
    this.ticketSla,
    this.endKey,
    this.startKey,
    this.ticketEndTime,
    this.ticketClosedTime,
    this.ticketStartedTime,
    this.ticketCanceledTime,
    this.ticketCreatedTime,
    this.ticketFinishTime,
    this.ticketStatus,
    this.procServiceName,
    this.ticketStartUserId,
    this.ticketRating,
    this.comment,
    this.listOwner,
    this.listService,
    this.listStatus,
    this.listDate,
    this.user,
    this.ruData,
    this.serviceId,
    this.ticketTaskDtoList,
    this.hideResult,
    this.informTo,
    this.updatePermission,
    this.ruPermission,
    this.newAndClone,
    // this.slaResponse,
    // this.slaFinish,
    // this.slaResponseTime,
    // this.slaFinishTIme,
    this.editPermission,
    this.listSignForm,
    this.fullName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        ticketId: json["ticketId"],
        ticketTitle: json["ticketTitle"],
        ticketCreatedUser: json["ticketCreatedUser"],
        ticketProcDefId: json["ticketProcDefId"],
        ticketSla: json["ticketSla"],
        endKey: json["endKey"],
        startKey: json["startKey"],
        ticketEndTime: json["ticketEndTime"],
        ticketClosedTime: json["ticketClosedTime"],
        ticketStartedTime: json["ticketStartedTime"],
        ticketCanceledTime: json["ticketCanceledTime"],
        ticketCreatedTime: json["ticketCreatedTime"],
        ticketFinishTime: json["ticketFinishTime"],
        ticketStatus: json["ticketStatus"],
        procServiceName: json["procServiceName"],
        ticketStartUserId: json["ticketStartUserId"],
        ticketRating: json["ticketRating"],
        comment: json["comment"],
        listOwner: json["listOwner"] == null
            ? null
            : List<String>.from(json["listOwner"].map((e) => e)),
        listService: json["listService"],
        listStatus: json["listStatus"],
        listDate: json["listDate"],
        user: json["user"],
        ruData: json["ruData"] == null
            ? null
            : List<dynamic>.from(json["ruData"].map((e) => e)),
        serviceId: json["serviceId"],
        ticketTaskDtoList: json["ticketTaskDtoList"] == null
            ? null
            : List<TicketTaskDtoList>.from(json["ticketTaskDtoList"]
                .map((e) => TicketTaskDtoList.fromJson(e))),
        hideResult: json["hideResult"],
        informTo: json["informTo"],
        updatePermission: json["updatePermission"],
        ruPermission: json["ruPermission"],
        newAndClone: json["newAndClone"],
        // slaResponse: json["slaResponse"],
        // slaFinish: json["slaFinish"],
        // slaResponseTime: json["slaResponseTime"],
        // slaFinishTIme: json["slaFinishTIme"],
        editPermission: json["editPermission"],
        listSignForm: json["listSignForm"] == null
            ? null
            : List<dynamic>.from(json["listSignForm"].map((e) => e)),
        fullName: json["fullName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ticketId": ticketId,
        "ticketTitle": ticketTitle,
        "ticketCreatedUser": ticketCreatedUser,
        "ticketProcDefId": ticketProcDefId,
        "ticketSla": ticketSla,
        "endKey": endKey,
        "startKey": startKey,
        "ticketEndTime": ticketEndTime,
        "ticketClosedTime": ticketClosedTime,
        "ticketStartedTime": ticketStartedTime,
        "ticketCanceledTime": ticketCanceledTime,
        "ticketCreatedTime": ticketCreatedTime,
        "ticketFinishTime": ticketFinishTime,
        "ticketStatus": ticketStatus,
        "procServiceName": procServiceName,
        "ticketStartUserId": ticketStartUserId,
        "ticketRating": ticketRating,
        "comment": comment,
        "listOwner": listOwner,
        "listService": listService,
        "listStatus": listStatus,
        "listDate": listDate,
        "user": user,
        "ruData": ruData,
        "serviceId": serviceId,
        "ticketTaskDtoList": ticketTaskDtoList,
        "hideResult": hideResult,
        "informTo": informTo,
        "updatePermission": updatePermission,
        "ruPermission": ruPermission,
        "newAndClone": newAndClone,
        // "slaResponse": slaResponse,
        // "slaFinish": slaFinish,
        // "slaResponseTime": slaResponseTime,
        // "slaFinishTIme": slaFinishTIme,
        "editPermission": editPermission,
        "listSignForm": listSignForm,
        "fullName": fullName,
      };
}

class TicketTaskDtoList {
  int? id;
  String? taskId;
  String? taskDefKey;
  String? taskName;
  // Null? taskPriority;
  String? taskAssignee;
  int? taskCreatedTime;
  int? taskStartedTime;
  // Null? taskSla;
  // Null? taskFinishedTime;
  // Null? taskDoneTime;
  String? taskStatus;
  // Null? procInstId;
  // Null? endKey;
  String? procDefId;
  String? taskType;
  // Null? affected;
  // Null? listStatus;
  // Null? listVariables;
  // Null? responseTime;
  // Null? finishTime;
  // Null? newTaskId;
  // Null? startPermission;
  // Null? newStatus;
  // Null? printId;
  // Null? ticketId;
  // Null? listSignForm;
  // Null? editPermission;
  // Null? ticketProcDefId;
  // Null? fullName;
  String? taskProcDefId;

  TicketTaskDtoList({
    this.id,
    this.taskId,
    this.taskDefKey,
    this.taskName,
    // this.taskPriority,
    this.taskAssignee,
    this.taskCreatedTime,
    this.taskStartedTime,
    // this.taskSla,
    // this.taskFinishedTime,
    // this.taskDoneTime,
    this.taskStatus,
    // this.procInstId,
    // this.endKey,
    this.procDefId,
    this.taskType,
    // this.affected,
    // this.listStatus,
    // this.listVariables,
    // this.responseTime,
    // this.finishTime,
    // this.newTaskId,
    // this.startPermission,
    // this.newStatus,
    // this.printId,
    // this.ticketId,
    // this.listSignForm,
    // this.editPermission,
    // this.ticketProcDefId,
    // this.fullName,
    this.taskProcDefId,
  });

  factory TicketTaskDtoList.fromJson(Map<String, dynamic> json) =>
      TicketTaskDtoList(
        id: json['id'],
        taskId: json['taskId'],
        taskDefKey: json['taskDefKey'],
        taskName: json['taskName'],
        // taskPriority: json['taskPriority'],
        taskAssignee: json['taskAssignee'],
        taskCreatedTime: json['taskCreatedTime'],
        taskStartedTime: json['taskStartedTime'],
        // taskSla: json['taskSla'],
        // taskFinishedTime: json['taskFinishedTime'],
        // taskDoneTime: json['taskDoneTime'],
        taskStatus: json['taskStatus'],
        // procInstId: json['procInstId'],
        // endKey: json['endKey'],
        procDefId: json['procDefId'],
        taskType: json['taskType'],
        // affected: json['affected'],
        // listStatus: json['listStatus'],
        // listVariables: json['listVariables'],
        // responseTime: json['responseTime'],
        // finishTime: json['finishTime'],
        // newTaskId: json['newTaskId'],
        // startPermission: json['startPermission'],
        // newStatus: json['newStatus'],
        // printId: json['printId'],
        // ticketId: json['ticketId'],
        // listSignForm: json['listSignForm'],
        // editPermission: json['editPermission'],
        // ticketProcDefId: json['ticketProcDefId'],
        // fullName: json['fullName'],
        taskProcDefId: json['taskProcDefId'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "taskId": taskId,
        "taskDefKey": taskDefKey,
        "taskName": taskName,
        // "taskPriority": taskPriority,
        "taskAssignee": taskAssignee,
        "taskCreatedTime": taskCreatedTime,
        "taskStartedTime": taskStartedTime,
        // "taskSla": taskSla,
        // "taskFinishedTime": taskFinishedTime,
        // "taskDoneTime": taskDoneTime,
        "taskStatus": taskStatus,
        // "procInstId": procInstId,
        // "endKey": endKey,
        "procDefId": procDefId,
        "taskType": taskType,
        // "affected": affected,
        // "listStatus": listStatus,
        // "listVariables": listVariables,
        // "responseTime": responseTime,
        // "finishTime": finishTime,
        // "newTaskId": newTaskId,
        // "startPermission": startPermission,
        // "newStatus": newStatus,
        // "printId": printId,
        // "ticketId": ticketId,
        // "listSignForm": listSignForm,
        // "editPermission": editPermission,
        // "ticketProcDefId": ticketProcDefId,
        // "fullName": fullName,
        "taskProcDefId": taskProcDefId,
      };
}
