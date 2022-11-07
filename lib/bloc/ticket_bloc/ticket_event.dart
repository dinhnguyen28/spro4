part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();
  @override
  List<Object> get props => [];
}

class LoadAllTicket extends TicketEvent {
  // final String search;
  final TicketStatus ticketStatus;

  const LoadAllTicket(
    // this.search,
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
  // final List<String> seItem;

  const CategoryChecked(
    this.isChecked,
    this.items,
    // this.seItem,
  );
  @override
  List<Object> get props => [];
}

class CategoryTicket extends TicketEvent {
  // final List<String> search;

  const CategoryTicket(
      // this.search,
      );
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
