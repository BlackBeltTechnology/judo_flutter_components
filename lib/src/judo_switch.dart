part of judo.components;

class JudoSwitch extends StatefulWidget {
  JudoSwitch({
    Key key,
    @required this.col,
    this.row = 1.0,
    this.mandatory = false,
    this.label,
    this.icon,
    this.onChanged,
    this.errorMessage,
    this.initialValue,
    this.readOnly = false,
    this.disabled = false,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.hidden = false,
    this.order,
  }) : super(key: key);

  final double col;
  final double row;
  final bool mandatory;
  final String label;
  final Icon icon;
  final Function onChanged;
  final String errorMessage;
  final bool initialValue;
  final bool readOnly;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool hidden;
  final double order;

  @override
  JudoSwitchState createState() => JudoSwitchState();
}

class JudoSwitchState extends State<JudoSwitch> {

  @override
  Widget build(BuildContext context) {
    if (widget.hidden) return JudoSpacer(col: widget.col, row: widget.row);

    final ThemeData theme = Theme.of(context);
    return JudoContainer(
//      color: widget.disabled ? JudoComponentsSettings.disabledColor : null,
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      order: widget.order,
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: Row(
        children: [
          /*
          Text(
            widget.label + ' '
          ),
          Switch(
//            activeColor: widget.disabled ? JudoComponentsSettings.disabledColor : JudoComponentsSettings.primaryColor,
            value: widget.initialValue ?? false,
            onChanged: widget.disabled || widget.readOnly ? null : widget.onChanged,
          ), */

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Theme(
                data: JudoComponentCustomizer.get().getSwitchThemeData(Theme.of(context), widget.disabled, widget.readOnly, widget.errorMessage),
                child: Checkbox(
              value: widget.initialValue ?? false,
              onChanged: widget.disabled || widget.readOnly ? null : widget.onChanged,
            )),
          ),
          GestureDetector(
            onTap: widget.disabled || widget.readOnly ? null : () {
              widget.onChanged(!(widget.initialValue ?? false));
            },
            child: Text(
              widget.label,
              style: JudoComponentCustomizer.get().getSwitchTextStyle(Theme.of(context), widget.disabled, widget.readOnly, widget.errorMessage),
            )
          ),
        ],
      ),
    );
  }
}
