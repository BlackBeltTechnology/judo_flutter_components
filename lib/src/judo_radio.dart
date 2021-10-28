part of judo.components;

class JudoRadio<T> extends StatefulWidget {
  JudoRadio({
    Key key,
    @required this.col,
    this.row = 1.0,
    @required this.items,
    this.onChanged,
    this.errorMessage,
    this.groupValue,
    @required this.getLabel,
    this.getValue,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.topLeft,
    this.disabled = false,
    this.readOnly = false,
    this.hidden = false,
    this.order,
  }) : super(key: key);

  final double col;
  final double row;
  T groupValue;
  T value;
  final List items;
  final Function onChanged;
  final String errorMessage;
  final Function getLabel;
  final Function getValue;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool disabled;
  final bool readOnly;
  final bool hidden;
  final double order;

  @override
  _JudoRadioState<T> createState() => _JudoRadioState<T>();
}

class _JudoRadioState<T> extends State<JudoRadio> {

  @override
  Widget build(BuildContext context) {
    if (widget.hidden) return JudoSpacer(col: widget.col, row: widget.row);

    return JudoContainer(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
      order: widget.order,
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items
              .map<JudoRadioButton<T>>((e) => JudoRadioButton<T>(
                    disabled: widget.disabled,
                    readOnly: widget.readOnly,
                    label: widget.getLabel(e),
                    col: ((widget.col / widget.items.length) * 100).round(),
                    onChanged: widget.onChanged != null &&
                            !widget.disabled &&
                            !widget.readOnly
                        ? widget.onChanged
                        : (widget.onChanged == null &&
                                !widget.disabled &&
                                !widget.readOnly
                            ? (newValue) {
                                setState(() {
                                  widget.groupValue = newValue;
                                });
                              }
                            : null),
                    errorMessage: widget.errorMessage,
                    value: widget.getValue(e),
                    groupValue: widget.groupValue,
                  ))
              .toList()),
    );
  }
}

class JudoRadioButton<T> extends StatelessWidget {
  JudoRadioButton({
    this.label,
    this.value,
    this.groupValue,
    this.onChanged,
    this.errorMessage,
    this.col,
    this.disabled = false,
    this.readOnly = false,
  });

  final String label;
  final T value;
  final T groupValue;
  final Function onChanged;
  final String errorMessage;
  final int col;
  final bool disabled;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: col,
      fit: FlexFit.loose,
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Theme(
                  data: JudoComponentCustomizer.get().getRadioThemeData(Theme.of(context), disabled, readOnly, value == groupValue, errorMessage),
                  child: Radio(
                    value: value,
                    groupValue: groupValue,
                    onChanged: onChanged,
                )),
              ),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: JudoComponentCustomizer.get().getRadioTextStyle(Theme.of(context), disabled, readOnly, errorMessage),
          ),
        ],
      ),
    );
  }
}
