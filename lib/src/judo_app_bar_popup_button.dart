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
    this.order,
  }) : super(key: key);

  final EdgeInsets padding;
  final Icon icon;
  final String label;
  final Color color;
  final bool disabled;
  final LoadingState loadingState;
  final Map<T, JudoMenuItemData> items;
  final bool outlined;
  final double order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding == null ? EdgeInsets.all(0) : padding,
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
