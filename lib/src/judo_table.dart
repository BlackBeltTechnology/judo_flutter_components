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
  Comparator getSortComparator(int columnIndex, bool asc);
}

class JudoTable extends StatelessWidget {
  JudoTable({
    Key key,
    @required this.col,
    this.row = 1.0,
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
        headingTextStyle: theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w400, color: theme.colorScheme.secondary),
        onSelectAll: (b) {},
        showCheckboxColumn: false,
        sortAscending: sortAscending == null ? true : sortAscending,
        sortColumnIndex: sortColumnIndex,
        columns: dataInfo.getColumns(onAdd, onSort),
        rows: dataRow(context),
        dataRowHeight: JudoComponentCustomizer.get().getLineHeight(),
        headingRowHeight: JudoComponentCustomizer.get().getLineHeight(),
        columnSpacing: 15.0,
        horizontalMargin: 24.0,
        dividerThickness: 0.0,
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
              onSelectChanged: (newValue) => navigateToViewPageAction(rowList[index]),
              color: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                // All rows will have the same selected color.
                if (states.contains(MaterialState.selected))
                  return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                // Even rows will have a grey color.
                if (index % 2 == 0) return inCard ? Color(0xfffafafa) : Color(0xffffffff);
                if (index % 2 == 1) return inCard ? Color(0xffffffff) : Color(0xfffafafa);
                return null; // Use default value for other states and odd rows.
              }
            ),
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
}
