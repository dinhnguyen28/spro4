import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spro4/bloc/ticket_bloc/ticket_bloc.dart';
import 'package:spro4/module/convert/enum_to_string.dart';

void categoryTicket(BuildContext context, TicketBloc ticketBloc) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12.0),
      ),
    ),
    constraints: const BoxConstraints(maxHeight: 350),
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 0.1),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  const Flexible(
                    child: Text(
                      "Phân loại",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Opacity(
                      opacity: 0.0,
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: null,
                      )),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: TickServicesFilter(ticketBloc: ticketBloc),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ticketStatusFilter(ticketBloc),
                      ),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(26))),
                          ),
                          onPressed: () {},
                          child: const Text("Thời gian"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: const Text('Áp dụng'),
                  onPressed: () {
                    ticketBloc.add(const ListServicesSubmit());
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class TickServicesFilter extends StatefulWidget {
  final TicketBloc ticketBloc;

  const TickServicesFilter({
    super.key,
    required this.ticketBloc,
  });

  @override
  State<TickServicesFilter> createState() => _TickServicesFilterState();
}

class _TickServicesFilterState extends State<TickServicesFilter> {
  final popupBuilderKey = GlobalKey<DropdownSearchState<String>>();
  late TicketBloc _ticketBloc;

  bool popupBuilderSelection = true;

  String text = "Xoá tất cả";

  @override
  void initState() {
    _ticketBloc = widget.ticketBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void handleCheckBoxState() {
      var selectedItem =
          popupBuilderKey.currentState?.popupGetSelectedItems ?? [];

      var isAllSelected =
          popupBuilderKey.currentState?.popupIsAllItemSelected ?? false;

      popupBuilderSelection =
          selectedItem.isEmpty ? false : (isAllSelected ? true : false);

      setState(() {
        if (popupBuilderSelection) {
          text = "Xoá tất cả";
        } else {
          text = "Chọn tất cả";
        }
      });
    }

    void tapFunction() {
      if (popupBuilderSelection) {
        popupBuilderKey.currentState!.popupDeselectAllItems();
        // text = "Chọn tất cả";
      } else {
        popupBuilderKey.currentState!.popupSelectAllItems();
        // text = "Xoá tất cả";
      }
    }

    return SizedBox(
      height: 65,
      child: DropdownSearch<String>.multiSelection(
        key: popupBuilderKey,
        selectedItems: _ticketBloc.state.selectedlistServices,
        items: _ticketBloc.state.listServices,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
              isDense: true,
              labelText: "Dịch vụ",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0))),
        ),
        dropdownBuilder: (context, selectedItems) {
          List<Widget> widgets = [];

          List<String> listItems = [];

          if (selectedItems.length > 2) {
            listItems.add(selectedItems[0]);
            listItems.add(selectedItems[1]);
            listItems.add("+${(selectedItems.length - 2)}");
          } else if (selectedItems.length == 2) {
            listItems.add(selectedItems[0]);
            listItems.add(selectedItems[1]);
          } else {
            listItems.add(selectedItems[0]);
          }

          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (var item in listItems)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Chip(
                    side: const BorderSide(color: Colors.grey),
                    backgroundColor: const Color(0xFFE5E5E5),
                    label: Text(item,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.blue)),
                  ),
                ),
            ],
          );
        },
        popupProps: PopupPropsMultiSelection.modalBottomSheet(
          onItemAdded: (selectedItems, addedItem) => handleCheckBoxState(),
          onItemRemoved: (selectedItems, removedItem) => handleCheckBoxState(),
          containerBuilder: (context, popupWidget) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => tapFunction(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        text,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(child: popupWidget),
                ],
              ),
            );
          },
          showSelectedItems: true,
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              labelText: "Tìm",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          modalBottomSheetProps: const ModalBottomSheetProps(
            barrierDismissible: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
            ),
          ),
        ),
        onChanged: (listServices) =>
            _ticketBloc.add(ListServicesChanged(listServices)),
      ),
    );
  }
}

DropdownSearch<TicketStatus> ticketStatusFilter(TicketBloc ticketBloc) {
  return DropdownSearch<TicketStatus>.multiSelection(
    dropdownBuilder: (context, selectedItems) {
      return const Center(child: Text("Trạng thái"));
    },
    selectedItems: ticketBloc.state.selectedListStatus,
    items: listStatus[ticketBloc.state.ticketStatus] ?? [],
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
          constraints: const BoxConstraints(maxHeight: 60),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
          )),
    ),
    popupProps: PopupPropsMultiSelection.dialog(
      itemBuilder: (context, item, isSelected) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(item.ticketStatus2String()),
        );
      },
    ),
    onChanged: (listStatus) =>
        ticketBloc.add(ListTicketStatusChanged(listStatus)),
  );
}
