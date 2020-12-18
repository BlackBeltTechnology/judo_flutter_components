part of judo.components;

class JudoRow extends StatelessWidget {
  JudoRow({
    Key key,
    this.children,
    @required this.col,
    this.row = 1.0,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.card = false,
  }) : super(key: key);

  final List<Widget> children;
  final int col;
  final double row;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool card;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: col,
      child: card ? Card(
        child: Container(
          height: row * JudoComponentsSettings.height,
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            mainAxisSize: mainAxisSize ?? MainAxisSize.min,
            children: children,
          ),
        ),
      )
        :
      Container(
        height: row * JudoComponentsSettings.height,
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisSize: mainAxisSize ?? MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}