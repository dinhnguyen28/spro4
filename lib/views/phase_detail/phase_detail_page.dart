import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:spro4/bloc/phase_bloc/phase_bloc.dart';
import 'package:spro4/bloc/phase_bloc/phase_event.dart';
import 'package:spro4/bloc/phase_bloc/phase_state.dart';
import 'package:spro4/bloc/ticket_bloc/ticket_bloc.dart' as ticketbloc;

import 'package:spro4/views/dialogs/cancel_ticket_dialog/dialog_cancel_ticket.dart';
import 'package:spro4/views/dialogs/rating_ticket_dialog/rated_ticket_dialog.dart';

import 'package:spro4/views/dialogs/rating_ticket_dialog/rating_ticket_dialog.dart';

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
    return BlocProvider(
      create: (context) => PhaseBloc()..add(LoadPhaseDetail(widget.id)),
      child: Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                // MediaQuery.of(context).size.width,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: ExpandableNotifier(
                              initialExpanded: true,
                              child: ExpandablePanel(
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
                                  child: BlocBuilder<PhaseBloc, PhaseState>(
                                    builder: (context, state) {
                                      switch (state.status) {
                                        case Status.loading:
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        case Status.success:
                                          List<Widget> widgets = [];

                                          state.listTicketInfo
                                              .forEach((key, value) {
                                            if (key == 'Đánh giá' &&
                                                ["COMPLETED", "CLOSED"]
                                                    .contains(state.idData!
                                                        .data!.ticketStatus)) {
                                              widgets.add(
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0),
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 144,
                                                          child: Text(key,
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF8C8C8C),
                                                                fontSize: 16,
                                                              )),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (state
                                                                    .idData!
                                                                    .data!
                                                                    .ticketStatus ==
                                                                "COMPLETED") {
                                                              ratingTicketDialog(
                                                                  context,
                                                                  context.read<
                                                                      PhaseBloc>());
                                                            } else if (state
                                                                    .idData!
                                                                    .data!
                                                                    .ticketStatus ==
                                                                "CLOSED") {
                                                              ratedTicketDialog(
                                                                  context,
                                                                  context.read<
                                                                      PhaseBloc>());
                                                            }
                                                          },
                                                          child:
                                                              RatingBarIndicator(
                                                            itemSize: 23,
                                                            rating: value,
                                                            itemBuilder:
                                                                (_, __) {
                                                              return const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amberAccent,
                                                              );
                                                            },
                                                          ),
                                                        )
                                                      ]),
                                                ),
                                              );
                                            } else if (key == 'Trạng thái') {
                                              widgets.add(
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 144,
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
                                                            const EdgeInsets
                                                                .only(top: 14),
                                                        child: Transform(
                                                          transform:
                                                              Matrix4.identity()
                                                                ..scale(0.7),
                                                          child: Chip(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFFE8F4FF),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .blue),
                                                              label: Text(value,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontSize:
                                                                        16,
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 144,
                                                        child: Text(key,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF8C8C8C),
                                                              fontSize: 16,
                                                            )),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                            value == 0.0 ||
                                                                    value == ""
                                                                ? "-"
                                                                : value
                                                                    .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
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

                                          return Column(children: widgets);

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
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<PhaseBloc, PhaseState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.success:
                      List<String> listStatus = ticketbloc
                          .listStatus[ticketbloc.TicketStatus.ONGOING]!
                          .map((e) => e.name)
                          .toList();

                      if (listStatus
                          .contains(state.idData!.data!.ticketStatus)) {
                        return TextButton(
                          onPressed: () {
                            cancelTicketDialog(
                                context, context.read<PhaseBloc>());
                          },
                          child: const Text('Huỷ phiếu'),
                        );
                      }
                      break;
                    default:
                      break;
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
