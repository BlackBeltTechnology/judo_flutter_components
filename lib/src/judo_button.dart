part of judo.components;

class JudoButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: col,
      stretch: stretch,
      alignment: alignment,
      child: icon != null
          ? RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: rounded ? BorderRadius.circular(16.0) : BorderRadius.zero
            ),
            icon: icon,
            label: label != null ? Text(label) : Text(''),
            onPressed: disabled ? null : onPressed,
            color: color ?? JudoComponentsSettings.primaryColor,
            disabledColor: disabledColor,
            textColor: textColor,
            disabledTextColor: disabledTextColor,
          )
          : RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: rounded ? BorderRadius.circular(16.0) : BorderRadius.zero
            ),
            child: label != null ? Text(label) : Text(''),
            onPressed: disabled ? null : onPressed,
            color: color ?? JudoComponentsSettings.primaryColor,
            disabledColor: disabledColor,
            textColor: textColor,
            disabledTextColor: disabledTextColor,
          ),
    );
  }
}
