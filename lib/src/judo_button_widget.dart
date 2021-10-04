part of judo.components;

class JudoButtonWidget extends StatelessWidget {
  JudoButtonWidget({
    Key? key,
    this.label,
    this.icon,
    this.loadingState,
    this.onPressed,
    this.color,
    this.disabled = false,
    this.outlined = false,
  }) : super(key: key);

  final String? label;
  final LoadingState? loadingState;
  final FutureFunction? onPressed;
  final Icon? icon;
  final Color? color;
  final bool disabled;
  final bool outlined;

  bool get _disabled => disabled || onPressed == null;

  @override
  Widget build(BuildContext context) {
    return loadingState == null || !loadingState!.isLoading
        ? getButtonWidget(context)
        : getLoadingButtonWidget(context);
  }

  Widget getLoadingButtonWidget(BuildContext context) {
    if (label != null) {
      return ElevatedButton.icon(
        icon: SizedBox(
          height: 20,
          width: 20,
          child: loadingWidget(context),
        ),
        label: Text(label!),
        onPressed: null,
      );
    } else {
      return IconButton(
        onPressed: null,
        iconSize: 20,
        icon: SizedBox(
          child: loadingWidget(context),
        ),
      );
    }
  }

  Widget getButtonWidget(BuildContext context) {
    if (label != null && icon != null) {
      return outlined
          ? OutlinedButton.icon(
              icon: icon!,
              label: Text(label!),
              onPressed: _disabled ? null : _onPressed,
            )
          : ElevatedButton.icon(
              icon: icon!,
              label: Text(label!),
              onPressed: _disabled ? null : _onPressed,
            );
    } else if (label != null) {
      return outlined
          ? OutlinedButton(
              child: Text(label!),
              onPressed: _disabled ? null : _onPressed,
            )
          : ElevatedButton(
              child: Text(label!),
              onPressed: _disabled ? null : _onPressed,
            );
    } else {
      return outlined
          ? IconButton(
              icon: Icon(icon!.icon),
              padding: EdgeInsets.all(0),
              alignment: Alignment.center,
              onPressed: _disabled ? null : _onPressed,
              tooltip: label,
              splashRadius: 20.0,
              color: _disabled
                  ? Theme.of(context).disabledColor
                  : (icon!.color == null
                      ? Theme.of(context).colorScheme.primary
                      : icon!.color),
            )
          : Container(
              decoration: ShapeDecoration(
                  color: _disabled
                      ? Theme.of(context).dividerColor
                      : Theme.of(context).primaryColor,
                  shape: StadiumBorder()),
              child: IconButton(
                icon: Icon(icon!.icon),
                color: Theme.of(context).cardColor,
                alignment: Alignment.center,
                constraints: BoxConstraints(),
                onPressed: _disabled ? null : _onPressed,
                tooltip: label,
                splashRadius: 28,
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
    /// The check for `disabled` handles the case where `onPressed` can be null.
    if (loadingState != null) {
      loadingState!.onPressed(onPressed!);
    } else {
      (() async {
        onPressed!();
      })();
    }
  }
}
