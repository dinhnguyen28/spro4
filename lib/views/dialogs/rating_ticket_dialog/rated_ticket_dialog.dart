import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spro4/bloc/phase_bloc/phase_bloc.dart';
import 'package:spro4/bloc/phase_bloc/phase_event.dart';
import 'package:spro4/bloc/phase_bloc/phase_state.dart';

final _commentController = TextEditingController();

Future<void> ratedTicketDialog(BuildContext context, PhaseBloc phaseBloc) {
  return showDialog<void>(
    // barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      // _commentController.text == phaseBloc.state.idData!.data!.comment;
      return BlocProvider.value(
        value: phaseBloc,
        child: BlocBuilder<PhaseBloc, PhaseState>(
          builder: (context, state) {
            _commentController.text = state.idData!.data!.comment!;
            return AlertDialog(
              title: const Text('Đánh giá'),
              content: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: RatingBarIndicator(
                      rating: state.idData?.data?.ticketRating ?? 0,
                      itemBuilder: (_, __) {
                        return const Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible:
                        state.idData!.data!.ticketRating! > 3 ? false : true,
                    child: Flexible(
                      child: SizedBox(
                        width: 400,
                        child: TextField(
                          readOnly: true,
                          maxLength: 100,
                          controller: _commentController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            label: Text("Ghi chú"),
                            filled: true,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Huỷ'),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
