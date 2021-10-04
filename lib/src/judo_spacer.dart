part of judo.components;

class JudoSpacer extends StatelessWidget {

  JudoSpacer({
    Key? key,
    required this.col,
    this.row = 1.0,
  }) : super(key: key);

  final double col;
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