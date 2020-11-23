part of judo.components;

class JudoTab extends StatefulWidget {
  JudoTab({
    @required this.col,
    @required this.tabs,
    @required this.tabContent,
  });

  final int col;
  final List<Tab> tabs;
  final List<Widget> tabContent;
  TabController tabController;

  @override
  _JudoTabState createState() => _JudoTabState();
}

class _JudoTabState extends State<JudoTab> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(JudoTab oldWidget) {
    if (oldWidget.tabs.length != widget.tabs.length) {
      widget.tabController = TabController(
        length: widget.tabs.length,
        vsync: this,
      );
    } else {
      widget.tabController = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: oldWidget.tabController.index,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.col,
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: JudoComponentsSettings.height),
            child: TabBar(
              controller: widget.tabController,
              tabs: widget.tabs,
              labelColor: JudoComponentsSettings.primaryColor,
              indicatorColor: JudoComponentsSettings.primaryColor,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: widget.tabController,
              children:
              widget.tabContent.map((e) => Column(children: [e])).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
