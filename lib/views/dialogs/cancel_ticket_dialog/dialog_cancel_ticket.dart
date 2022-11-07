import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/bloc/phase_bloc/phase_bloc.dart';
import 'package:login_bloc/bloc/phase_bloc/phase_event.dart';

class CanCelDialog extends StatelessWidget {
  final PhaseBloc phaseBloc;
  final String? ticketId;

  const CanCelDialog(
      {super.key, required this.ticketId, required this.phaseBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: phaseBloc,
      child: CanCelDialogState(ticketId: ticketId),
    );
  }
}

class CanCelDialogState extends StatefulWidget {
  final String? ticketId;

  const CanCelDialogState({Key? key, required this.ticketId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyCanCelDialog();
}

class MyCanCelDialog extends State<CanCelDialogState> {
  final _cancelController = TextEditingController();
  bool _validate = false;
  void _cancel() {
    Navigator.pop(context);
  }

  void _send() {
    setState(() {
      _cancelController.text.isEmpty ? _validate = true : _validate = false;
    });
    if (_validate == false) {
      context
          .read<PhaseBloc>()
          .add(CancelTicket(widget.ticketId, _cancelController.text));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _cancelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Hủy phiếu yêu cầu'),
      content: TextField(
        controller: _cancelController,
        decoration: InputDecoration(
          hintText: "Lý do",
          errorText: _validate ? 'Vui lòng nhập lý do' : null,
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Huỷ'),
        ),
        ElevatedButton(
          onPressed: _send,
          child: const Text('Gửi'),
        ),
      ],
    );
  }
}
