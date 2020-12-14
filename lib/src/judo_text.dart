part of judo.components;

class JudoText extends StatelessWidget {

  JudoText({
    Key key,
    this.col = 4,
    this.row,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.text,
    this.label,
    this.icon,
  }) : super(key: key);

  final int col;
  final double row;
  final EdgeInsets padding;
  final bool stretch;
  final Alignment alignment;
  final String text;
  final String label;
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
          label != null && label.isNotEmpty ? Text(
            label + ': ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ) : Text(''),
          Text(
            text,
          ),
        ],
      ),
    );
  }

}
