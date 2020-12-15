part of judo.components;

class JudoIcon extends StatelessWidget {

  JudoIcon({
    Key key,
    @required this.col,
    this.row = 1.0,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.icon,
  }) : super(key: key);

  final int col;
  final double row;
  final EdgeInsets padding;
  final bool stretch;
  final Alignment alignment;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: col,
      row: row,
      stretch: stretch,
      alignment: alignment,
      child: Row(
        children: [
          icon,
        ],
      ),
    );
  }

}
