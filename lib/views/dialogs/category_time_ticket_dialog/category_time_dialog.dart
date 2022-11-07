import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:login_bloc/bloc/ticket_bloc/ticket_bloc.dart';

class CategoryTimeDialog extends StatelessWidget {
  const CategoryTimeDialog({super.key, required this.ticketBloc});

  final TicketBloc ticketBloc;

  @override
  Widget build(BuildContext context) {
    final fromDateController = TextEditingController();
    final toDateController = TextEditingController();
    final fromDateFinishController = TextEditingController();
    final toDateFinishController = TextEditingController();
    final fromDateCancelController = TextEditingController();
    final toDateCancelController = TextEditingController();

    bool _isFinishVisibility = false;
    bool _isCancelVisibility = false;

    void delete() {
      // ticketBloc.add(const CategoryTimeSubmit("", ""));
      fromDateController.clear();
      toDateController.clear();
      fromDateFinishController.clear();
      toDateFinishController.clear();
      fromDateCancelController.clear();
      toDateCancelController.clear();
    }

    void cancel() {
      Navigator.pop(context);
    }

    void submit() {
      Navigator.pop(context);
      ticketBloc.add(CategoryTimeSubmit(
        fromDateController.text,
        toDateController.text,
        fromDateFinishController.text,
        toDateFinishController.text,
        fromDateCancelController.text,
        toDateCancelController.text,
      ));
    }

    return BlocProvider.value(
      value: ticketBloc,
      child: AlertDialog(
        title: const Text("Thời gian"),
        content: BlocBuilder<TicketBloc, TicketState>(
          builder: (context, state) {
            fromDateController.text = state.fromDate;
            toDateController.text = state.toDate;

            fromDateFinishController.text = state.fromDateFinish;
            toDateFinishController.text = state.toDateFinish;

            fromDateCancelController.text = state.fromDateCancel;
            toDateCancelController.text = state.toDateCancel;

            switch (state.ticketStatus) {
              case TicketStatus.COMPLETED:
                _isFinishVisibility = true;
                break;
              case TicketStatus.CANCEL:
                _isCancelVisibility = true;
                break;
              default:
                break;
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text("Thời gian tạo"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: fromDateController,
                            decoration: const InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              labelText: "Từ ngày",
                            ),
                            onTap: () async {
                              DateTime? fromDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime(2030));

                              if (fromDate != null) {
                                fromDateController.text =
                                    DateFormat('dd/MM/yyyy').format(fromDate);
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: toDateController,
                            decoration: const InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              labelText: "Đến ngày",
                            ),
                            onTap: () async {
                              DateTime? toDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime(2030));

                              if (toDate != null) {
                                toDateController.text =
                                    DateFormat('dd/MM/yyyy').format(toDate);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _isFinishVisibility,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text("Thời gian hoàn thành"),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
                                readOnly: true,
                                controller: fromDateFinishController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  labelText: "Từ ngày",
                                ),
                                onTap: () async {
                                  DateTime? fromDateFinish =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2021),
                                          lastDate: DateTime(2030));

                                  if (fromDateFinish != null) {
                                    fromDateFinishController.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(fromDateFinish);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: TextField(
                                readOnly: true,
                                controller: toDateFinishController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  labelText: "Đến ngày",
                                ),
                                onTap: () async {
                                  DateTime? toDateFinish = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2030));

                                  if (toDateFinish != null) {
                                    toDateFinishController.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(toDateFinish);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _isCancelVisibility,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text("Thời gian huỷ"),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
                                readOnly: true,
                                controller: fromDateCancelController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  labelText: "Từ ngày",
                                ),
                                onTap: () async {
                                  DateTime? fromDateCancel =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2021),
                                          lastDate: DateTime(2030));

                                  if (fromDateCancel != null) {
                                    fromDateCancelController.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(fromDateCancel);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: TextField(
                                readOnly: true,
                                controller: toDateCancelController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  labelText: "Đến ngày",
                                ),
                                onTap: () async {
                                  DateTime? toDateCancel = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2030));

                                  if (toDateCancel != null) {
                                    toDateCancelController.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(toDateCancel);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: delete,
            child: const Text(
              'Xoá',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: cancel,
            child: const Text('Huỷ'),
          ),
          ElevatedButton(
            onPressed: submit,
            child: const Text('Áp dụng'),
          ),
        ],
      ),
    );
  }
}
