part of judo.components;

class JudoTab extends StatefulWidget {
  JudoTab({
    Key key,
    @required this.col,
    @required this.row,
    this.disabledTabs = const [], // TODO: JNG-2874
    this.hiddenTabs = const [],
    this.disabled = false,
    this.hidden = false,
    @required this.tabs,
    @required this.tabContent,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.padding,
  }) : super(key: key);

  final double col;
  final double row;
  final List<bool> disabledTabs;
  final List<bool> hiddenTabs;
  final bool disabled;
  final bool hidden;
  final List<Tab> tabs;
  final List<Widget> tabContent;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;


  TabController tabController;

  @override
  _JudoTabState createState() => _JudoTabState();
}

class _JudoTabState extends State<JudoTab> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    widget.tabController = TabController(
      length: getTabs().length,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(JudoTab oldWidget) {
    int newWidgetTabsLength = getTabs().length;

    if (oldWidget.tabController.length != newWidgetTabsLength) {
      widget.tabController = TabController(
        length: newWidgetTabsLength,
        vsync: this,
      );
    } else {
      widget.tabController = TabController(
        length: newWidgetTabsLength,
        vsync: this,
        initialIndex: oldWidget.tabController.index,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hidden) return JudoSpacer(col: widget.col, row: widget.row);

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
            child: getTabBar(context),
          ),
          Expanded(
            child: TabBarView(
              controller: widget.tabController,
              children: getTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTabBar(BuildContext context) {
    if (widget.disabled) {
      return AbsorbPointer(
        child: TabBar(
          controller: widget.tabController,
          tabs: getTabs(),
          labelColor: Theme.of(context).disabledColor,
          indicatorColor: Theme.of(context).disabledColor,

        ),
      );
    } else {
      return TabBar(
        controller: widget.tabController,
        tabs: getTabs(),
      );
    }
  }

  List<Widget> getTabs() {
    List<Widget> _tabs = List.from(widget.tabs);

    if (widget.hiddenTabs.isEmpty) {
      return _tabs;
    }

    for (int i = _tabs.length - 1; i >= 0; i--) {
      if (widget.hiddenTabs[i] ?? false) {
        _tabs.removeAt(i);
      }
    }
    print(_tabs);
    return _tabs;
  }

  List<Widget> getTabContent() {
    if (widget.hiddenTabs.isEmpty) {
      return widget.tabContent.map((e) => Column(children: [e])).toList();
    }

    List<Widget> _tabContent = List.from(widget.tabContent);

    for (int i = _tabContent.length - 1; i >= 0; i--) {
      if (widget.hiddenTabs[i] ?? false) {
        _tabContent.removeAt(i);
      }
    }
    return _tabContent.map((e) => Column(children: [e])).toList();
  }
}
