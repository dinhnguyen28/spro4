part of '/views/home/home_page.dart';

class MyTicketList extends StatelessWidget {
  const MyTicketList({
    super.key,
    required this.ticketStatus,
    required this.ticketBloc,
  });

  final TicketStatus ticketStatus;
  final TicketBloc ticketBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ticketBloc,
      child: TicketList(ticketStatus: ticketStatus),
    );
  }
}

class TicketList extends StatefulWidget {
  const TicketList({super.key, required this.ticketStatus});
  final TicketStatus ticketStatus;

  @override
  State<TicketList> createState() => TicketListState();
}

class TicketListState extends State<TicketList> {
  final _scrollController = ScrollController();
  final _debouncer = Debouncer(milliseconds: 100);

  @override
  void initState() {
    super.initState();
    context.read<TicketBloc>().add(LoadAllTicket(widget.ticketStatus));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final currentScroll = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (currentScroll == maxScroll) {
      _debouncer.run(() {
        context.read<TicketBloc>().add(const LoadMoreTicket());
      });
    }
  }

  Future<void> _onRefresh() async {
    context.read<TicketBloc>().add(const RefreshTicket());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.success:
            if (state.ticketContent.isEmpty) {
              return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: const SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Center(child: Text('Không có phiếu'))),
                  ));
            }
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.ticketContent.length
                      ? const BottomLoader()
                      : TicketListItem(
                          content: state.ticketContent[index],
                          ticketStatus: widget.ticketStatus);
                },
                itemCount: state.hasReachedMax
                    ? state.ticketContent.length
                    : state.ticketContent.length + 1,
                controller: _scrollController,
              ),
            );

          case Status.failure:
            return const Center(child: Text('Không thể tải phiếu'));
        }
      },
    );
  }
}

class TicketListItem extends StatelessWidget {
  const TicketListItem({
    super.key,
    required this.content,
    required this.ticketStatus,
  });

  final Content content;
  final TicketStatus ticketStatus;

  @override
  Widget build(BuildContext context) {
    String dates = readTimestamp(content.ticketCreatedTime!, "dd/MM");

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PhaseDetail(
                    id: content.id ?? 0,
                    ticketTitle: content.ticketTitle,
                    ticketStatus: ticketStatus))).then(
            (_) => context.read<TicketBloc>().add(LoadAllTicket(ticketStatus)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(
              color: Color(0xFFE8E8E8),
            ),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: CircleAvatar(),
                    ),
                    Flexible(
                      child: Text(
                        content.ticketTitle ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        content.id.toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF262626)),
                      ),
                      Chip(
                        label: Text(
                          content.ticketStatus ?? "",
                          style: const TextStyle(color: Colors.blue),
                        ),
                        backgroundColor: const Color(0xFFE8F4FF),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BlocBuilder<TicketBloc, TicketState>(
                        builder: (context, state) {
                          if (state.ticketStatus.name == "COMPLETED") {
                            dates = readTimestamp(
                                content.ticketFinishTime!, 'dd/MM');
                          } else if (state.ticketStatus.name == "CANCEL") {
                            dates = readTimestamp(
                                content.ticketCanceledTime!, 'dd/MM');
                          }
                          return Text(
                            dates,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF8C8C8C)),
                          );
                        },
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            content.procServiceName ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF8C8C8C)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
      ),
    );
  }
}
