import 'package:flutter/material.dart';
import 'package:login_bloc/models/ticket_model/ticket_model.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(content.procServiceName.toString()),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
