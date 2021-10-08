part of judo.components;

abstract class JudoTableDataInfo {
  List<DataColumn> getColumns(Function onAdd, DataColumnSortCallback onSort);
  Function getRow({BuildContext context,
    Function navigateToEditPageAction,
    Function navigateToViewPageAction,
    Function navigateToCreatePageAction,
    Function removeAction,
    Function unsetAction,
    Function deleteAction});
}

class JudoTable extends StatelessWidget {
  JudoTable({
    Key key,
    @required this.col,
    this.row = 2.0,
    @required this.dataInfo,
    @required this.rowList,
    this.navigateToEditPageAction,
    this.navigateToViewPageAction,
    this.navigateToCreatePageAction,
    this.removeAction,
    this.unsetAction,
    this.deleteAction,
    this.sortAscending = true,
    this.sortColumnIndex = 0,
    this.disabled = false,
    this.onAdd,
    this.onSort,
    this.padding,
    this.stretch = false,
    this.inCard = false,
    this.alignment = Alignment.centerLeft,
    this.sortInitially = false,
    this.tableActions = const <int, JudoMenuItemData>{},
  }) : super(key: key);

  final double col;
  final double row;
  final bool sortAscending;
  final int sortColumnIndex;
  final bool disabled;
  final JudoTableDataInfo dataInfo;
  final List rowList;
  final Function navigateToEditPageAction;
  final Function navigateToViewPageAction;
  final Function navigateToCreatePageAction;
  final Function removeAction;
  final Function unsetAction;
  final Function deleteAction;
  final Function onAdd;
  final Function onSort;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool inCard;
  final bool sortInitially;
  final Map<int, JudoMenuItemData> tableActions;

  @override
  Widget build(BuildContext context) {
    return rowList is ObservableList ? Observer(builder: (_) => container(context)) : container(context);
  }

  Widget container(BuildContext context) {
    var currentRow = (rowList.length + 1) < row ? rowList.length + 1 : row;
    return JudoContainer(
        col: col,
        row: currentRow,
        padding: padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
        stretch: stretch,
        alignment: alignment,
        child: SizedBox(
          height: currentRow * JudoComponentCustomizer.get().getLineHeight(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: rowList is ObservableList ? Observer(builder: (_) => dataTable(context)) : dataTable(context),
    		)
          ),
        )
    );
  }

  Widget dataTable(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Theme(
      child: DataTable(
        headingTextStyle: JudoComponentCustomizer.get().getTableHeaderTextStyle(Theme.of(context)),
        onSelectAll: (b) {},
        showCheckboxColumn: false,
        sortAscending: _shouldSortAscending(),
        sortColumnIndex: sortColumnIndex,
        columns: tableActions.isEmpty ? dataInfo.getColumns(onAdd, onSort) : [...dataInfo.getColumns(onAdd, onSort), DataColumn(label: getPopupButton())],
        rows: dataRow(context),
        dataRowHeight: JudoComponentCustomizer.get().getLineHeight(),
        headingRowHeight: JudoComponentCustomizer.get().getLineHeight(),
      ),
      data: JudoComponentCustomizer.get().getTableThemeData(theme),
    );
  }

  List<DataRow> dataRow(BuildContext context) {
    List<DataRow> dataRowList = rowList.map<DataRow>(
        dataInfo.getRow(
          context: context,
          navigateToEditPageAction: disabled ? null : this.navigateToEditPageAction,
          navigateToCreatePageAction: disabled ? null : this.navigateToCreatePageAction,
          navigateToViewPageAction: disabled ? null : this.navigateToViewPageAction,
          deleteAction: disabled ? null : this.deleteAction,
          removeAction: disabled ? null : this.removeAction,
          unsetAction: disabled ? null : this.unsetAction)
    ).toList();

    return List<DataRow>.generate(
          dataRowList.length,
            (index) => DataRow(
              onSelectChanged: navigateToViewPageAction != null ? (newValue) => navigateToViewPageAction(rowList[index]) : null,
              color: JudoComponentCustomizer.get().getRowColor(Theme.of(context), index, inCard),
              cells: dataRowList[index].cells,
//        selected: selected[index],
//        onSelectChanged: (bool value) {
//          setState(() {
//            selected[index] = value;
//          });
//        },
              ),
          );
  }
  
  bool _shouldSortAscending() {
    return sortAscending == null ? true : sortAscending;
  }

  JudoAppBarPopupButton getPopupButton() {
    return JudoAppBarPopupButton<int>(
      icon: Icon(Icons.more_vert),
      items: tableActions,
      outlined: false,
      padding: EdgeInsets.all(0),
    );
  }
}
