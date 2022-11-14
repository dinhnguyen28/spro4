import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/ticket_bloc/ticket_bloc.dart';

Future<void> loadingDialog(BuildContext context) async {
  return showDialog<void>(
    // barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            AlertDialog(
              content: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
