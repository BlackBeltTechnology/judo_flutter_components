part of judo.components;

class JudoPopupButton<T> extends StatelessWidget {
  JudoPopupButton({
    Key? key,
    required this.col,
    this.row = 1,
    this.padding,
    this.label,
    this.icon,
    this.loadingState,
    this.color,
    this.disabled = false,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.items,
    this.outlined = false,
  }) : super(key: key);

  final double col;
  final double row;
  final EdgeInsets? padding;
  final Icon? icon;
  final String? label;
  final Color? color;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final LoadingState? loadingState;
  final Map<T, JudoMenuItemData>? items;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: col,
      row: row,
      stretch: stretch,
      alignment: alignment,
      child: JudoPopupButtonWidget(
        label: label,
        loadingState: loadingState,
        icon: icon,
        color: color,
        disabled: disabled,
        outlined: outlined,
        items: items,
      ),
    );
  }
}
