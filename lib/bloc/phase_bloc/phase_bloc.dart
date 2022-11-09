import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/api/api_service.dart';
import 'package:login_bloc/bloc/phase_bloc/phase_event.dart';
import 'package:login_bloc/bloc/phase_bloc/phase_state.dart';
import 'package:login_bloc/module/time_stamp/time_stamp.dart';

class PhaseBloc extends Bloc<PhaseEvent, PhaseState> {
  PhaseBloc() : super(const PhaseState()) {
    on<LoadPhaseDetail>(_onLoadPhaseDetail);
    on<CancelTicket>(_onCancelTicket);
    on<RatingTicket>(_onRatingTicket);
    on<ChangeRating>(_onChangeRating);
    on<CancelRating>(_onCancelRating);
  }

  Future<void> _onLoadPhaseDetail(
      LoadPhaseDetail event, Emitter<PhaseState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final idTicketData = await idTicket(event.id);

      final Map<String, dynamic> listTckInfor = {
        'Loại yêu cầu': '${idTicketData.data!.procServiceName}',
        'Người tạo': '${idTicketData.data!.fullName}',
        'Trạng thái': '${idTicketData.data!.ticketStatus}',
        'Ngày tạo': readTimestamp(
            idTicketData.data!.ticketCreatedTime!, 'dd/MM/yy, HH:mm'),
        'Ngày nhận': "",
        'Ngày phản hồi': "",
        'Ngày hoàn tất': readTimestamp(
            idTicketData.data!.ticketFinishTime ?? 0, 'dd/MM/yy, HH:mm'),
        'Đánh giá': idTicketData.data!.ticketRating,
      };

      emit(state.copyWith(
        idData: idTicketData,
        listTicketInfo: listTckInfor,
        status: Status.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onCancelTicket(
      CancelTicket event, Emitter<PhaseState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final cancel = await cancelTicket(event.ticketId, event.reason);

      if (cancel.code == 1) {
        final idTicketData = await idTicket(state.idData?.data?.id ?? 0);

        final Map<String, dynamic> listTckInfor = {
          'Loại yêu cầu': '${idTicketData.data!.procServiceName}',
          'Người tạo': '${idTicketData.data!.fullName}',
          'Trạng thái': '${idTicketData.data!.ticketStatus}',
          'Ngày tạo': readTimestamp(
              idTicketData.data!.ticketCreatedTime!, 'dd/MM/yy, HH:mm'),
          'Ngày nhận': "",
          'Ngày phản hồi': "",
          'Ngày hoàn tất': readTimestamp(
              idTicketData.data!.ticketFinishTime ?? 0, 'dd/MM/yy, HH:mm'),
          'Đánh giá': idTicketData.data!.ticketRating,
        };

        emit(state.copyWith(
          idData: idTicketData,
          listTicketInfo: listTckInfor,
          status: Status.success,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void _onCancelRating(CancelRating event, Emitter<PhaseState> emit) {
    emit(state.copyWith(
        checkRating: false,
        validateComment: false,
        visible: false,
        rating: 0.0));
  }

  void _onChangeRating(ChangeRating event, Emitter<PhaseState> emit) {
    event.rating <= 3.0
        ? emit(state.copyWith(
            visible: true,
            rating: event.rating,
            checkRating: false,
            // popContext: false,
          ))
        : emit(state.copyWith(
            visible: false,
            rating: event.rating,
            validateComment: false,
            checkRating: false,
            // popContext: true,
          ));
  }

  Future<void> _onRatingTicket(
      RatingTicket event, Emitter<PhaseState> emit) async {
    // bool value = false;

    if (state.rating == 0.0) {
      emit(state.copyWith(checkRating: true));
    } else if (state.visible && event.comment.isEmpty) {
      emit(state.copyWith(validateComment: true));
    } else {
      // emit(state.copyWith(popContext: true));

      // debugPrint("${event.procInstId} + ${state.rating} + ${event.comment}");

      try {
        emit(state.copyWith(status: Status.loading));
        final ratingTicket =
            await closeTicket(event.procInstId, state.rating, event.comment);

        if (ratingTicket.code == 1) {
          final idTicketData = await idTicket(state.idData?.data?.id ?? 0);

          final Map<String, dynamic> listTckInfor = {
            'Loại yêu cầu': '${idTicketData.data!.procServiceName}',
            'Người tạo': '${idTicketData.data!.fullName}',
            'Trạng thái': '${idTicketData.data!.ticketStatus}',
            'Ngày tạo': readTimestamp(
                idTicketData.data!.ticketCreatedTime!, 'dd/MM/yy, HH:mm'),
            'Ngày nhận': "",
            'Ngày phản hồi': "",
            'Ngày hoàn tất': readTimestamp(
                idTicketData.data!.ticketFinishTime ?? 0, 'dd/MM/yy, HH:mm'),
            'Đánh giá': idTicketData.data!.ticketRating,
          };

          emit(state.copyWith(
            idData: idTicketData,
            listTicketInfo: listTckInfor,
            status: Status.success,
          ));
        } else {
          debugPrint("nooooo");
        }
      } catch (_) {
        emit(state.copyWith(status: Status.failure));
      }
    }

    // return value;
  }
}
