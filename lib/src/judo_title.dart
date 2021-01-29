part of judo.components;

class JudoTitle extends StatelessWidget {
  JudoTitle({
    Key key,
    @required this.col,
    this.row = 1.0,
    @required this.text,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final String text;
  final int col;
  final double row;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      stretch: stretch,
      alignment: alignment,
      col: col,
      row: row,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style:
                  Theme.of(context).textTheme.headline1
            //TextStyle(
            //    fontWeight: FontWeight.w900,
//                color: JudoComponentsSettings.secondaryColor,
            //    fontSize: 24),
          ),
          SizedBox(
            height: 10,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
