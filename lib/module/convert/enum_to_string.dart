import 'package:spro4/bloc/ticket_bloc/ticket_bloc.dart';

extension TicketStatus2String on TicketStatus {
  String ticketStatus2String() {
    switch (this) {
      case TicketStatus.ONGOING:
        return "Đang thực hiện";
      case TicketStatus.COMPLETED:
        return "Hoàn thành";
      case TicketStatus.CANCEL:
        return "Huỷ";
      case TicketStatus.DRAFT:
        return "Nháp";
      case TicketStatus.SHARED:
        return "Được chia sẻ/Theo dõi";
      case TicketStatus.CLOSED:
        return "Đóng";
      case TicketStatus.DELETED_BY_RU:
        return "Thực hiện lại";
      case TicketStatus.OPENED:
        return "Tạo mới";
      case TicketStatus.PROCESSING:
        return "Đang xử lý";
      case TicketStatus.FOLLOWED:
        return "Theo dõi";
      case TicketStatus.additionalRequest:
        return "Cần bổ sung";
      case TicketStatus.NULL:
        return '';
    }
  }
}
