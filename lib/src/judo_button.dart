part of judo.components;

class JudoButton extends StatelessWidget {
  JudoButton({
    Key key,
    @required this.col,
    this.row = 1,
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

  final double col;
  final double row;
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
      padding: padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: col,
      row: row,
      stretch: stretch,
      alignment: alignment,
      child: getButton(context),
    );
  }

    Widget getButton(BuildContext context) {
      return label != null && icon != null ?
      RaisedButton.icon(
        icon: icon,
        label: Text(label),
        onPressed: disabled ? null : onPressed,
      ) :

      label != null && icon == null ?
      RaisedButton(
        child: Text(label),
        onPressed: disabled ? null : onPressed,
      ) :

      label == null && icon != null ?
      Container(
          padding: JudoComponentCustomizer.get().getDefaultPadding(),
          decoration: ShapeDecoration(
              color: disabled ? Theme
                  .of(context)
                  .dividerColor : Theme
                  .of(context)
                  .primaryColor,
              shape: CircleBorder()
          ),
          child: IconButton(
            icon: icon,
            onPressed: disabled ? null : onPressed,
            tooltip: label,
            iconSize: 20.0,
            color: Theme
                .of(context)
                .buttonColor,
          )) :

      Container(
          padding: JudoComponentCustomizer.get().getDefaultPadding(),
          decoration: ShapeDecoration(
              color: disabled ? Theme
                  .of(context)
                  .dividerColor : Theme
                  .of(context)
                  .primaryColor,
              shape: CircleBorder()
          ),
          child: IconButton(
            icon: Icon(Icons.add_sharp),
            onPressed: disabled ? null : onPressed,
            iconSize: 20.0,
            color: Theme
                .of(context)
                .primaryColor,
          ));
    }
}
