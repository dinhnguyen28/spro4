import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spro4/bloc/ticket_bloc/ticket_bloc.dart';
import 'package:spro4/models/get_filter_model/filter_model.dart';

void serviceTicketDialog(BuildContext context) async {
  showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12.0),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => TicketBloc(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                DropdownSearch<String>.multiSelection(
                  items: const [
                    "carve",
                    "perceive",
                    "sort",
                    "stir",
                    "address",
                    "run",
                  ],
                  // items: listServices,
                  // key: UniqueKey(),
                  // items: const [
                  //   "bound",
                  //   "stare",
                  // "hate",
                  // "spoil",
                  // "enter",
                  // "hunt",
                  // "wind",
                  // "advocate",
                  // "swim",
                  // "dismiss",
                  // "seal",
                  // "propose",
                  // "suit",
                  // "pay",
                  // "supervise",
                  // "carve",
                  // "perceive",
                  // "sort",
                  // "stir",
                  // "address",
                  // "run",
                  // "show",
                  // "argue",
                  // "blow",
                  // "endorse",
                  // "pop",
                  // "abuse",
                  // "extend",
                  // "admire",
                  // "walk"
                  // ],
                  popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                    showSelectedItems: true,
                  ),
                  onChanged: print,
                ),
                ElevatedButton(
                  child: const Text('Áp dụng'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
