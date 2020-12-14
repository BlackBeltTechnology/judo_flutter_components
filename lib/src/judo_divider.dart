part of judo.components;

class JudoDivider extends StatelessWidget {

  JudoDivider({
    Key key,
    this.col = 4,
    this.row,
    this.padding,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final int col;
  final double row;
  final EdgeInsets padding;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: col,
      row: row,
      stretch: true,
      alignment: alignment,
      child: Divider(
        color: Colors.grey,
        thickness: 1,
      ),
    );
  }

}
