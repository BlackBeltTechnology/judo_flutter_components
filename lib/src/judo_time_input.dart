part of judo.components;

class JudoTimeInput extends StatefulWidget {
  JudoTimeInput({
    Key key,
    @required this.col,
    this.row = 1.0,
    this.label,
    this.icon,
    this.onChanged,
    this.onSubmitted,
    this.initialDate,
    this.readOnly = false,
    this.disabled = false,
    this.use24HourFormat,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.topLeft,
  }) : super(key: key);

  final double col;
  final double row;
  final String label;
  final Icon icon;
  final Function onChanged;
  final Function onSubmitted;
  final TimeOfDay initialDate;
  final bool readOnly;
  final bool disabled;
  final bool use24HourFormat;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

  @override
  _JudoTimeInputState createState() => _JudoTimeInputState();
}

class _JudoTimeInputState extends State<JudoTimeInput> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialDate != null ? widget.initialDate.toString() : null;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
//      color: widget.disabled ? JudoComponentsSettings.disabledColor : null,
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: TextField(
        controller: controller,
        readOnly: widget.disabled || widget.readOnly,
        enabled: !widget.disabled && !widget.readOnly,
        decoration: widget.disabled ?
        InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.icon,
          suffixIcon: iconDatePicker(context),
        )
            : widget.readOnly ?
        InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.icon,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,

        )
            :
        InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.icon,
          suffixIcon: iconDatePicker(context),
        ),
        onChanged: (value) => onChangedHandler(TimeOfDay.fromDateTime(DateTime.parse(value))),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }

  IconButton iconDatePicker(BuildContext context) {
    var tempTime = widget.initialDate ?? DateTime.now();
    return IconButton(
        icon: Icon(
          Icons.calendar_today,
//          color: widget.disabled ? JudoComponentsSettings.disabledColor : null,
        ),
        onPressed: widget.disabled ? null : () async {
          tempTime = await showTimePicker(
              context: context,
              initialTime: tempTime,
              initialEntryMode: TimePickerEntryMode.input,
              builder: widget.use24HourFormat ? (BuildContext context, Widget child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                  child: child,
                );
              }
                  :
              null
          );
          onChangedHandler(tempTime);
        }
    );
  }

  void onChangedHandler(TimeOfDay value) {
    if (widget.onChanged != null) {
      controller.text = value.toString();
      widget.onChanged(value);
    }
  }
}
