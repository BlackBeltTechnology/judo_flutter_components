part of judo.components;

class JudoSelectorTable extends StatelessWidget {
  JudoSelectorTable({
    Key key,
    @required this.col,
    this.row = 1.0,
    @required this.dataInfo,
    @required this.rowList,
    @required this.collectionSelector,
    this.dialogTypeAdder = false,
    this.alreadyAddedItemsComparator,
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
  final double col;
  final double row;
  final bool sortAscending;
  final int sortColumnIndex;
  final bool disabled;
  final JudoTableDataInfo dataInfo;
  final List rowList;
  final bool dialogTypeAdder;
  final Function alreadyAddedItemsComparator;
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
            child: rowList is ObservableList ? Observer(builder: (_) => dataTable(context)) : dataTable(context),
          ),
        )
    );
  }

  Widget dataTable(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Theme(
        child: DataTable(
              onSelectAll: collectionSelector ? null : (_) {},
              headingTextStyle: theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w400, color: theme.colorScheme.secondary),
              showCheckboxColumn: true,
              sortAscending: sortAscending == null ? true : sortAscending,
              sortColumnIndex: sortColumnIndex,
              columns: dataInfo.getColumns(onAdd, onSort),
              rows: dataRow(context),
              dataRowHeight: JudoComponentCustomizer.get().getLineHeight(),
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
        )
    ).toList();

    return List<DataRow>.generate(
      dataRowList.length,
          (index) => DataRow(
        selected: collectionSelector ? multiSelectedComparator(rowList[index]) : singleSelectedComparator(rowList[index]),
        onSelectChanged: (_) => collectionSelector ?
            ( dialogTypeAdder && alreadyAddedItemsComparator(rowList[index]) ? null : multiSelectAction(rowList[index]) )
            : singleSelectAction(rowList[index]),
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
