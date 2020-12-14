part of judo.components;

abstract class JudoTableDataInfo {
  List<DataColumn> getColumns(Function onAdd);
  Function getRow({Function navigateToEditPageAction, Function navigateToViewPageAction, Function navigateToCreatePageAction, Function removeAction, Function unsetAction, Function deleteAction});
}

class JudoTable extends StatelessWidget {
  JudoTable({
    Key key,
    @required this.col,
    this.row,
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

    return JudoContainer(
      col: col,
      row: row,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
      stretch: stretch,
      alignment: alignment,
      child: SizedBox(
        height: row * JudoComponentsSettings.height,
        child: SingleChildScrollView(
          child: rowList is ObservableList
              ? Observer(
            builder: (_) => DataTable(
              dataRowColor: disabled ? MaterialStateProperty.resolveWith((_) => JudoComponentsSettings.disabledColor) : null,
              headingRowColor: disabled ? MaterialStateProperty.resolveWith((_) => JudoComponentsSettings.disabledColor) : null,
              headingTextStyle: TextStyle(
                color: Color(JudoComponentsSettings.primaryColor.value),
                fontWeight: FontWeight.bold,
              ),
              onSelectAll: (b) {},
              sortAscending: sortAscending,
              columns: dataInfo.getColumns(onAdd),
              rows: dataRow(),
            ),
          )
              : DataTable(
            dataRowColor: disabled ? MaterialStateProperty.resolveWith((_) => JudoComponentsSettings.disabledColor) : null,
            headingRowColor: disabled ? MaterialStateProperty.resolveWith((_) => JudoComponentsSettings.disabledColor) : null,
            headingTextStyle: TextStyle(
              color: Color(JudoComponentsSettings.primaryColor.value),
              fontWeight: FontWeight.bold,
            ),
            onSelectAll: (b) {},
            sortAscending: sortAscending,
            columns: dataInfo.getColumns(onAdd),
            rows: dataRow(),
          ),
        ),
      )
    );
  }

  List<DataRow> dataRow() {
    List<DataRow> dataRowList = rowList.map<DataRow>(dataInfo.getRow(
        navigateToEditPageAction: disabled ? null : this.navigateToEditPageAction,
        navigateToCreatePageAction: disabled ? null : this.navigateToCreatePageAction,
        navigateToViewPageAction: disabled ? null : this.navigateToViewPageAction,
        deleteAction: disabled ? null : this.deleteAction,
        removeAction: disabled ? null : this.removeAction,
        unsetAction: disabled ? null : this.unsetAction
    )).toList();
    return dataRowList;
  }
}
