part of judo.components;

class JudoDivider extends StatelessWidget {

  JudoDivider({
    Key key,
    this.col = 4,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final int col;
  final EdgeInsets padding;
  final bool stretch;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: col,
      stretch: stretch,
      alignment: alignment,
      child: Divider(
        color: Colors.grey,
        thickness: 1,
      ),
    );
  }

}
