part of judo.components;

/// We need a custom API, so that we can detach the initialValue definition due
/// to a bug mentioned below.
class JudoNumericInputMaskSpec {
  final String mask;
  final Map<String, RegExp> filter;

  const JudoNumericInputMaskSpec(this.mask, this.filter);
}

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
    this.alignment = Alignment.topLeft,
    this.inCard = false,
    this.inputMask,
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
  final JudoNumericInputMaskSpec inputMask;

  @override
  _JudoNumericInputState createState() => _JudoNumericInputState();
}

class _JudoNumericInputState extends State<JudoNumericInput> {
  RegExp _regExp = RegExp(r"^[+|\-]{0,1}\d*\.{0,1}\d*$");
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  MaskTextInputFormatter _maskFormatter;
  bool _focused = false;

  @override
  void initState() {
    super.initState();

    if (widget.inputMask != null) {
      /// lib is bugged, we need to set constructor init value AND controller text BOTH
      /// for the initial value to show AND if we type later it not to clear out the
      /// whole value.......
      _maskFormatter = MaskTextInputFormatter(
        mask: widget.inputMask.mask,
        filter: widget.inputMask.filter,
        initialText: widget.initialValue,
      );
      controller.text = _maskFormatter.maskText(widget.initialValue);
    } else {
      controller.text = widget.initialValue;
    }

    if (widget.onFocus != null || widget.onBlur != null) {
      focusNode.addListener(_focusHandler);
    }
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
    if (controller.text != widget.initialValue) {
      controller.text = _maskFormatter != null ? _maskFormatter.maskText(widget.initialValue) : widget.initialValue;
    }
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
            inputFormatters: [ _maskFormatter != null ? _maskFormatter :
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
                return widget.onChanged(_maskFormatter != null ? _maskFormatter.getUnmaskedText() : value);
            },
            onSubmitted: widget.onSubmitted,
            focusNode: focusNode,
          ),
        ),
      ),
    );
  }
}
