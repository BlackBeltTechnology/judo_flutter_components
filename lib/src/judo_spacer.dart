part of judo.components;

class JudoSpacer extends StatelessWidget {

  JudoSpacer({
    Key key,
    this.col = 4,
  }) : super(key: key);

  final int col;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      col: col,
      child: SizedBox(),
    );
  }

}