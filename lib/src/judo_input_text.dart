part of judo.components;

class JudoInputText extends StatelessWidget {
  JudoInputText({
    this.key,
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
  });

  final Key key;
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
  Widget build(BuildContext context) {
    return JudoContainer(
      color: disabled ? JudoComponentsSettings.disabledColor : null,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: col,
      stretch: stretch,
      alignment: alignment,
      child: TextFormField(
        key: key,
        readOnly: disabled ? true : readOnly,
        enabled: disabled ? false : !readOnly,
        initialValue: initialValue,
        decoration: disabled ?
        InputDecoration(
          labelText: label,
          prefixIcon: icon,
        )
            : readOnly ?
        InputDecoration(
            labelText: label,
            prefixIcon: icon,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none)
            :
        InputDecoration(
            labelText: label,
            prefixIcon: icon),
        onChanged: onChanged,
      ),
    );
  }
}
