part of judo.components;

class JudoAppBarButton extends StatelessWidget {
  JudoAppBarButton({
    Key key,
    this.padding,
    this.label,
    this.icon,
    this.loadingState,
    this.onPressed,
    this.color,
    this.disabled = false,
    this.outlined = false,
    this.order,
  }) : super(key: key);

  final EdgeInsets padding;
  final String label;
  final LoadingState loadingState;
  final Function onPressed;
  final Icon icon;
  final Color color;
  final bool disabled;
  final bool outlined;
  final double order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: JudoButtonWidget(
        order: order,
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
