part of judo.components;

class JudoRow extends StatefulWidget {
  JudoRow({
    Key key,
    this.children,
    this.col = 12,
    this.row = 1,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
  }) : super(key: key);

  final List<Widget> children;
  final int col;
  final int row;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  _JudoRowState createState() => _JudoRowState();
}

class _JudoRowState extends State<JudoRow> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.col,
      child: Container(
        height: widget.row * JudoComponentsSettings.height,
        child: Row(
          mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisSize: widget.mainAxisSize ?? MainAxisSize.min,
          children: widget.children,
        ),
      ),
    );
  }
}