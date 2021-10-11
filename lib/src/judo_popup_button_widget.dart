part of judo.components;

class JudoPopupButtonWidget<T> extends StatelessWidget {
  JudoPopupButtonWidget({
    Key key,
    this.label,
    this.icon,
    this.loadingState,
    this.color,
    this.disabled = false,
    this.items,
    this.outlined = false,
  }) : super(key: key);

  final Icon icon;
  final String label;
  final Color color;
  final bool disabled;
  final LoadingState loadingState;
  final Map<T, JudoMenuItemData> items;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return JudoButtonWidget(
      label: label,
      icon: icon,
      loadingState: loadingState,
      onPressed: (items == null || items.isEmpty)
          ? null
          : () async {
              T selected = await showButtonMenu<T>(context);
              if (selected != null) {
                items[selected].onSelected.call();
              }
            },
      color: color,
      disabled: disabled,
      outlined: outlined,
    );
  }

  Function getItemBuilder(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap = scale <= 1 ? 8 : lerpDouble(8, 4, min(scale - 1, 1));
    return (context) => items.entries.map((e) {
          return PopupMenuItem<T>(value: e.key, child: e.value.getChild(gap), enabled: !e.value.disabled);
        }).toList();
  }

  Future<T> showButtonMenu<T>(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromLTRB(
      button.localToGlobal(button.size.bottomLeft(Offset.zero)).dx,
      button.localToGlobal(button.size.bottomLeft(Offset.zero)).dy,
      button.localToGlobal(button.size.bottomRight(Offset.zero)).dx,
      button.localToGlobal(button.size.bottomRight(Offset.zero)).dy,
    );

    return showMenu<T>(
      context: context,
      items: getItemBuilder(context).call(context),
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),

      /// "The `useRootNavigator` argument is used to determine whether to push the
      /// menu to the [Navigator] furthest from or nearest to the given `context`. It
      /// is `false` by default."
      ///
      /// The flag is set to true here, because when the default value is used,
      /// app bar buttons remain active, e.g. page can be refreshed,
      /// or worse, object can be deleted, while popup menu is open.
      useRootNavigator: true,
    );
  }
}

class JudoMenuItemData<T> {
  JudoMenuItemData({
    this.label,
    this.icon,
    this.onSelected,
    this.value,
    this.disabled = false,
  });

  final Function onSelected;
  final Icon icon;
  final String label;
  final T value;
  final bool disabled;

  Widget getChild(double gap) {
    return icon != null && label != null
        ? Row(children: [icon, SizedBox(width: gap), Text(label)])
        : label != null
            ? Row(children: [Text(label)])
            : icon != null
                ? Row(children: [icon])
                : Row(children: [Text('')]);
  }
}
