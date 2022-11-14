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
  NULL,
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

const Map<TicketStatus, int> ticketCountTabs = {
  TicketStatus.ONGOING: 0,
  TicketStatus.COMPLETED: 0,
  TicketStatus.CANCEL: 0,
  TicketStatus.DRAFT: 0,
  TicketStatus.SHARED: 0,
};

class TicketState extends Equatable {
  final Status status;
  final Status tabStatus;

  final String search;
  final int page;
  final TicketStatus ticketStatus;
  final List<String> listServices;
  final Map<TicketStatus, int> ticketCountTab;
  final List<Content> ticketContent;
  final int totalElements;
  final bool hasReachedMax;
  final bool isChecked;
  final List<TicketStatus> listStatus;
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
    this.ticketStatus = TicketStatus.NULL,
    this.listServices = const <String>[],
    this.ticketCountTab = ticketCountTabs,
    this.ticketContent = const <Content>[],
    this.totalElements = 0,
    this.hasReachedMax = false,
    this.isChecked = false,
    this.listStatus = const <TicketStatus>[],
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
    Map<TicketStatus, int>? ticketCountTab,
    List<Content>? ticketContent,
    int? totalElements,
    bool? hasReachedMax,
    bool? isChecked,
    List<TicketStatus>? listStatus,
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
      ticketCountTab: ticketCountTab ?? this.ticketCountTab,
      ticketContent: ticketContent ?? this.ticketContent,
      totalElements: totalElements ?? this.totalElements,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isChecked: isChecked ?? this.isChecked,
      listStatus: listStatus ?? this.listStatus,
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
        ticketCountTab,
        ticketContent,
        totalElements,
        hasReachedMax,
        isChecked,
        listStatus,
        listDateFilter,
        fromDate,
        toDate,
        fromDateFinish,
        toDateFinish,
        fromDateCancel,
        toDateCancel,
      ];
}
