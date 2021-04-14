part of judo.components;

class JudoTab extends StatefulWidget {
  JudoTab({
    Key key,
    @required this.col,
    @required this.row,
    @required this.tabs,
    @required this.tabContent,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.padding,
  }) : super(key: key);

  final double col;
  final double row;
  final List<Tab> tabs;
  final List<Widget> tabContent;
  TabController tabController;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

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
    return JudoContainer(
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: JudoComponentCustomizer.get().getLineHeight()),
            child: TabBar(
              controller: widget.tabController,
              tabs: widget.tabs,
//              labelColor: JudoComponentsSettings.primaryColor,
//              indicatorColor: JudoComponentsSettings.primaryColor,
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
