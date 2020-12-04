part of judo.components;

class JudoInputText extends StatefulWidget {
  JudoInputText({
    Key key,
    this.col,
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
  final String label;
  final Icon icon;
  final Function onChanged;
  final String initialValue;
  final bool readOnly;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

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
    return JudoContainer(
      color: widget.disabled ? JudoComponentsSettings.disabledColor : null,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: widget.col,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: TextField(
        controller: controller,
        readOnly: widget.disabled ? true : widget.readOnly,
        enabled: widget.disabled ? false : !widget.readOnly,
        decoration: widget.disabled ?
        InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.icon,
        )
            : widget.readOnly ?
        InputDecoration(
            labelText: widget.label,
            prefixIcon: widget.icon,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none)
            :
        InputDecoration(
            labelText: widget.label,
            prefixIcon: widget.icon),
        onChanged: widget.onChanged,
      ),
    );
  }
}
