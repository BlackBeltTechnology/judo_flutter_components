part of judo.components;

class JudoSelectorTable extends StatelessWidget {
  JudoSelectorTable({
    Key? key,
    required this.col,
    this.row = 1.0,
    required this.dataInfo,
    required this.rowList,
    required this.collectionSelector,
    this.dialogTypeAdder = false,
    this.alreadyAddedItemsComparator,
    required this.singleSelectAction,
    required this.multiSelectAction,
    required this.singleSelectedComparator,
    required this.multiSelectedComparator,
    this.sortAscending = true,
    this.sortColumnIndex = 0,
    this.disabled = false,
    required this.onAdd,
    required this.onSort,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final bool collectionSelector;
  final double col;
  final double row;
  final bool? sortAscending;
  final int sortColumnIndex;
  final bool disabled;
  final JudoTableDataInfo dataInfo;
  final List rowList;
  final bool dialogTypeAdder;
  final Function? alreadyAddedItemsComparator;
  final Function singleSelectAction;
  final Function multiSelectAction;
  final Function singleSelectedComparator;
  final Function multiSelectedComparator;
  final Function onAdd;
  final DataColumnSortCallback onSort;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return rowList is ObservableList ? Observer(builder: (_) => container(context)) : container(context);
  }

  Widget container(BuildContext context) {
    double currentRow = (rowList.length + 1) < row ? rowList.length + 1 : row;
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
              headingTextStyle: JudoComponentCustomizer.get().getTableHeaderTextStyle(theme),
              showCheckboxColumn: true,
              sortAscending: sortAscending == null ? true : sortAscending!,
              sortColumnIndex: sortColumnIndex,
              columns: dataInfo.getColumns(onAdd, onSort),
              rows: dataRow(context),
              dataRowHeight: JudoComponentCustomizer.get().getLineHeight(),
          ),
        data: JudoComponentCustomizer.get().getTableThemeData(theme),
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
        onSelectChanged: (_) {
          if (dialogTypeAdder && alreadyAddedItemsComparator!(rowList[index])) return;

          if (collectionSelector) {
            multiSelectAction(rowList[index]);
          } else {
            singleSelectAction(rowList[index]);
          }
        },
        color: JudoComponentCustomizer.get().getRowColor(Theme.of(context), index, true),
        cells: dataRowList[index].cells,
      ),
    );
  }
}
