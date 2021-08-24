part of judo.components;

class JudoAppBarPopupButton<T> extends StatelessWidget {
  JudoAppBarPopupButton({
    Key key,
    this.padding,
    this.label,
    this.icon,
    this.loadingState,
    this.color,
    this.disabled = false,
    this.items,
    this.outlined = false,
  }) : super(key: key);

  final EdgeInsets padding;
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
      padding: padding,
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
