part of judo.components;

class JudoLabel extends StatelessWidget {
  JudoLabel({
    Key key,
    @required this.col,
    this.row = 1.0,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.label,
    this.icon,
    this.labelMargin = 4.0,
    this.iconMargin = 4.0,
  }) : super(key: key);

  final double col;
  final double row;
  final EdgeInsets padding;
  final bool stretch;
  final Alignment alignment;
  final String label;
  final Icon icon;
  final double iconMargin;
  final double labelMargin;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: col,
      row: row,
      stretch: stretch,
      alignment: alignment,
      child: Row(
        children: (icon != null && label != null)
            ? [
                Container(
                  child: icon,
                  margin: EdgeInsets.only(right: iconMargin), //parameter
                ),
                Container(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  margin: EdgeInsets.only(left: labelMargin),
                )
              ]
            : label != null
                ? [
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ]
                : [
                    icon,
                  ],
      ),
    );
  }
}
