part of judo.components;

class JudoText extends StatelessWidget {

  JudoText({
    Key? key,
    required this.col,
    this.row = 1.0,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    required this.text,
    this.label,
  }) : super(key: key);

  final double col;
  final double row;
  final EdgeInsets? padding;
  final bool stretch;
  final Alignment alignment;
  final String text;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: col,
      row: row,
      stretch: stretch,
      alignment: alignment,
      child: Row(
        children: [
          label != null && label!.isNotEmpty ? Text(
            label! + ' ',
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
