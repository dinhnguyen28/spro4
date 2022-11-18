part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();
  @override
  List<Object> get props => [];
}

class CountTicket extends TicketEvent {
  const CountTicket();
  @override
  List<Object> get props => [];
}

class MyTicketLoadData extends TicketEvent {
  final TicketStatus ticketStatus;

  const MyTicketLoadData(
    this.ticketStatus,
  );
  @override
  List<Object> get props => [ticketStatus];
}

class RefreshTicket extends TicketEvent {
  const RefreshTicket();
  @override
  List<Object> get props => [];
}

class LoadMoreTicket extends TicketEvent {
  const LoadMoreTicket();
  @override
  List<Object> get props => [];
}

class SearchTicket extends TicketEvent {
  final String search;

  const SearchTicket(
    this.search,
  );
  @override
  List<Object> get props => [search];
}

class CategoryChecked extends TicketEvent {
  final bool isChecked;
  final TicketStatus items;

  const CategoryChecked(
    this.isChecked,
    this.items,
  );
  @override
  List<Object> get props => [];
}

class CategoryTicket extends TicketEvent {
  const CategoryTicket();
  @override
  List<Object> get props => [];
}

class CategoryDelete extends TicketEvent {
  const CategoryDelete();
  @override
  List<Object> get props => [];
}

class CategoryCancel extends TicketEvent {
  const CategoryCancel();
  @override
  List<Object> get props => [];
}

class OpenDialog extends TicketEvent {
  const OpenDialog();
  @override
  List<Object> get props => [];
}

class CategoryTimeSubmit extends TicketEvent {
  final String fromDate;
  final String toDate;
  final String fromDateFinish;
  final String toDateFinish;
  final String fromDateCancel;
  final String toDateCancel;

  const CategoryTimeSubmit(
    this.fromDate,
    this.toDate,
    this.fromDateFinish,
    this.toDateFinish,
    this.fromDateCancel,
    this.toDateCancel,
  );
  @override
  List<Object> get props => [];
}

class ListServicesChanged extends TicketEvent {
  final List<String> listServices;

  const ListServicesChanged(
    this.listServices,
  );
  @override
  List<Object> get props => [];
}

class ListTicketStatusChanged extends TicketEvent {
  final List<TicketStatus> listStatus;

  const ListTicketStatusChanged(
    this.listStatus,
  );
  @override
  List<Object> get props => [];
}

class TicketTimeFilterChanged extends TicketEvent {
  final String something;

  const TicketTimeFilterChanged(
    this.something,
  );
  @override
  List<Object> get props => [];
}

class ListServicesSubmit extends TicketEvent {
  const ListServicesSubmit();
  @override
  List<Object> get props => [];
}
