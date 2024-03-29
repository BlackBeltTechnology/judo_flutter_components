part of judo.components;

class JudoRow extends StatelessWidget {
  JudoRow({
    Key key,
    this.children,
    @required this.col,
    this.row = 1.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.card = false,
    this.frameMargin = const EdgeInsets.all(4.0),
    this.radius = 10.0,
    this.elevation = 4.0,
    this.hidden = false,
  }) : super(key: key);

  final List<Widget> children;
  final double col;
  final double row;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool card;
  final EdgeInsets frameMargin;
  final double radius;
  final double elevation;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    if (hidden) return JudoSpacer(col: col, row: row);

    return Expanded(
      flex: (col * 100).round(),
      child: card ? Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        margin: frameMargin,
        borderOnForeground: false,
        child: Container(
          padding: JudoComponentCustomizer.get().getDefaultPadding(),
          height: row * JudoComponentCustomizer.get().getLineHeight(),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: children,
          ),
        ),
      )
        :
      Container(
        height: row * JudoComponentCustomizer.get().getLineHeight(),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: children,
        ),
      ),
    );
  }
}