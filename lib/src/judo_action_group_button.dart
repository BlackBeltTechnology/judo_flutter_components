part of judo.components;

class JudoActionGroupButton extends StatelessWidget {
  JudoActionGroupButton({
    Key key,
    @required this.col,
    this.row = 1,
    this.padding,
    this.label,
    this.icon,
    this.loadingState,
    this.onSelected,
    this.itemBuilder,
    this.color,
    this.disabled = false,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.items,
    this.outlined = false,
  }) : super(key: key);

  final double col;
  final double row;
  final EdgeInsets padding;
  final Icon icon;
  final String label;
  final Color color;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final Function onSelected;
  final Function itemBuilder;
  final LoadingState loadingState;
  final List<JudoMenuItemData> items;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return JudoButton(
      padding: padding,
      col: col,
      row: row,
      stretch: stretch,
      label: label,
      icon: icon,
      loadingState: loadingState,
      onPressed: () async {
        int selected = await showButtonMenu<int>(context);
        if (selected != null) {
          items[selected].onSelected.call();
        }
      },
      color: color,
      disabled: disabled,
      alignment: alignment,
      outlined: outlined,
    );
  }

  Function getItemBuilder(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap = scale <= 1 ? 8 : lerpDouble(8, 4, min(scale - 1, 1));
    return (context) => items.map((e) {
          return PopupMenuItem<int>(
              value: items.indexOf(e), child: e.getChild(gap));
        }).toList();
  }

  Future<int> showButtonMenu<int>(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromLTRB(
      button.localToGlobal(button.size.bottomLeft(Offset.zero)).dx + 10.0,
      button.localToGlobal(button.size.bottomLeft(Offset.zero)).dy - 16.0,
      button.localToGlobal(button.size.bottomRight(Offset.zero)).dx,
      button.localToGlobal(button.size.bottomRight(Offset.zero)).dy,
    );

    return showMenu<int>(
      context: context,
      items: getItemBuilder(context).call(context),
      position: position,
      useRootNavigator: true,
    );
  }
}

class JudoMenuItemData {
  JudoMenuItemData({
    this.label,
    this.icon,
    this.onSelected,
  });

  final Function onSelected;
  final Icon icon;
  final String label;

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
