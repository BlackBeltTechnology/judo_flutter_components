part of judo.components;

class JudoComboBox<T> extends StatefulWidget {

  JudoComboBox({
    Key key,
    @required this.col,
    this.row = 1.0,
    @required this.hintText,
    @required this.items,
    this.onChanged,
    @required this.value,
    @required this.dropdownMenuShow,
    this.onTap,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.padding,
    this.disabled,
    this.readOnly,
  }) : super(key: key);

  final int col;
  final double row;
  final String hintText;
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
    return JudoContainer(
          padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
          col: widget.col,
          row: widget.row,
          stretch: widget.stretch,
          alignment: widget.alignment,
          child: DropdownButton<T>(
              onTap: widget.onTap,
              hint: Text(widget.hintText ?? 'Select'),
              value: widget.value,
              icon: Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: TextStyle(color: JudoComponentsSettings.primaryColor),
              underline: Container(
                height: 2,
                color: JudoComponentsSettings.secondaryColor,
              ),
              onChanged: widget.onChanged != null ? widget.onChanged :
              ((widget.disabled || widget.readOnly) ? null :
                  (newValue) {
                    setState(() {
                      widget.value = newValue;
                    });
                  }
              ),
              items: widget.items.map<DropdownMenuItem<T>>(widget.dropdownMenuShow).toList()),
    );
  }
}
