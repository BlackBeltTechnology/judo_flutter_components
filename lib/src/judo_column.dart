part of judo.components;

class JudoColumn extends StatelessWidget {
  JudoColumn({
    Key key,
    this.children,
    @required this.col,
    this.row = 1.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
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
      flex: (col*100).round(),
      child: card ? Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        margin: frameMargin,
        child: Container(
          padding: JudoComponentCustomizer.get().getDefaultPadding(),
          height: row * JudoComponentCustomizer.get().getLineHeight(),
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: children.map((e) => Row(
              children: [
                e
              ],
            )).toList(),
          ),
        ),
      )
        :
      Container(
        height: row * JudoComponentCustomizer.get().getLineHeight(),
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: children.map((e) => Row(
            children: [
              e
            ],
          )).toList(),
        ),
      ),
    );
  }
}