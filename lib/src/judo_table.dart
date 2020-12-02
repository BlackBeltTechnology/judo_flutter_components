part of judo.components;

abstract class JudoTableDataInfo {
  List<DataColumn> getColumns(Function onAdd);
  Function getRow({Function navigateToEditPageAction, Function navigateToViewPageAction, Function navigateToCreatePageAction, Function removeAction, Function unsetAction, Function deleteAction});
}

class JudoTable extends StatefulWidget {
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
  final int row;
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
  JudoTableState createState() => JudoTableState();
}

class JudoTableState extends State<JudoTable> {

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      col: widget.col,
      row: widget.row,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: SizedBox(
        height: widget.row * JudoComponentsSettings.height,
        child: SingleChildScrollView(
          child: widget.rowList is ObservableList
              ? Observer(
            builder: (_) => DataTable(
              dataRowColor: widget.disabled ? MaterialStateProperty.resolveWith((_) => JudoComponentsSettings.disabledColor) : null,
              headingRowColor: widget.disabled ? MaterialStateProperty.resolveWith((_) => JudoComponentsSettings.disabledColor) : null,
              headingTextStyle: TextStyle(
                color: Color(JudoComponentsSettings.primaryColor.value),
                fontWeight: FontWeight.bold,
              ),
              onSelectAll: (b) {},
              sortAscending: widget.sortAscending,
              columns: widget.dataInfo.getColumns(widget.onAdd),
              rows: dataRow(),
            ),
          )
              : DataTable(
            dataRowColor: widget.disabled ? MaterialStateProperty.resolveWith((_) => JudoComponentsSettings.disabledColor) : null,
            headingRowColor: widget.disabled ? MaterialStateProperty.resolveWith((_) => JudoComponentsSettings.disabledColor) : null,
            headingTextStyle: TextStyle(
              color: Color(JudoComponentsSettings.primaryColor.value),
              fontWeight: FontWeight.bold,
            ),
            onSelectAll: (b) {},
            sortAscending: widget.sortAscending,
            columns: widget.dataInfo.getColumns(widget.onAdd),
            rows: dataRow(),
          ),
        ),
      )
    );
  }

  List<DataRow> dataRow() {
    List<DataRow> dataRowList = widget.rowList.map<DataRow>(widget.dataInfo.getRow(
        navigateToEditPageAction: widget.disabled ? null : this.widget.navigateToEditPageAction,
        navigateToCreatePageAction: widget.disabled ? null : this.widget.navigateToCreatePageAction,
        navigateToViewPageAction: widget.disabled ? null : this.widget.navigateToViewPageAction,
        deleteAction: widget.disabled ? null : this.widget.deleteAction,
        removeAction: widget.disabled ? null : this.widget.removeAction,
        unsetAction: widget.disabled ? null : this.widget.unsetAction
    )).toList();
    return dataRowList;
  }
}
