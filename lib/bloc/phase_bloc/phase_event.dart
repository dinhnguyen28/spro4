import 'package:equatable/equatable.dart';

abstract class PhaseEvent extends Equatable {
  const PhaseEvent();
  @override
  List<Object> get props => [];
}

class LoadPhaseDetail extends PhaseEvent {
  final int id;

  const LoadPhaseDetail(
    this.id,
  );
  @override
  List<Object> get props => [id];
}

class CancelTicket extends PhaseEvent {
  // final String? ticketId;
  final String reason;

  const CancelTicket(
    // this.ticketId,
    this.reason,
  );
  @override
  List<Object> get props => [];
}

class RatingTicket extends PhaseEvent {
  final String comment;

  const RatingTicket(
    this.comment,
  );

  @override
  List<Object> get props => [];
}

class ChangeRating extends PhaseEvent {
  final double rating;

  const ChangeRating(
    this.rating,
  );
  @override
  List<Object> get props => [];
}

class CancelRating extends PhaseEvent {
  const CancelRating();
  @override
  List<Object> get props => [];
}
