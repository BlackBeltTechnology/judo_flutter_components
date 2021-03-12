part of judo.components;

class JudoSelectorTable extends StatelessWidget {
  JudoSelectorTable({
    Key key,
    @required this.col,
    this.row = 1.0,
    @required this.dataInfo,
    @required this.rowList,
    @required this.collectionSelector,
    // this.navigateToEditPageAction,
    // this.navigateToViewPageAction,
    // this.navigateToCreatePageAction,
    // this.removeAction,
    // this.unsetAction,
    // this.deleteAction,
    @required this.singleSelectAction,
    @required this.multiSelectAction,
    @required this.singleSelectedComparator,
    @required this.multiSelectedComparator,
    this.sortAscending = true,
    this.sortColumnIndex = 0,
    this.disabled = false,
    this.onAdd,
    this.onSort,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final bool collectionSelector;
  final int col;
  final double row;
  final bool sortAscending;
  final int sortColumnIndex;
  final bool disabled;
  final JudoTableDataInfo dataInfo;
  final List rowList;
  // final Function navigateToEditPageAction;
  // final Function navigateToViewPageAction;
  // final Function navigateToCreatePageAction;
  // final Function removeAction;
  // final Function unsetAction;
  // final Function deleteAction;
  final Function singleSelectAction;
  final Function multiSelectAction;
  final Function singleSelectedComparator;
  final Function multiSelectedComparator;
  final Function onAdd;
  final Function onSort;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
        col: col,
        row: row,
        padding: padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
        stretch: stretch,
        alignment: alignment,
        child: SizedBox(
          height: row * JudoComponentCustomizer.get().getLineHeight(),
          child: SingleChildScrollView(
            child: rowList is ObservableList ? Observer(builder: (_) => dataTable(context)) : dataTable(context),
          ),
        )
    );
  }


  Widget dataTable(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Theme(
        child: Observer(
          builder: (_) => DataTable(
              onSelectAll: collectionSelector ? null : (_) {},
              headingTextStyle: theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w400, color: theme.colorScheme.secondary),
              showCheckboxColumn: true,
              sortAscending: sortAscending == null ? true : sortAscending,
              sortColumnIndex: sortColumnIndex,
              columns: dataInfo.getColumns(onAdd, onSort),
              rows: dataRow(context)
          ),
        ),
        data: theme.copyWith(
          iconTheme: theme.iconTheme.copyWith(
              color:  theme.colorScheme.secondary),
        )
    );
  }

  List<DataRow> dataRow(BuildContext context) {
    List<DataRow> dataRowList = rowList.map<DataRow>(
        dataInfo.getRow(
          context: context,
          // navigateToEditPageAction: disabled ? null : this.navigateToEditPageAction,
          // navigateToCreatePageAction: disabled ? null : this.navigateToCreatePageAction,
          // navigateToViewPageAction: disabled ? null : this.navigateToViewPageAction,
          // deleteAction: disabled ? null : this.deleteAction,
          // removeAction: disabled ? null : this.removeAction,
          // unsetAction: disabled ? null : this.unsetAction
        )
    ).toList();

    return List<DataRow>.generate(
      dataRowList.length,
          (index) => DataRow(
        selected: collectionSelector ? multiSelectedComparator(rowList[index]) : singleSelectedComparator(rowList[index]),
        onSelectChanged: (_) => collectionSelector ? multiSelectAction(rowList[index]) : singleSelectAction(rowList[index]),
        color: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              // All rows will have the same selected color.
              if (states.contains(MaterialState.selected))
                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              // Even rows will have a grey color.
              if (index % 2 == 0) return Colors.grey.withOpacity(0.05);
              return null; // Use default value for other states and odd rows.
            }
        ),
        cells: dataRowList[index].cells,
      ),
    );
  }
}
