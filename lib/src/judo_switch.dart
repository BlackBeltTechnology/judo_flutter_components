part of judo.components;

class JudoSwitch extends StatefulWidget {
  JudoSwitch({
    Key? key,
    required this.col,
    this.row = 1.0,
    this.mandatory = false,
    required this.label,
    required this.onChanged,
    this.errorMessage,
    this.initialValue,
    this.readOnly = false,
    this.disabled = false,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.topLeft,
  }) : super(key: key);

  final double col;
  final double row;
  final bool mandatory;
  final String label;
  final ValueChanged<bool?> onChanged;
  final String? errorMessage;
  final bool? initialValue;
  final bool readOnly;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets? padding;

  @override
  JudoSwitchState createState() => JudoSwitchState();
}

class JudoSwitchState extends State<JudoSwitch> {

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return JudoContainer(
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: Row(
        children: [
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
