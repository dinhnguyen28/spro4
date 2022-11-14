import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spro4/bloc/ticket_bloc/ticket_bloc.dart';

import 'package:spro4/models/ticket_model/ticket_model.dart';
import 'package:spro4/module/convert/enum_to_string.dart';
import 'package:spro4/module/deboucing/debouncer.dart';
import 'package:spro4/module/time_stamp/time_stamp.dart';
import 'package:spro4/views/dialogs/category_ticket_dialog/category_dialog.dart';
import 'package:spro4/views/dialogs/category_time_ticket_dialog/category_time_dialog.dart';
import 'package:spro4/views/dialogs/service_ticket_dialog/service_ticket_dialog.dart';
import 'package:spro4/views/phase_detail/phase_detail_page.dart';

part '../home/my_ticket_list/my_ticket_list.dart';

class MyTicketPage extends StatelessWidget {
  const MyTicketPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketBloc(),
      child: const TicketPage(),
    );
  }
}

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<StatefulWidget> createState() => TicketPageState();
}

class TicketPageState extends State<TicketPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  bool _isVisible = true;

  Icon _searchIcon = const Icon(Icons.search);
  Widget _textBar = const Text("My ticket");

  final _debouncer = Debouncer(milliseconds: 1000);

  int _onTapTabbarIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: TicketBloc().state.ticketCountTab.length, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      context.read<TicketBloc>().add(SearchTicket(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: _textBar,
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            IconButton(
                icon: _searchIcon,
                onPressed: () {
                  setState(() {
                    if (_searchIcon.icon == Icons.search) {
                      _searchIcon = const Icon(Icons.cancel);
                      _textBar = TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            hintText: 'Mã phiếu yêu cầu, tên phiếu, dịch vụ',
                          ));
                    } else {
                      _searchIcon = const Icon(Icons.search);
                      _textBar = const Text("My ticket");
                      if (_searchController.text.isNotEmpty) {
                        _searchController.clear();
                        context
                            .read<TicketBloc>()
                            .add(SearchTicket(_searchController.text));
                      }
                    }
                  });
                }),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            BlocBuilder<TicketBloc, TicketState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                List<Widget> tabsName = [];
                state.ticketCountTab.forEach(
                  (key, value) {
                    tabsName.add(
                      Row(
                        children: [
                          SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text(key.ticketStatus2String(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      )))),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Chip(
                              // backgroundColor: ,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(200),
                                      bottomRight: Radius.circular(200))),
                              label: Text(
                                value.toString(),
                                // "${value > 100 ? "99+" : value}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
                return TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: const Color(0xFF8C8C8C),
                  labelColor: Colors.blue,
                  tabs: tabsName,
                );
              },
            ),

            Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      serviceTicketDialog(context);
                    },
                    child: const Text('Dịch vụ'))
              ],
            ),
            // switch (state.status) {
            //   case Status.loading:
            //     return const SizedBox.shrink();
            //   case Status.success:
            //     if (state.ticketStatus.name == "CANCEL" ||
            //         state.ticketStatus.name == "DRAFT") {
            //       _isVisible = false;
            //     } else {
            //       _isVisible = true;
            //     }
            //     return Padding(
            //       padding: const EdgeInsets.only(
            //           left: 16, right: 16, top: 5, bottom: 5),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           Visibility(
            //             visible: _isVisible,
            //             child: Expanded(
            //               child: OutlinedButton(
            //                 style: OutlinedButton.styleFrom(
            //                   shape: const RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.all(
            //                           Radius.circular(26))),
            //                 ),
            //                 onPressed: () {
            //                   showDialog(
            //                     barrierDismissible: false,
            //                     context: context,
            //                     builder: (_) {
            //                       context
            //                           .read<TicketBloc>()
            //                           .add(const OpenDialog());

            //                       return CategoryDialog(
            //                           ticketBloc:
            //                               context.read<TicketBloc>());
            //                     },
            //                   );
            //                 },
            //                 child: const Text(
            //                   "Loại yêu cầu",
            //                   style: TextStyle(color: Color(0xFF262626)),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Expanded(
            //             child: OutlinedButton(
            //               style: OutlinedButton.styleFrom(
            //                 shape: const RoundedRectangleBorder(
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(26))),
            //               ),
            //               child: const Text(
            //                 "Thời gian",
            //                 style: TextStyle(color: Color(0xFF262626)),
            //               ),
            //               onPressed: () {
            //                 showDialog(
            //                   context: context,
            //                   builder: (_) {
            //                     return CategoryTimeDialog(
            //                         ticketBloc: context.read<TicketBloc>());
            //                   },
            //                 );
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            //   case Status.failure:
            //     return const SizedBox.shrink();
            // }
            // },
            // ),
            Expanded(
                child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                // for (int i = 0; i < _tabsLength; i++)
                for (var item in TicketBloc().state.ticketCountTab.keys)
                  MyTicketList(ticketStatus: item),
              ],
            )),
          ],
        )));
  }
}
