part of judo.components;

class JudoDivider extends StatelessWidget {

  JudoDivider({
    Key? key,
    required this.col,
    this.row = 1.0,
    this.padding,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final double col;
  final double row;
  final EdgeInsets? padding;
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
        thickness: 1,
      ),
    );
  }

}
