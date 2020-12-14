part of judo.components;

class JudoColumn extends StatelessWidget {
  JudoColumn({
    Key key,
    this.children,
    this.col = 12,
    this.row = 1,
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
          child: Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            mainAxisSize: mainAxisSize ?? MainAxisSize.min,
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
        height: row * JudoComponentsSettings.height,
        child: Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          mainAxisSize: mainAxisSize ?? MainAxisSize.min,
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