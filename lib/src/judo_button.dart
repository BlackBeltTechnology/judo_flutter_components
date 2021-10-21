part of judo.components;

class JudoButton extends StatelessWidget {

  JudoButton({
    Key key,
    @required this.col,
    this.row = 1,
    this.padding,
    this.label,
    this.icon,
    this.loadingState,
    this.onPressed,
    this.color,
    this.disabled = false,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.outlined = false,
    this.hidden = false,
  }) : super(key: key);

  final double col;
  final double row;
  final EdgeInsets padding;
  final String label;
  final LoadingState loadingState;
  final Function onPressed;
  final Icon icon;
  final Color color;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final bool outlined;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    if (hidden) return JudoSpacer(col: col, row: row);

    return JudoContainer(
      padding: padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: col,
      row: row,
      stretch: stretch,
      alignment: alignment,
      child: JudoButtonWidget(
        label: label,
        loadingState: loadingState,
        onPressed: onPressed,
        icon: icon,
        color: color,
        disabled: disabled,
        outlined: outlined,
      ),
    );
  }

}
