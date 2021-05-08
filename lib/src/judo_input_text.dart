part of judo.components;

class JudoInputText extends StatefulWidget {
  JudoInputText({
    Key key,
    @required this.col,
    this.row = 1.0,
    this.mandatory = false,
    this.label,
    this.icon,
    this.onChanged,
    this.onSubmitted,
    this.initialValue,
    this.readOnly = false,
    this.disabled = false,
    this.inCard = false,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.multiline = false,
    this.maxLength = 250,
  }) : super(key: key);

  final double col;
  final double row;
  final bool mandatory;
  final String label;
  final Icon icon;
  final Function onChanged;
  final Function onSubmitted;
  final String initialValue;
  final bool readOnly;
  final bool disabled;
  final bool inCard;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool multiline;
  final int maxLength;

  @override
  JudoInputTextState createState() => JudoInputTextState();
}

class JudoInputTextState extends State<JudoInputText> {
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
      child:
      Theme(
        child:
        Container(
            margin: widget.multiline ? EdgeInsets.symmetric(vertical: 10.0) : null,
            child: TextField(
              controller: controller,
              readOnly: widget.disabled ? true : widget.readOnly,
              enabled: widget.disabled ? false : !widget.readOnly,
              expands: widget.multiline,
              minLines: widget.multiline ? null : 1,
              maxLines: widget.multiline ? null : 1,
              maxLength: widget.maxLength ?? 250,
              inputFormatters: [
                _Utf8LengthLimitingTextInputFormatter(widget.maxLength ?? 250),
              ],
              decoration: JudoComponentCustomizer.get().getInputTextDecoration(widget.label, widget.icon, null, widget.mandatory, widget.multiline),
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
            ),
            decoration: JudoComponentCustomizer.get().getInputBoxCustomizer(widget.disabled, widget.readOnly)
        ),
        data: JudoComponentCustomizer.get().getInputTextThemeCustomizer(theme, widget.disabled, widget.readOnly, widget.inCard),
      ),
    );
  }
}

class _Utf8LengthLimitingTextInputFormatter extends TextInputFormatter {
  _Utf8LengthLimitingTextInputFormatter(this.maxLength)
      : assert(maxLength == null || maxLength == -1 || maxLength > 0);

  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (maxLength != null &&
        maxLength > 0 &&
        bytesLength(newValue.text) > maxLength) {
      // If already at the maximum and tried to enter even more, keep the old value.
      if (bytesLength(oldValue.text) == maxLength) {
        return oldValue;
      }
      return truncate(newValue, maxLength);
    }
    return newValue;
  }

  static TextEditingValue truncate(TextEditingValue value, int maxLength) {
    var newValue = '';
    if (bytesLength(value.text) > maxLength) {
      var length = 0;

      value.text.characters.takeWhile((char) {
        var nbBytes = bytesLength(char);
        if (length + nbBytes <= maxLength) {
          newValue += char;
          length += nbBytes;
          return true;
        }
        return false;
      });
    }
    return TextEditingValue(
      text: newValue,
      selection: value.selection.copyWith(
        baseOffset: min(value.selection.start, newValue.length),
        extentOffset: min(value.selection.end, newValue.length),
      ),
      composing: TextRange.empty,
    );
  }

  static int bytesLength(String value) {
    return utf8.encode(value).length;
  }
}
