part of judo.components;

class JudoRadio<T> extends StatefulWidget {
  JudoRadio({
    Key key,
    @required this.col,
    this.row = 1.0,
    @required this.items,
    this.onChanged,
    this.groupValue,
    @required this.getLabel,
    this.getValue,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.disabled = false,
    this.readOnly = false,
  }) : super(key: key);

  final int col;
  final double row;
  T groupValue;
  T value;
  final List items;
  final Function onChanged;
  final Function getLabel;
  final Function getValue;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool disabled;
  final bool readOnly;

  @override
  _JudoRadioState<T> createState() => _JudoRadioState<T>();
}

class _JudoRadioState<T> extends State<JudoRadio> {

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items.map<JudoRadioButton<T>>((e) => JudoRadioButton<T>(
            label: widget.getLabel(e),
            col: (widget.col / widget.items.length).round(),
            onChanged: widget.onChanged != null && !widget.disabled && !widget.readOnly ?  widget.onChanged :
              ( widget.onChanged == null && !widget.disabled && !widget.readOnly ?
                  (newValue) {
                    setState(() {
                      widget.groupValue = newValue;
                    });
                  } : null
              ),
            value: widget.getValue(e),
            groupValue: widget.groupValue,
          )).toList()),
    );
  }
}

class JudoRadioButton<T> extends StatelessWidget {
  JudoRadioButton({
    this.label,
    this.value,
    this.groupValue,
    this.onChanged,
    this.col,
  });

  final String label;
  final T value;
  final T groupValue;
  final Function onChanged;
  final int col;

  @override
  Widget build(BuildContext context) {

    return Flexible(
      flex: col,
      fit: FlexFit.loose,
      child: Row(
        children: [
          Radio(
//            activeColor: JudoComponentsSettings.primaryColor,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
