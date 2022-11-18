import 'package:flutter/material.dart';
import 'package:spro4/views/example_view/test_view.dart';

import '../../my_ticket_page/my_ticket_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Home page"),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyTicketPage()),
                    );
                  },
                  child: const Text("Phiếu yêu cầu của tôi")),
            ),
            const SizedBox(
              height: 40,
            ),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: ()

            // {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => const TestView()),
            //   );
            // },
            // child: const Text("TEST"),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
