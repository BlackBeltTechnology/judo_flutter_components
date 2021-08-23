part of judo.components;

class JudoAppBarButton extends StatelessWidget {
  JudoAppBarButton({
    this.padding,
    this.label,
    this.icon,
    this.loadingState,
    this.onPressed,
    this.color,
    this.disabled = false,
    this.outlined = false,
  });

  final EdgeInsets padding;
  final String label;
  final LoadingState loadingState;
  final Function onPressed;
  final Icon icon;
  final Color color;
  final bool disabled;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
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
