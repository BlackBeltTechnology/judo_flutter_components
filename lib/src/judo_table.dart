part of judo.components;

abstract class JudoTableDataInfo {
  List<DataColumn> getColumns(Function onAdd);
  Function getRow({Function navigateToEditPageAction, Function navigateToViewPageAction, Function navigateToCreatePageAction, Function removeAction, Function unsetAction, Function deleteAction});
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
    this.disabled = false,
    this.onAdd,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final int col;
  final double row;
  final bool sortAscending;
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
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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


  DataTable dataTable(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DataTable(
        headingTextStyle: theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w400, color: theme.colorScheme.secondary),
        onSelectAll: (b) {},
        sortAscending: sortAscending,
        columns: dataInfo.getColumns(onAdd),
        rows: dataRow(context)
    );
  }

  List<DataRow> dataRow(BuildContext context) {

    List<DataRow> dataRowList = rowList.map<DataRow>(
        dataInfo.getRow(
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
