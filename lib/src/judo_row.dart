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
    this.frameMargin = const EdgeInsets.all(4.0),
    this.radius = 4.0,
    this.elevation = 4.0,
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

  @override
  Widget build(BuildContext context) {
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
          height: row * JudoComponentCustomizer.get().getLineHeight(),
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
        height: row * JudoComponentCustomizer.get().getLineHeight(),
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