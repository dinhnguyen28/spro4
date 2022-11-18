// main.dart
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  final popupBuilderKey = GlobalKey<DropdownSearchState<String>>();
  bool popupBuilderSelection = true;

  String text = "Chọn tất cả";

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

      // if (updateState) setState(() {});
    }

    // handleCheckBoxState(updateState: false);

    void tapFunction() {
      print(popupBuilderSelection);

      // setState(() {
      if (popupBuilderSelection) {
        popupBuilderKey.currentState!.popupDeselectAllItems();
        text = "Chọn tất cả";
      } else {
        popupBuilderKey.currentState!.popupSelectAllItems();
        text = "Xoá tất cả";
      }
      // });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: SizedBox(
        height: 70,
        child: DropdownSearch<String>.multiSelection(
          onChanged: (value) {
            print(value);
          },
          dropdownBuilder: (context, selectedItems) {
            return const SizedBox.shrink();
          },
          key: popupBuilderKey,
          selectedItems: const ["A", "B", "C", "D", "E", "F"],
          items: const ["A", "B", "C", "D", "E", "F"],
          popupProps: PopupPropsMultiSelection.modalBottomSheet(
            onItemAdded: (l, s) => handleCheckBoxState(),
            onItemRemoved: (l, s) => handleCheckBoxState(),
            containerBuilder: (ctx, popupWidget) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            tapFunction();
                          },
                          child: Text(text),
                        ),

                        // Checkbox(
                        //     value: popupBuilderSelection,
                        //     tristate: true,
                        //     onChanged: (value) {
                        //       value ??= true;
                        //       if (value == true) {
                        //         popupBuilderKey.currentState!
                        //             .popupSelectAllItems();
                        //       } else if (value == false) {
                        //         popupBuilderKey.currentState!
                        //             .popupDeselectAllItems();
                        //       }
                        //       // handleCheckBoxState();

                        //       ////
                        //       // value ??= false;
                        //       // setState(() {
                        //       //   isSelected = value;
                        //       //   if (widget.onChanged != null)
                        //       //     widget.onChanged!(value);
                        //       // });
                        //     }),
                      ],
                    ),
                    Expanded(child: popupWidget),
                  ],
                ),
              );

              // CheckBoxWidget(
              //   isSelected: popupBuilderSelection,
              //   onChanged: (selectAll) {
              //     if (selectAll == true) {
              //       popupBuilderKey.currentState!.popupSelectAllItems();
              //     } else if (selectAll == false) {
              //       popupBuilderKey.currentState!.popupDeselectAllItems();
              //     }
              //     handleCheckBoxState();
              //   },
              //   child:
              //       Container(color: Colors.amberAccent, child: popupWidget),
              // );
            },
          ),
        ),
      ),
    );
  }
}
