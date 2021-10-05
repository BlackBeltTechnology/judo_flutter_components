part of judo.components;

class JudoTitle extends StatelessWidget {
  JudoTitle({
    Key? key,
    required this.col,
    this.row = 1.0,
    required this.text,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final String text;
  final double col;
  final double row;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      stretch: stretch,
      alignment: alignment,
      col: col,
      row: row,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: JudoComponentCustomizer.get().getTitleTextStyle(Theme.of(context))
          ),
          SizedBox(
            height: 10,
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
