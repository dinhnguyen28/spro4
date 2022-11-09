import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_bloc/bloc/ticket_bloc/ticket_bloc.dart';

import 'package:login_bloc/models/ticket_model/ticket_model.dart';
import 'package:login_bloc/module/convert/enum_to_string.dart';
import 'package:login_bloc/module/deboucing/debouncer.dart';
import 'package:login_bloc/module/time_stamp/time_stamp.dart';
import 'package:login_bloc/views/dialogs/category_ticket_dialog/category_dialog.dart';
import 'package:login_bloc/views/dialogs/category_time_ticket_dialog/category_time_dialog.dart';
import 'package:login_bloc/views/phase_detail/phase_detail_page.dart';

part 'my_ticket_list/my_ticket_list.dart';
part '../dialogs/dialog_filter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketBloc(),
      child: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  List<Tab> tabs = <Tab>[];

  Icon _searchIcon = const Icon(Icons.search);
  final Widget _textBar = const Text("My ticket");

  final int _tabsLength = 5;

  PreferredSizeWidget _bottomSearch = const PreferredSize(
    preferredSize: Size(0, 0),
    child: SizedBox(),
  );

  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabsLength, vsync: this);
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
    bool _isVisible = true;

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          // iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
        ),
      ),
      home: Scaffold(
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
                        _bottomSearch = PreferredSize(
                            preferredSize: const Size(0, 70),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, bottom: 10.0),
                                child: TextField(
                                    controller: _searchController,
                                    onChanged: _onSearchChanged,
                                    decoration: InputDecoration(
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: BorderSide.none),
                                      hintText:
                                          'Mã phiếu yêu cầu, tên phiếu, dịch vụ',
                                    ))));
                      } else {
                        _searchIcon = const Icon(Icons.search);
                        _bottomSearch = const PreferredSize(
                            preferredSize: Size(0, 0),
                            child: SizedBox.shrink());
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
            bottom: _bottomSearch,
          ),
          body: SafeArea(
              child: Column(
            children: [
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: const Color(0xFF8C8C8C),
                labelColor: Colors.blue,
                tabs: <Widget>[
                  for (int i = 0; i < _tabsLength; i++)
                    SizedBox(
                        height: 40,
                        width: 120,
                        child: Center(
                          child:
                              Text(TicketStatus.values[i].ticketStatus2String(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  )),
                        )),
                ],
              ),
              BlocBuilder<TicketBloc, TicketState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.loading:
                      return const SizedBox.shrink();
                    case Status.success:
                      if (state.ticketStatus.name == "CANCEL" ||
                          state.ticketStatus.name == "DRAFT") {
                        _isVisible = false;
                      } else {
                        _isVisible = true;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Visibility(
                              visible: _isVisible,
                              child: Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(26))),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) {
                                        context
                                            .read<TicketBloc>()
                                            .add(const OpenDialog());

                                        return CategoryDialog(
                                            ticketBloc:
                                                context.read<TicketBloc>());
                                      },
                                    );
                                  },
                                  child: const Text(
                                    "Loại yêu cầu",
                                    style: TextStyle(color: Color(0xFF262626)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(26))),
                                ),
                                child: const Text(
                                  "Thời gian",
                                  style: TextStyle(color: Color(0xFF262626)),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CategoryTimeDialog(
                                          ticketBloc:
                                              context.read<TicketBloc>());
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    case Status.failure:
                      return const SizedBox.shrink();
                  }
                },
              ),
              Expanded(
                  child: TabBarView(
                // physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: <Widget>[
                  for (int i = 0; i < _tabsLength; i++)
                    MyTicketList(
                        ticketStatus: TicketStatus.values[i],
                        ticketBloc: context.read<TicketBloc>()),
                ],
              )),
            ],
          ))),
    );
  }
}
