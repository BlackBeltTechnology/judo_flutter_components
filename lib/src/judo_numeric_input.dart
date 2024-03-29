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
    this.onFocus,
    this.onBlur,
    this.onSubmitted,
    this.errorMessage,
    this.initialValue,
    this.readOnly = false,
    this.disabled = false,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.inCard = false,
    this.hidden = false,
    this.order,
    this.precision = 10,
    this.scale = 0,
  }) : super(key: key);

  final double col;
  final double row;
  final bool mandatory;
  final String label;
  final Icon icon;
  final Function onChanged;
  final Function onFocus;
  final Function onBlur;
  final Function onSubmitted;
  final String errorMessage;
  final String initialValue;
  final bool readOnly;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool inCard;
  final bool hidden;
  final double order;
  final int precision;
  final int scale;

  @override
  _JudoNumericInputState createState() => _JudoNumericInputState();
}

class _JudoNumericInputState extends State<JudoNumericInput> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialValue;

    if (widget.onFocus != null || widget.onBlur != null) {
      focusNode.addListener(_focusHandler);
    }
  }

  RegExp getRegExp() {
    String pattern = '(?=(\\D*\\d\\D*){0,' + (widget.precision?.toString() ?? '0') + '}\$)^-?[0-9]+(\\.[0-9]{0,' + (widget.scale?.toString() ?? '0') + '})?\$';
    return RegExp(pattern);
  }

  void _focusHandler() {
    // According to docs, focus is lost on node every time a build happens, so we
    // store it locally, and only trigger handlers where there is an actual change
    if (focusNode.hasFocus != _focused) {
      this.setState(() {
        _focused = focusNode.hasFocus;
      });
      if (_focused && widget.onFocus != null) {
        widget.onFocus();
      } else if (!_focused && widget.onBlur != null) {
        widget.onBlur();
      }
    }
  }

  @override
  void didUpdateWidget(JudoNumericInput oldWidget) {
    super.didUpdateWidget(oldWidget); // placement of this is SUPER IMPORTANT!
    if ((controller.text == null || controller.text.isEmpty) && controller.text != widget.initialValue) {
      controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hidden) return JudoSpacer(col: widget.col, row: widget.row);

    final ThemeData theme = Theme.of(context);
    return JudoContainer(
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      order: widget.order,
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: Theme(
        data: JudoComponentCustomizer.get().getInputTextThemeCustomizer(theme, widget.disabled, widget.readOnly, widget.inCard, widget.errorMessage),
        child: Container(
          decoration: widget.errorMessage != null ? null : JudoComponentCustomizer.get().getInputBoxCustomizer(theme, widget.disabled, widget.readOnly),
          child: TextField(
            controller: controller,
            readOnly: widget.readOnly,
            enabled: !widget.disabled,
            keyboardType: TextInputType.number,
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) {
                var correctTextEditingValue = TextEditingValue();
                if (newValue.text.isEmpty || newValue.text == '-' || getRegExp().hasMatch(newValue.text)) {
                  correctTextEditingValue = TextEditingValue().copyWith(text: newValue.text, composing: newValue.composing, selection: newValue.selection);
                } else {
                  correctTextEditingValue = TextEditingValue().copyWith(text: oldValue.text, composing: oldValue.composing, selection: oldValue.selection);
                }
                return correctTextEditingValue;
              }),
            ],
            decoration: JudoComponentCustomizer.get().getInputNumericDecoration(theme, widget.label, widget.icon, null, widget.mandatory, widget.disabled, widget.readOnly, widget.errorMessage),
            onChanged: (value) {
              return widget.onChanged(value);
            },
            onSubmitted: widget.onSubmitted,
            focusNode: focusNode,
          ),
        ),
      ),
    );
  }
}
