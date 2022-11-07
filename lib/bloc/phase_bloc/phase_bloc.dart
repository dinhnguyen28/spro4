import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/api/api_service.dart';
import 'package:login_bloc/bloc/phase_bloc/phase_event.dart';
import 'package:login_bloc/bloc/phase_bloc/phase_state.dart';
import 'package:login_bloc/module/time_stamp/time_stamp.dart';

class PhaseBloc extends Bloc<PhaseEvent, PhaseState> {
  PhaseBloc() : super(const PhaseState()) {
    on<CancelTicket>(_onCancelTicket);
    on<LoadPhaseDetail>(_onLoadPhaseDetail);
  }

  Future<void> _onCancelTicket(
      CancelTicket event, Emitter<PhaseState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final cancel = await cancelTicket(event.ticketId, event.reason);

      if (cancel.code == 1) {
        final idTicketData = await idTicket(state.idData?.data?.id ?? 0);

        final Map<String, String> listTckInfor = {
          'Loại yêu cầu': '${idTicketData.data!.procServiceName}',
          'Người tạo': '${idTicketData.data!.fullName}',
          'Trạng thái': '${idTicketData.data!.ticketStatus}',
          'Ngày tạo':
              readTimestamp(idTicketData.data!.ticketCreatedTime!, 'dd/MM/yy,'),
          'Ngày nhận': '-',
          'Ngày phản hồi': '-',
          'Ngày hoàn tất': '-',
        };

        emit(state.copyWith(
          idData: idTicketData,
          listTicketInfo: listTckInfor,
          status: Status.success,
        ));
      }

      // debugPrint('${state.cancelStatus}');
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onLoadPhaseDetail(
      LoadPhaseDetail event, Emitter<PhaseState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final idTicketData = await idTicket(event.id);

      final Map<String, String> listTckInfor = {
        'Loại yêu cầu': '${idTicketData.data!.procServiceName}',
        'Người tạo': '${idTicketData.data!.fullName}',
        'Trạng thái': '${idTicketData.data!.ticketStatus}',
        'Ngày tạo': readTimestamp(
            idTicketData.data!.ticketCreatedTime!, 'dd/MM/yy, HH:mm'),
        'Ngày nhận': '-',
        'Ngày phản hồi': '-',
        'Ngày hoàn tất': '-',
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
}
