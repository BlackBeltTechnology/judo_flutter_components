part of judo.components;

class JudoComboBox<T> extends StatefulWidget {

  JudoComboBox({
    Key key,
    @required this.col,
    this.row = 1.0,
    this.mandatory = false,
    this.icon,
    this.label,
    this.items,
    this.onChanged,
    this.value,
    this.dropdownMenuShow,
    this.onTap,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.padding,
    this.disabled = false,
    this.readOnly = false,
  }) : super(key: key);

  final double col;
  final double row;
  final bool mandatory;
  final String label;
  final Icon icon;
  T value;
  final List items;
  final Function onChanged;
  ///  EXAMPLE:
  ///  (T value) {
  ///    return DropdownMenuItem<T>(
  ///      value: value,
  ///      child: Text(value.name),
  ///    );
  ///  }
  final Function dropdownMenuShow;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final Function onTap;
  final bool disabled;
  final bool readOnly;

  @override
  _JudoComboBoxState<T> createState() => _JudoComboBoxState<T>();
}

class _JudoComboBoxState<T> extends State<JudoComboBox<T>> {

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith();
    return JudoContainer(
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: Theme(
        data: JudoComponentCustomizer.get().getInputTextThemeCustomizer(theme, widget.disabled, widget.readOnly),
        child: Container(
          decoration: JudoComponentCustomizer.get().getInputBoxCustomizer(widget.disabled, widget.readOnly),
          child: DropdownButtonFormField<T>(
              decoration: JudoComponentCustomizer.get().getInputTextDecoration(widget.label, widget.icon, null)
                  .copyWith(
                labelText: widget.mandatory ? widget.label + ' *' : widget.label,
              ),
              onTap: widget.onTap,
              value: widget.value,
              icon: Icon(Icons.arrow_drop_down),
              elevation: 16,
              onChanged: widget.onChanged != null && !widget.disabled && !widget.readOnly ?  widget.onChanged :
                ( widget.onChanged == null && !widget.disabled && !widget.readOnly ?
                  (newValue) {
                    setState(() {
                      widget.value = newValue;
                    });
                  } : null
                ),
              items: widget.items.map<DropdownMenuItem<T>>(widget.dropdownMenuShow).toList()),
        ),
      ),
    );
  }
}
