part of judo.components;

class JudoAppBarPopupButton<T> extends StatelessWidget {
  JudoAppBarPopupButton({
    Key? key,
    this.padding,
    required this.label,
    required this.icon,
    required this.loadingState,
    required this.color,
    this.disabled = false,
    this.items = const {},
    this.outlined = false,
  }) : super(key: key);

  final EdgeInsets? padding;
  final Icon icon;
  final String label;
  final Color color;
  final bool disabled;
  final LoadingState loadingState;
  final Map<T, JudoMenuItemData> items;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
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
