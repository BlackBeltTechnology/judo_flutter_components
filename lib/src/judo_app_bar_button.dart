part of judo.components;

class JudoAppBarButton extends StatelessWidget {
  JudoAppBarButton({
    Key? key,
    required this.padding,
    required this.label,
    required this.icon,
    required this.loadingState,
    required this.onPressed,
    required this.color,
    this.disabled = false,
    this.outlined = false,
  }) : super(key: key);

  final EdgeInsets padding;
  final String label;
  final LoadingState loadingState;
  final FutureFunction onPressed;
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
