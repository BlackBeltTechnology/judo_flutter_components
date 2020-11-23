part of judo.components;

class JudoLabel extends StatelessWidget {

  JudoLabel({
    this.col = 4,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.text,
    this.trailingIcon,
    this.leadingIcon,
  });

  final int col;
  final EdgeInsets padding;
  final bool stretch;
  final Alignment alignment;
  final String text;
  final Icon trailingIcon;
  final Icon leadingIcon;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: col,
      stretch: stretch,
      alignment: alignment,
      child: Row(
        children: [
          leadingIcon ?? Text(''),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          trailingIcon ?? Text(''),
        ],
      ),
    );
  }

}
