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

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: col,
      row: row,
      stretch: stretch,
      alignment: alignment,
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
        onPressed: disabled ? null : _onPressed,
      );
    } else if (label != null) {
      return ElevatedButton(
        child: Text(label),
        onPressed: disabled ? null : _onPressed,
      );
    } else {
      return Container(
          padding: JudoComponentCustomizer.get().getDefaultPadding(),
          decoration: ShapeDecoration(
              color: disabled
                  ? Theme.of(context).dividerColor
                  : Theme.of(context).primaryColor,
              shape: CircleBorder()),
          child: IconButton(
            icon: icon,
            onPressed: disabled ? null : _onPressed,
            tooltip: label,
            iconSize: 20.0,
            color: Theme.of(context).buttonColor,
          ));
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
