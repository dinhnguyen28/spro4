import 'package:equatable/equatable.dart';
import 'package:login_bloc/models/phase_detail_model/id_detail_model.dart';

enum Status { loading, success, failure }

enum CancelStatus { initial, success, failure }

// const List<String> listName = [
//   'Loại yêu cầu',
//   'Người tạo',
//   'Trạng thái',
//   'Ngày tạo',
//   'Ngày nhận',
//   'Ngày phản hồi',
//   'Ngày hoàn tất',
// ];

class PhaseState extends Equatable {
  final Status status;
  final CancelStatus cancelStatus;
  final IdData? idData;
  final Map<String, String>? listTicketInfo;
  // final List<String>? listTicketName;

  const PhaseState({
    this.status = Status.loading,
    this.cancelStatus = CancelStatus.initial,
    this.idData,
    this.listTicketInfo = const <String, String>{},
    // this.listTicketName = listName,
  });

  PhaseState copyWith({
    Status? status,
    CancelStatus? cancelStatus,
    IdData? idData,
    Map<String, String>? listTicketInfo,
    // List<String>? listTicketName,
  }) {
    return PhaseState(
      status: status ?? this.status,
      cancelStatus: cancelStatus ?? this.cancelStatus,
      idData: idData ?? this.idData,
      listTicketInfo: listTicketInfo ?? this.listTicketInfo,
      // listTicketName: listTicketName ?? this.listTicketName,
    );
  }

  @override
  List<Object> get props => [status];
}
