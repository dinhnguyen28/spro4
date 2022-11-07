import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:login_bloc/bloc/phase_bloc/phase_bloc.dart';
import 'package:login_bloc/bloc/phase_bloc/phase_event.dart';
import 'package:login_bloc/bloc/phase_bloc/phase_state.dart';
import 'package:login_bloc/bloc/ticket_bloc/ticket_bloc.dart' as ticketbloc;

import 'package:login_bloc/views/dialogs/cancel_ticket_dialog/dialog_cancel_ticket.dart';

class PhaseDetail extends StatefulWidget {
  const PhaseDetail({
    super.key,
    required this.id,
    required this.ticketTitle,
    required this.ticketStatus,
  });

  final int id;
  final String? ticketTitle;
  final ticketbloc.TicketStatus ticketStatus;

  @override
  State<PhaseDetail> createState() => PhaseDetailState();
}

class PhaseDetailState extends State<PhaseDetail> {
  final expanController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          // iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
        ),
      ),
      home: BlocProvider(
        create: (context) => PhaseBloc()..add(LoadPhaseDetail(widget.id)),
        child: Scaffold(
          floatingActionButton: BlocBuilder<PhaseBloc, PhaseState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              switch (state.status) {
                case Status.loading:
                  break;
                case Status.success:
                  List<String> listStatus = ticketbloc
                      .listStatus[ticketbloc.TicketStatus.ONGOING]!
                      .map((e) => e.name)
                      .toList();

                  if (listStatus.contains(state.idData!.data!.ticketStatus)) {
                    return ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return CanCelDialog(
                                ticketId: state.idData!.data!.ticketId,
                                phaseBloc: context.read<PhaseBloc>(),
                              );
                            });
                      },
                      child: const Text('Huỷ phiếu'),
                    );
                  }
                  break;
                case Status.failure:
                  break;
              }
              return const SizedBox.shrink();
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          backgroundColor: const Color(0xFFE5E5E5),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text("Phase detail"),
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              IconButton(
                icon: SvgPicture.asset("assets/union.svg"),
                onPressed: () {
                  //
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '[${widget.id}] - ${widget.ticketTitle}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFF262626),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    color: Colors.white,
                    child: ExpandableNotifier(
                        initialExpanded: true,
                        child: Column(
                          children: <Widget>[
                            ExpandablePanel(
                              theme: const ExpandableThemeData(
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                tapBodyToCollapse: false,
                              ),
                              header: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 15,
                                  bottom: 15,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                        "assets/ticket_information.svg"),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text('Ticket Infomation',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF262626))),
                                    ),
                                  ],
                                ),
                              ),
                              collapsed: const SizedBox.shrink(),
                              expanded: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 12, bottom: 14),
                                child:
                                    // color: Colors.yellowAccent,
                                    BlocBuilder<PhaseBloc, PhaseState>(
                                  builder: (context, state) {
                                    switch (state.status) {
                                      case Status.loading:
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      case Status.success:
                                        List<Widget> widgets = [];

                                        state.listTicketInfo!
                                            .forEach((key, value) {
                                          if (key == 'Trạng thái') {
                                            widgets.add(
                                              // color: Colors.lightBlueAccent,
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 140,
                                                      child: Text(key,
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF8C8C8C),
                                                            fontSize: 16,
                                                          )),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 14),
                                                      child: Transform(
                                                        transform:
                                                            Matrix4.identity()
                                                              ..scale(0.7),
                                                        child: Chip(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFFE8F4FF),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .blue),
                                                            label: Text(value,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 16,
                                                                ))),
                                                      ),
                                                    )
                                                  ]),
                                            );
                                          } else {
                                            widgets.add(Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 140,
                                                      child: Text(key,
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF8C8C8C),
                                                            fontSize: 16,
                                                          )),
                                                    ),
                                                    Flexible(
                                                      child: Text(value,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF262626),
                                                            fontSize: 16,
                                                          )),
                                                    )
                                                  ]),
                                            ));
                                          }
                                        });

                                        return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: widgets);

                                      case Status.failure:
                                        return const Center(
                                            child: Text("Failed to load"));
                                    }
                                  },
                                ),
                              ),
                              builder: (_, collapsed, expanded) {
                                return Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                );
                              },
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
