part of judo.components;

class JudoDateTimeInput extends StatefulWidget {
  JudoDateTimeInput({
    Key key,
    @required this.col,
    this.row = 1,
    this.label,
    this.icon,
    this.onChanged,
    this.onSubmitted,
    this.initialDate,
    this.readOnly = false,
    this.disabled = false,
    this.firstDate,
    this.lastDate,
    this.use24HourFormat = true,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final int col;
  final double row;
  final String label;
  final Icon icon;
  final Function onChanged;
  final Function onSubmitted;
  final DateTime initialDate;
  final bool readOnly;
  final bool disabled;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool use24HourFormat;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

  @override
  _JudoDateTimeInputState createState() => _JudoDateTimeInputState();
}

class _JudoDateTimeInputState extends State<JudoDateTimeInput> {
  final TextEditingController controller = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialDate != null ? formatter.format(widget.initialDate) : null;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith();
    return JudoContainer(
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      col: widget.col,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child:
        Theme(
          child:
            Container(
              child:


                TextField(
                  controller: controller,
                  readOnly: widget.disabled ? true : widget.readOnly,
                  enabled: widget.disabled ? false : !widget.readOnly,
                  decoration: JudoComponentCustomizer.get().getInputDateTimeDecoration(widget.label, widget.icon, (widget.disabled || widget.readOnly) ? null : iconDatePicker(context)),
                  onChanged: (value) => onChangedHandler(value != '' ? DateTime.parse(value) : null),
                  onSubmitted: widget.onSubmitted,
                ),
                decoration: JudoComponentCustomizer.get().getInputBoxCustomizer(widget.disabled, widget.readOnly)
            ),
          data: JudoComponentCustomizer.get().getInputDateTimeThemeCustomizer(theme, widget.disabled, widget.readOnly),
        )
    );
  }

  Widget iconDatePicker(BuildContext context) {
    var tempDateTime = widget.initialDate ?? DateTime.now();
    var tempTimeOfDay = TimeOfDay.fromDateTime(widget.initialDate ?? DateTime.now());
    return IconButton(
        icon: Icon(
          Icons.calendar_today,
          // color: widget.disabled ? JudoComponentsSettings.disabledColor : null,
        ),
        onPressed: (widget.disabled || widget.readOnly) ? null : () async {
          tempDateTime = await showDatePicker(
            context: context,
            initialDate: tempDateTime,
            firstDate: widget.firstDate ?? DateTime(1900),
            lastDate: widget.lastDate ?? DateTime(2100),
          );
          tempTimeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(widget.initialDate ?? DateTime.now()),
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

          onChangedHandler(DateTime(tempDateTime.year, tempDateTime.month, tempDateTime.day, tempTimeOfDay.hour, tempTimeOfDay.minute));
        }
    );

  }

  void onChangedHandler(DateTime value) {
    if (widget.onChanged != null) {
      if (value != null) {
        controller.text = formatter.format(value);
      }
      widget.onChanged(value);
    }
  }
}
