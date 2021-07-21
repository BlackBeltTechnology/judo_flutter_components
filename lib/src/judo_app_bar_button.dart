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
  }) : super(key: key);

  final EdgeInsets padding;
  final String label;
  final LoadingState loadingState;
  final Function onPressed;
  final Icon icon;
  final Color color;
  final bool disabled;

  bool get _disabled => disabled || onPressed == null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: buttonState(context),
    );
  }

  Widget buttonState(BuildContext context) {
    if (loadingState == null || !loadingState.isLoading) {
      return getButtonWidget(context);
    } else {
      return getLoadingButtonWidget(context);
    }
  }

  Widget getLoadingButtonWidget(BuildContext context) {
    if (label != null) {
      return ElevatedButton.icon(
        icon: SizedBox(
          height: 20,
          width: 20,
          child: loadingWidget(context),
        ),
        label: Text(label),
        onPressed: null,
      );
    } else {
      return IconButton(
        onPressed: null,
        iconSize: 20,
        color: Theme.of(context).buttonColor,
        icon: SizedBox(
          child: loadingWidget(context),
        ),
      );
    }
  }

  Widget getButtonWidget(BuildContext context) {
    if (label != null && icon != null) {
      return ElevatedButton.icon(
        icon: icon,
        label: Text(label),
        onPressed: _disabled ? null : _onPressed,
      );
    } else if (label != null) {
      return ElevatedButton(
        child: Text(label),
        onPressed: _disabled ? null : _onPressed,
      );
    } else {
      return IconButton(
        icon: icon,
        alignment: Alignment.center,
        onPressed: _disabled ? null : _onPressed,
        splashRadius: 20.0,
      );
    }
  }

  Widget loadingWidget(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      strokeWidth: 4,
    );
  }

  void _onPressed() {
    if (loadingState != null) {
      loadingState.onPressed(onPressed);
    } else {
      onPressed();
    }
  }
}
