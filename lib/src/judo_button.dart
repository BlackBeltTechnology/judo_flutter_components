part of judo.components;

class JudoButton extends StatefulWidget {
  JudoButton({
    Key key,
    this.col = 4,
    this.padding,
    this.label,
    this.icon,
    this.onPressed,
    this.rounded = true,
    this.color,
    this.disabled = false,
    this.disabledColor = Colors.black26,
    this.textColor = Colors.white,
    this.disabledTextColor = Colors.black26,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final int col;
  final EdgeInsets padding;
  final String label;
  final Function onPressed;
  final Icon icon;
  final bool rounded;
  final Color color;
  final bool disabled;
  final Color disabledColor;
  final Color textColor;
  final Color disabledTextColor;
  final bool stretch;
  final Alignment alignment;

  @override
  JudoButtonState createState() => JudoButtonState();
}

class JudoButtonState extends State<JudoButton> {

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: widget.col,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: widget.icon != null
          ? RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: widget.rounded ? BorderRadius.circular(16.0) : BorderRadius.zero
            ),
            icon: widget.icon,
            label: widget.label != null ? Text(widget.label) : Text(''),
            onPressed: widget.disabled ? null : widget.onPressed,
            color: widget.color ?? JudoComponentsSettings.primaryColor,
            disabledColor: widget.disabledColor,
            textColor: widget.textColor,
            disabledTextColor: widget.disabledTextColor,
          )
          : RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: widget.rounded ? BorderRadius.circular(16.0) : BorderRadius.zero
            ),
            child: widget.label != null ? Text(widget.label) : Text(''),
            onPressed: widget.disabled ? null : widget.onPressed,
            color: widget.color ?? JudoComponentsSettings.primaryColor,
            disabledColor: widget.disabledColor,
            textColor: widget.textColor,
            disabledTextColor: widget.disabledTextColor,
          ),
    );
  }
}
