import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login_bloc/bloc/phase_bloc/phase_bloc.dart';
import 'package:login_bloc/bloc/phase_bloc/phase_event.dart';
import 'package:login_bloc/bloc/phase_bloc/phase_state.dart';

class RatingDialog extends StatelessWidget {
  final PhaseBloc phaseBloc;
  final int? id;

  const RatingDialog({
    super.key,
    required this.id,
    required this.phaseBloc,
  });

  @override
  Widget build(BuildContext context) {
    final _commentController = TextEditingController();

    void _cancel() {
      phaseBloc.add(const CancelRating());
      Navigator.pop(context);
    }

    void _send() {
      phaseBloc.add(RatingTicket(id, _commentController.text));

      // phaseBloc.state.popContext ? Navigator.pop(context) : null;
    }

    void _onRatingUpdate(double rating) {
      phaseBloc.add(ChangeRating(rating));
    }

    return BlocProvider.value(
      value: phaseBloc,
      child: AlertDialog(
        title: const Text('Đánh giá'),
        content: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
                allowHalfRating: true,
                minRating: 0.5,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amberAccent,
                    ),
                onRatingUpdate: (rating) => _onRatingUpdate(rating)),
            BlocBuilder<PhaseBloc, PhaseState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.checkRating,
                  child: const Text(
                    "Vui lòng nhập đầy đủ thông tin",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<PhaseBloc, PhaseState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.visible,
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Ghi chú",
                      errorText: state.validateComment
                          ? 'Vui lòng nhập đầy đủ thông tin'
                          : null,
                    ),
                  ),
                );
              },
            ),
          ],
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
      ),
    );
  }
}
