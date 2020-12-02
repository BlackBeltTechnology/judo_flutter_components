part of judo.components;

class JudoColumn extends StatefulWidget {
  JudoColumn({
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
  JudoColumnState createState() => JudoColumnState();
}

class JudoColumnState extends State<JudoColumn> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.col,
      child: Container(
        height: widget.row * JudoComponentsSettings.height,
        child: Column(
          mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
          mainAxisSize: widget.mainAxisSize ?? MainAxisSize.min,
          children: widget.children.map((e) => Row(
            children: [
              e
            ],
          )).toList(),
        ),
      ),
    );
  }
}