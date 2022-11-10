import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spro4/bloc/phase_bloc/phase_bloc.dart';
import 'package:spro4/bloc/phase_bloc/phase_event.dart';
import 'package:spro4/bloc/phase_bloc/phase_state.dart';

final _commentController = TextEditingController();

Future<void> ratingTicketDialog(BuildContext context, PhaseBloc phaseBloc) {
  String _value = '';
  return showDialog<void>(
    // barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: phaseBloc,
        child: BlocBuilder<PhaseBloc, PhaseState>(
          builder: (context, state) {
            return AlertDialog(
              title: const Text('Đánh giá'),
              content: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: RatingBar.builder(
                      allowHalfRating: true,
                      minRating: 0.5,
                      itemBuilder: (_, __) => const Icon(
                        Icons.star,
                        color: Colors.amberAccent,
                      ),
                      onRatingUpdate: (rating) {
                        phaseBloc.add(ChangeRating(rating));
                      },
                    ),
                  ),
                  Visibility(
                    visible: state.checkRating,
                    child: const Text(
                      "Vui lòng nhập đầy đủ thông tin",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state.visible,
                    child: Flexible(
                         child: SizedBox(
                        width: 400,
                        child: TextField(
                          maxLength: 100,
                          // controller: _commentController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            label: const Text("Ghi chú"),
                            filled: true,
                            errorText: state.validateComment
                                ? 'Vui lòng nhập đầy đủ thông tin'
                                : null,
                          ),
                          onChanged: (value) {
                            _value = value;
                          },
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
                    phaseBloc.add(const CancelRating());
                    Navigator.of(context).pop();
                  },
                  child: const Text('Huỷ'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (state.popContext) {
                      phaseBloc.add(RatingTicket(_value));
                      Navigator.of(context).pop();
                    } else if (state.visible && _value.isNotEmpty) {
                      phaseBloc.add(RatingTicket(_value));
                      Navigator.of(context).pop();
                    } else {
                      phaseBloc.add(RatingTicket(_value));
                    }
                  },
                  child: const Text('Gửi'),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
