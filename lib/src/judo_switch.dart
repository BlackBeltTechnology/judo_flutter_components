part of judo.components;

class JudoSwitch extends StatefulWidget {
  JudoSwitch({
    Key key,
    @required this.col,
    this.row = 1.0,
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

  final int col;
  final double row;
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
    return JudoContainer(
      color: widget.disabled ? JudoComponentsSettings.disabledColor : null,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: Row(
        children: [
          widget.icon ?? Text(''),
          Text(
            widget.label + ' '
          ),
          Switch(
            activeColor: widget.disabled ? JudoComponentsSettings.disabledColor : JudoComponentsSettings.primaryColor,
            value: widget.initialValue ?? false,
            onChanged: widget.disabled || widget.readOnly ? null : widget.onChanged,
          ),
        ],
      ),
    );
  }
}
