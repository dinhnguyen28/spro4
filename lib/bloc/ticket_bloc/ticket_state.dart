// ignore_for_file: constant_identifier_names

part of 'ticket_bloc.dart';

enum Status { loading, success, failure }

enum TicketStatus {
  ONGOING,
  COMPLETED,
  CANCEL,
  DRAFT,
  SHARED,
  CLOSED,
  DELETED_BY_RU,
  OPENED,
  PROCESSING,
  FOLLOWED,
  additionalRequest,
  none,
}

final Map<TicketStatus, List<TicketStatus>> listStatus = {
  TicketStatus.ONGOING: [
    TicketStatus.OPENED,
    TicketStatus.PROCESSING,
    TicketStatus.additionalRequest,
    TicketStatus.DELETED_BY_RU
  ],
  TicketStatus.COMPLETED: [TicketStatus.COMPLETED, TicketStatus.CLOSED],
  TicketStatus.CANCEL: [TicketStatus.CANCEL],
  TicketStatus.DRAFT: [TicketStatus.DRAFT],
  TicketStatus.SHARED: [TicketStatus.SHARED, TicketStatus.FOLLOWED],
};

class TicketState extends Equatable {
  final Status status;
  final Status tabStatus;
  final String search;
  final int page;
  final TicketStatus ticketStatus;
  final List<String> listServices;
  final List<String> selectedlistServices;
  final List<int> listTicketCountTab;
  final List<Content> ticketContent;
  final int totalElements;
  final bool hasReachedMax;
  final List<TicketStatus> listStatus;
  final List<TicketStatus> selectedListStatus;
  final List<dynamic> listDateFilter;
  final String fromDate;
  final String toDate;
  final String fromDateFinish;
  final String toDateFinish;
  final String fromDateCancel;
  final String toDateCancel;

  const TicketState({
    this.status = Status.loading,
    this.tabStatus = Status.loading,
    this.search = "",
    this.page = 1,
    this.ticketStatus = TicketStatus.none,
    this.listServices = const <String>[],
    this.selectedlistServices = const <String>[],
    this.listTicketCountTab = const <int>[],
    this.ticketContent = const <Content>[],
    this.totalElements = 0,
    this.hasReachedMax = false,
    this.listStatus = const <TicketStatus>[],
    this.selectedListStatus = const <TicketStatus>[],
    this.listDateFilter = const <dynamic>[],
    this.fromDate = "",
    this.toDate = "",
    this.fromDateFinish = "",
    this.toDateFinish = "",
    this.fromDateCancel = "",
    this.toDateCancel = "",
  });

  TicketState copyWith({
    Status? status,
    Status? tabStatus,
    String? search,
    int? page,
    TicketStatus? ticketStatus,
    List<String>? listServices,
    List<String>? selectedlistServices,
    List<int>? listTicketCountTab,
    List<Content>? ticketContent,
    int? totalElements,
    bool? hasReachedMax,
    List<TicketStatus>? listStatus,
    List<TicketStatus>? selectedListStatus,
    List<dynamic>? listDateFilter,
    String? fromDate,
    String? toDate,
    String? fromDateFinish,
    String? toDateFinish,
    String? fromDateCancel,
    String? toDateCancel,
  }) {
    return TicketState(
      status: status ?? this.status,
      tabStatus: tabStatus ?? this.tabStatus,
      search: search ?? this.search,
      page: page ?? this.page,
      ticketStatus: ticketStatus ?? this.ticketStatus,
      listServices: listServices ?? this.listServices,
      selectedlistServices: selectedlistServices ?? this.selectedlistServices,
      listTicketCountTab: listTicketCountTab ?? this.listTicketCountTab,
      ticketContent: ticketContent ?? this.ticketContent,
      totalElements: totalElements ?? this.totalElements,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      listStatus: listStatus ?? this.listStatus,
      selectedListStatus: selectedListStatus ?? this.selectedListStatus,
      listDateFilter: listDateFilter ?? this.listDateFilter,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      fromDateFinish: fromDateFinish ?? this.fromDateFinish,
      toDateFinish: toDateFinish ?? this.toDateFinish,
      fromDateCancel: fromDateCancel ?? this.fromDateCancel,
      toDateCancel: toDateCancel ?? this.toDateCancel,
    );
  }

  @override
  List<Object> get props => [
        status,
        tabStatus,
        search,
        page,
        ticketStatus,
        listServices,
        selectedlistServices,
        listTicketCountTab,
        ticketContent,
        totalElements,
        hasReachedMax,
        listStatus,
        selectedListStatus,
        listDateFilter,
        fromDate,
        toDate,
        fromDateFinish,
        toDateFinish,
        fromDateCancel,
        toDateCancel,
      ];
}
