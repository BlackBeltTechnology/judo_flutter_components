part of judo.components;

class JudoButton extends StatelessWidget {

  JudoButton({
    Key? key,
    required this.col,
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
  }) : super(key: key);

  final double col;
  final double row;
  final EdgeInsets? padding;
  final String? label;
  final LoadingState? loadingState;
  final FutureFunction? onPressed;
  final Icon? icon;
  final Color? color;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
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
