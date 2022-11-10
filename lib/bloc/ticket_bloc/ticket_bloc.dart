import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:spro4/api/api_service.dart';
import 'package:spro4/models/ticket_model/ticket_model.dart';
import 'package:spro4/module/convert/string_to_date.dart';

part 'ticket_state.dart';
part 'ticket_event.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(const TicketState()) {
    on<LoadAllTicket>(_onLoadTicketData);
    on<RefreshTicket>(_onRefreshTicketData);
    on<LoadMoreTicket>(_onLoadMoreTicketData);
    on<SearchTicket>(_onSearchTicket);
    on<CategoryChecked>(_onCategoryChecked);
    on<CategoryTicket>(_onCategoryTicket);
    on<CategoryDelete>(_onCategoryDelete);
    on<CategoryCancel>(_onCategoryCancel);
    on<OpenDialog>(_onOpenDialog);
    on<CategoryTimeSubmit>(_onCategoryTimeSubmit);
  }

  Future<void> _onLoadTicketData(
      LoadAllTicket event, Emitter<TicketState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final getlistServices = await getFilter();

      emit(state.copyWith(
        listServices: getlistServices.data?.listServices ?? [],
      ));

      if (getlistServices.code == 1) {
        final content = await searchTicket(
          state.search,
          1,
          event.ticketStatus.name,
          state.listServices,
          listStatus[event.ticketStatus],
          state.fromDate,
          state.toDate,
          state.fromDateFinish,
          state.toDateFinish,
          state.fromDateCancel,
          state.toDateCancel,
          [],
        );
        (content?.data?.content?.length ?? 0) < 10
            ? emit(state.copyWith(
                status: Status.success,
                hasReachedMax: true,
                ticketContent: content?.data?.content ?? [],
                page: 2,
                ticketStatus: event.ticketStatus,
                listStatus: listStatus[event.ticketStatus],
                listDateFilter: [],
                fromDate: "",
                toDate: "",
                fromDateFinish: "",
                toDateFinish: "",
                fromDateCancel: "",
                toDateCancel: "",
              ))
            : emit(state.copyWith(
                status: Status.success,
                hasReachedMax: false,
                ticketContent: content?.data?.content ?? [],
                page: 2,
                ticketStatus: event.ticketStatus,
                listStatus: listStatus[event.ticketStatus],
                listDateFilter: [],
                fromDate: "",
                toDate: "",
                fromDateFinish: "",
                toDateFinish: "",
                fromDateCancel: "",
                toDateCancel: "",
              ));

        // debugPrint(
        //     'LOAD ${event.ticketStatus.ticketStatus2String()}: "${state.search}" + ${state.listStatus}');
      } else {
        emit(state.copyWith(status: Status.failure));
      }
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onRefreshTicketData(
      RefreshTicket event, Emitter<TicketState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final getlistServices = await getFilter();

      emit(state.copyWith(
        listServices: getlistServices.data?.listServices ?? [],
      ));

      if (getlistServices.code == 1) {
        final content = await searchTicket(
          state.search,
          1,
          state.ticketStatus.name,
          state.listServices,
          listStatus[state.ticketStatus],
          state.fromDate,
          state.toDate,
          state.fromDateFinish,
          state.toDateFinish,
          state.fromDateCancel,
          state.toDateCancel,
          [],
        );
        (content?.data?.content?.length ?? 0) < 10
            ? emit(state.copyWith(
                status: Status.success,
                ticketContent: content?.data?.content ?? [],
                hasReachedMax: true,
                search: state.search,
              ))
            : emit(state.copyWith(
                status: Status.success,
                hasReachedMax: false,
                ticketContent: content?.data?.content ?? [],
                page: 2,
                listStatus: listStatus[state.ticketStatus],
                // listDateFilter: [],
                fromDate: "",
                toDate: "",
                fromDateFinish: "",
                toDateFinish: "",
                fromDateCancel: "",
                toDateCancel: "",
              ));

        // debugPrint(
        //     'REFRESH ${state.ticketStatus.ticketStatus2String()}: "${state.search}" + ${state.listDateFilter} + ${state.listStatus}');
      }
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onLoadMoreTicketData(
      LoadMoreTicket event, Emitter<TicketState> emit) async {
    try {
      if (state.status == Status.success) {
        final content = await searchTicket(
          state.search,
          state.page,
          state.ticketStatus.name,
          state.listServices,
          state.listStatus,
          state.fromDate,
          state.toDate,
          state.fromDateFinish,
          state.toDateFinish,
          state.fromDateCancel,
          state.toDateCancel,
          state.listDateFilter,
        );
        // debugPrint(
        //     'MORE ${state.ticketStatus.ticketStatus2String()}: "${state.search}" + page: ${state.page} + ${state.listStatus} ');

        content!.data!.content!.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(state.copyWith(
                page: state.page + 1,
                hasReachedMax: false,
                ticketContent: List.of(state.ticketContent)
                  ..addAll(content.data!.content!.toList()),
              ));
      }
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onSearchTicket(
      SearchTicket event, Emitter<TicketState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final content = await searchTicket(
        event.search,
        1,
        state.ticketStatus.name,
        state.listServices,
        state.listStatus,
        state.fromDate,
        state.toDate,
        state.fromDateFinish,
        state.toDateFinish,
        state.fromDateCancel,
        state.toDateCancel,
        state.listDateFilter,
      );

      (content?.data?.content?.length ?? 0) < 10
          ? emit(state.copyWith(
              status: Status.success,
              ticketContent: content?.data?.content ?? [],
              hasReachedMax: true,
              search: event.search,
            ))
          : emit(state.copyWith(
              status: Status.success,
              page: 2,
              ticketContent: content?.data?.content ?? [],
              hasReachedMax: false,
              search: event.search,
            ));

      // debugPrint(
      //     'SEARCH ${state.ticketStatus.ticketStatus2String()}: "${state.search}" + ${state.listStatus}');
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  List<TicketStatus> _tempSelected = [];

  Future<void> _onCategoryChecked(
      CategoryChecked event, Emitter<TicketState> emit) async {
    List<TicketStatus> selectedItems = state.listStatus.toList();

    event.isChecked
        ? selectedItems.add(event.items)
        : selectedItems.remove(event.items);

    emit(state.copyWith(listStatus: selectedItems));
  }

  Future<void> _onCategoryDelete(
      CategoryDelete event, Emitter<TicketState> emit) async {
    emit(state.copyWith(listStatus: listStatus[state.ticketStatus]));
  }

  Future<void> _onCategoryCancel(
      CategoryCancel event, Emitter<TicketState> emit) async {
    emit(state.copyWith(listStatus: _tempSelected));

    // debugPrint(state.listStatus.toString());
  }

  Future<void> _onOpenDialog(
      OpenDialog event, Emitter<TicketState> emit) async {
    _tempSelected = state.listStatus;
    // debugPrint(_tempSelected.toString());
  }

  Future<void> _onCategoryTicket(
      CategoryTicket event, Emitter<TicketState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final content = await searchTicket(
        state.search,
        1,
        state.ticketStatus.name,
        state.listServices,
        state.listStatus,
        state.fromDate,
        state.toDate,
        state.fromDateFinish,
        state.toDateFinish,
        state.fromDateCancel,
        state.toDateCancel,
        state.listDateFilter,
      );
      emit(state.copyWith(
        status: Status.success,
        page: 2,
        ticketContent: content?.data?.content ?? [],
        hasReachedMax: false,
      ));

      // debugPrint(
      //     'FILTER ${state.ticketStatus.ticketStatus2String()}: "${state.search}" + ${state.listStatus}');
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onCategoryTimeSubmit(
      CategoryTimeSubmit event, Emitter<TicketState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));

      List<dynamic> listDFilter = [];

      Map<String, String> mapDFilter = {
        "type": "ticketCreatedTime",
        "fromDate": stringToTimeStamp(event.fromDate),
        "toDate": stringToTimeStamp(event.toDate),
      };

      listDFilter.add(mapDFilter);

      emit(state.copyWith(
        toDate: event.toDate,
        fromDate: event.fromDate,
        fromDateFinish: event.fromDateFinish,
        toDateFinish: event.toDateFinish,
        fromDateCancel: event.fromDateCancel,
        toDateCancel: event.toDateCancel,
        listDateFilter: listDFilter,
      ));

      switch (state.ticketStatus) {
        case TicketStatus.COMPLETED:
          Map<String, String> mapDFilter = {
            "type": "ticketFinishTime",
            "fromDate": stringToTimeStamp(event.fromDateFinish),
            "toDate": stringToTimeStamp(event.toDateFinish),
          };

          listDFilter.add(mapDFilter);

          emit(state.copyWith(listDateFilter: listDFilter));

          break;
        case TicketStatus.CANCEL:
          Map<String, String> mapDFilter = {
            "type": "ticketCanceledTime",
            "fromDate": stringToTimeStamp(event.fromDateCancel),
            "toDate": stringToTimeStamp(event.toDateCancel),
          };

          listDFilter.add(mapDFilter);

          emit(state.copyWith(listDateFilter: listDFilter));
          break;
        default:
          break;
      }

      final content = await searchTicket(
        state.search,
        1,
        state.ticketStatus.name,
        state.listServices,
        state.listStatus,
        state.fromDate,
        state.toDate,
        state.fromDateFinish,
        state.toDateFinish,
        state.fromDateCancel,
        state.toDateCancel,
        state.listDateFilter,
      );

      emit(state.copyWith(
        status: Status.success,
        page: 2,
        ticketContent: content?.data?.content ?? [],
        hasReachedMax: false,
      ));

      // debugPrint(state.listDateFilter.toString());
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }
}
