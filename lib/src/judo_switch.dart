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
    this.initialValue,
    this.readOnly = false,
    this.disabled = false,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final double col;
  final double row;
  final bool mandatory;
  final String label;
  final Icon icon;
  final Function onChanged;
  final bool initialValue;
  final bool readOnly;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

  @override
  JudoSwitchState createState() => JudoSwitchState();
}

class JudoSwitchState extends State<JudoSwitch> {

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith();
    return JudoContainer(
//      color: widget.disabled ? JudoComponentsSettings.disabledColor : null,
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
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
            child: Checkbox(
              value: widget.initialValue ?? false,
              onChanged: widget.disabled || widget.readOnly ? null : widget.onChanged,
            ),
          ),
          Text(
              widget.mandatory ? widget.label + ' *' : widget.label,
              style: theme.textTheme.subtitle1,
          ),

        ],
      ),
    );
  }
}
