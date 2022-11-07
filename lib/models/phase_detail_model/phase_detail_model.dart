class PhaseDetailData {
  PhaseDetailData({
    this.code,
    this.data,
    this.message,
  });

  int? code;
  Data? data;
  String? message;

  factory PhaseDetailData.fromJson(Map<String, dynamic> json) =>
      PhaseDetailData(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.id,
    this.taskId,
    this.taskDefKey,
    this.taskName,
    this.taskPriority,
    this.taskAssignee,
    this.taskCreatedTime,
    this.taskStartedTime,
    this.taskStatus,
    this.procInstId,
    this.procDefId,
    this.taskType,
    this.newTaskId,
    this.startPermission,
    this.newStatus,
    this.printId,
    this.ticketId,
    this.fullName,
    this.taskProcDefId,
  });

  int? id;
  String? taskId;
  String? taskDefKey;
  String? taskName;
  String? taskPriority;
  String? taskAssignee;
  int? taskCreatedTime;
  int? taskStartedTime;
  String? taskStatus;
  String? procInstId;
  String? procDefId;
  String? taskType;
  String? newTaskId;
  int? startPermission;
  String? newStatus;
  int? printId;
  int? ticketId;
  String? fullName;
  String? taskProcDefId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        taskId: json["taskId"],
        taskDefKey: json["taskDefKey"],
        taskName: json["taskName"],
        taskPriority: json["taskPriority"],
        taskAssignee: json["taskAssignee"],
        taskCreatedTime: json["taskCreatedTime"],
        taskStartedTime: json["taskStartedTime"],
        taskStatus: json["taskStatus"],
        procInstId: json["procInstId"],
        procDefId: json["procDefId"],
        taskType: json["taskType"],
        newTaskId: json["newTaskId"],
        startPermission: json["startPermission"],
        newStatus: json["newStatus"],
        printId: json["printId"],
        ticketId: json["ticketId"],
        fullName: json["fullName"],
        taskProcDefId: json["taskProcDefId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "taskId": taskId,
        "taskDefKey": taskDefKey,
        "taskName": taskName,
        "taskPriority": taskPriority,
        "taskAssignee": taskAssignee,
        "taskCreatedTime": taskCreatedTime,
        "taskStartedTime": taskStartedTime,
        "taskStatus": taskStatus,
        "procInstId": procInstId,
        "procDefId": procDefId,
        "taskType": taskType,
        "newTaskId": newTaskId,
        "startPermission": startPermission,
        "newStatus": newStatus,
        "printId": printId,
        "ticketId": ticketId,
        "fullName": fullName,
        "taskProcDefId": taskProcDefId,
      };
}
