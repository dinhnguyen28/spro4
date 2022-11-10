import 'package:equatable/equatable.dart';
import 'package:spro4/bloc/ticket_bloc/ticket_bloc.dart';
import 'package:spro4/models/phase_detail_model/id_detail_model.dart';

enum Status { loading, success, failure }

enum CancelStatus { initial, success, failure }

class PhaseState extends Equatable {
  final Status status;
  final CancelStatus cancelStatus;
  final IdData? idData;
  final Map<String, dynamic> listTicketInfo;
  final double rating;
  final bool checkRating;
  final bool validateComment;
  final bool visible;
  final bool popContext;

  const PhaseState({
    this.status = Status.loading,
    this.cancelStatus = CancelStatus.initial,
    this.idData,
    this.listTicketInfo = const <String, dynamic>{},
    this.rating = 0.0,
    this.checkRating = false,
    this.validateComment = false,
    this.visible = false,
    this.popContext = false,
  });

  PhaseState copyWith({
    Status? status,
    CancelStatus? cancelStatus,
    IdData? idData,
    Map<String, dynamic>? listTicketInfo,
    double? rating,
    bool? checkRating,
    bool? validateComment,
    bool? visible,
    bool? popContext,
  }) {
    return PhaseState(
      status: status ?? this.status,
      cancelStatus: cancelStatus ?? this.cancelStatus,
      idData: idData ?? this.idData,
      listTicketInfo: listTicketInfo ?? this.listTicketInfo,
      rating: rating ?? this.rating,
      checkRating: checkRating ?? this.checkRating,
      validateComment: validateComment ?? this.validateComment,
      visible: visible ?? this.visible,
      popContext: popContext ?? this.popContext,
    );
  }

  @override
  List<Object> get props =>
      [status, rating, checkRating, validateComment, visible, popContext];
}
