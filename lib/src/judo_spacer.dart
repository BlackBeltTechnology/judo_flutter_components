part of judo.components;

class JudoSpacer extends StatelessWidget {

  JudoSpacer({
    Key key,
    this.col = 4,
    this.row,
  }) : super(key: key);

  final int col;
  final double row;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      col: col,
      row: row,
      child: SizedBox(),
    );
  }

}