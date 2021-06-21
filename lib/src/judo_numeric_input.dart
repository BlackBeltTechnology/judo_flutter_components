part of judo.components;

class JudoNumericInput extends StatefulWidget {

  JudoNumericInput({
    Key key,
    @required this.col,
    this.row = 1.0,
    this.mandatory = false,
    this.label,
    this.icon,
    this.onChanged,
    this.onSubmitted,
    this.errorMessage,
    this.initialValue,
    this.readOnly = false,
    this.disabled = false,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.topLeft,
    this.inCard = false,
  }) : super(key: key);

  final double col;
  final double row;
  final bool mandatory;
  final String label;
  final Icon icon;
  final Function onChanged;
  final Function onSubmitted;
  final String errorMessage;
  final String initialValue;
  final bool readOnly;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool inCard;

  @override
  _JudoNumericInputState createState() => _JudoNumericInputState();
}

class _JudoNumericInputState extends State<JudoNumericInput> {
  RegExp _regExp = RegExp(r"^[+|\-]{0,1}\d*\.{0,1}\d*$");
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialValue;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith();
    return JudoContainer(
      // color: widget.disabled ? JudoComponentsSettings.disabledColor : null,
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: Theme(
        data: JudoComponentCustomizer.get().getInputTextThemeCustomizer(theme, widget.disabled, widget.readOnly, widget.inCard),
        child: Container(
          decoration: widget.errorMessage != null ? null : JudoComponentCustomizer.get().getInputBoxCustomizer(widget.disabled, widget.readOnly),
          child: TextField(
            controller: controller,
            readOnly: widget.disabled ? true : widget.readOnly,
            enabled: widget.disabled ? false : !widget.readOnly,
            keyboardType: TextInputType.number,
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) {
                var correctTextEditingValue = TextEditingValue();
                if(_regExp.hasMatch(newValue.text)){
                  correctTextEditingValue = TextEditingValue().copyWith(text: newValue.text, composing: newValue.composing, selection: newValue.selection);
                } else {
                  correctTextEditingValue = TextEditingValue().copyWith(text: oldValue.text, composing: oldValue.composing, selection: oldValue.selection);
                }
                return correctTextEditingValue;
              }),
            ],
            decoration: JudoComponentCustomizer.get().getInputNumericDecoration(theme, widget.label, widget.icon, null, widget.mandatory, widget.errorMessage),
            onChanged: (value) {
                return widget.onChanged(value);
            },
            onSubmitted: widget.onSubmitted,
          ),
        ),
      ),
    );
  }
}
