part of judo.components;

class JudoInputText extends StatefulWidget {
  JudoInputText({
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
    this.multiline = false,
  }) : super(key: key);

  final int col;
  final double row;
  final String label;
  final Icon icon;
  final Function onChanged;
  final String initialValue;
  final bool readOnly;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool multiline;

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
              child: TextField(
                controller: controller,
                readOnly: widget.disabled ? true : widget.readOnly,
                enabled: widget.disabled ? false : !widget.readOnly,
                expands: widget.multiline,
                minLines: widget.multiline ? null : 1,
                maxLines: widget.multiline ? null : 1,
                decoration: JudoComponentCustomizer.get().getInputTextDecoration(widget.label, widget.icon, null),
                onChanged: widget.onChanged,
              ),
              decoration: JudoComponentCustomizer.get().getInputBoxCustomizer(widget.disabled, widget.readOnly)
             ),
          data: JudoComponentCustomizer.get().getInputTextThemeCustomizer(theme, widget.disabled, widget.readOnly),
        ),
    );
  }
}
