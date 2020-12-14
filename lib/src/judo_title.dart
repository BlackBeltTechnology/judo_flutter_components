part of judo.components;

class JudoTitle extends StatelessWidget {
  JudoTitle({
    Key key,
    this.col,
    this.row,
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
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
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
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: JudoComponentsSettings.secondaryColor,
                fontSize: 24),
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
