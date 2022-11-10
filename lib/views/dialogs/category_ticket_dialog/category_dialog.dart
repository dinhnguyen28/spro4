import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spro4/bloc/ticket_bloc/ticket_bloc.dart';
import 'package:spro4/module/convert/enum_to_string.dart';

class CategoryDialog extends StatelessWidget {
  const CategoryDialog({super.key, required this.ticketBloc});

  final TicketBloc ticketBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ticketBloc,
      child: const MyCategoryDialog(),
    );
  }
}

class MyCategoryDialog extends StatefulWidget {
  // final List<String> items;

  const MyCategoryDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyCategoryDialogState();
}

class MyCategoryDialogState extends State<MyCategoryDialog> {
  // this variable holds the selected items

  @override
  Widget build(BuildContext context) {
    void _cancel() {
      Navigator.pop(context);
      context.read<TicketBloc>().add(const CategoryCancel());
    }

    void _delete() {
      context.read<TicketBloc>().add(const CategoryDelete());
    }

    void _submit() {
      Navigator.pop(context);
      context.read<TicketBloc>().add(const CategoryTicket());
    }

    return AlertDialog(
      title: const Text("Trạng thái"),
      content:
          SingleChildScrollView(child: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          return ListBody(
            children: [
              for (var item in listStatus[state.ticketStatus]!)
                CheckboxListTile(
                    title: Text(item.ticketStatus2String()),
                    value: state.listStatus.contains(item),
                    onChanged: (isChecked) {
                      setState(() {
                        context
                            .read<TicketBloc>()
                            .add(CategoryChecked(isChecked!, item));
                      });
                    }),
            ],
          );
        },
      )),
      actions: [
        TextButton(
          onPressed: _delete,
          child: const Text(
            'Đặt lại',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: _cancel,
          child: const Text('Huỷ'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Áp dụng'),
        ),
      ],
    );
  }
}
