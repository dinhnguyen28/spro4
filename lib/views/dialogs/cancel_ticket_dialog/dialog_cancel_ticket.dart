import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spro4/bloc/phase_bloc/phase_bloc.dart';
import 'package:spro4/bloc/phase_bloc/phase_event.dart';
import 'package:spro4/bloc/phase_bloc/phase_state.dart';

final _reasonController = TextEditingController();
bool checkReason = false;

Future<void> cancelTicketDialog(context, PhaseBloc phaseBloc) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: phaseBloc,
          child: StatefulBuilder(
            builder: (_, setState) {
              return BlocBuilder<PhaseBloc, PhaseState>(
                builder: (context, state) {
                  return AlertDialog(
                    title: const Text('Hủy phiếu yêu cầu'),
                    content: TextField(
                      controller: _reasonController,
                      decoration: InputDecoration(
                        hintText: "Lý do",
                        errorText: checkReason ? 'Vui lòng nhập lý do' : null,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          checkReason = false;
                        },
                        child: const Text('Huỷ'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_reasonController.text.isEmpty) {
                              checkReason = true;
                            } else {
                              checkReason = false;
                              phaseBloc
                                  .add(CancelTicket(_reasonController.text));
                              _reasonController.clear();

                              Navigator.of(context).pop();
                            }
                            // if (state.popContext) {
                            //   phaseBloc
                            //       .add(CancelTicket(_reasonController.text));
                            //   _reasonController.clear();
                            //   Navigator.of(context).pop();
                            // } else {
                            //   phaseBloc
                            //       .add(CancelTicket(_reasonController.text));
                            // }
                          });
                        },
                        child: const Text('Gửi'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      });
}
