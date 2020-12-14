part of judo.components;

class JudoSwitch extends StatefulWidget {
  JudoSwitch({
    Key key,
    this.col,
    this.row,
    this.label,
    this.icon,
    this.onChanged,
    this.initialValue,
    this.readOnly = false,
    this.disabled = false,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.multiline = false,
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
  final bool multiline;

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
      child: Switch(
        activeColor: JudoComponentsSettings.primaryColor,
        value: widget.initialValue,
        onChanged: widget.onChanged,
      ),
    );
  }
}
