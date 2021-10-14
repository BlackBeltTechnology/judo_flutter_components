part of judo.components;

class JudoDateTimeInput extends StatefulWidget {
  JudoDateTimeInput({
    Key key,
    @required this.col,
    this.row = 1,
    this.mandatory = false,
    this.label,
    this.icon,
    this.onChanged,
    this.onSubmitted,
    this.errorMessage,
    this.initialDate,
    this.readOnly = false,
    this.disabled = false,
    this.firstDate,
    this.lastDate,
    this.use24HourFormat = true,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.topLeft,
    this.inCard = false,
    this.order,
  }) : super(key: key);

  final double col;
  final double row;
  final bool mandatory;
  final String label;
  final Icon icon;
  final Function onChanged;
  final Function onSubmitted;
  final String errorMessage;
  final DateTime initialDate;
  final bool readOnly;
  final bool disabled;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool use24HourFormat;
  final bool stretch;
  final bool inCard;
  final Alignment alignment;
  final EdgeInsets padding;
  final double order;

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
  void didUpdateWidget(JudoDateTimeInput oldWidget) {
    super.didUpdateWidget(oldWidget); // placement of this is SUPER IMPORTANT!
    if (controller.text != widget.initialDate) {
      controller.text = widget.initialDate != null ? formatter.format(widget.initialDate) : null;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return JudoContainer(
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      order: widget.order,
      col: widget.col,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child:
        Theme(
          child:
            Container(
              child: TextField(
                  controller: controller,
                  readOnly: widget.readOnly,
                  enabled: !widget.disabled,
                  decoration: JudoComponentCustomizer.get().getInputDateTimeDecoration(theme, widget.label, widget.icon, (widget.disabled || widget.readOnly) ? null : iconDatePicker(context), widget.mandatory, widget.disabled, widget.readOnly, widget.errorMessage),
                  onChanged: (value) => onChangedHandler(value != '' ? DateTime.parse(value) : null),
                  onSubmitted: widget.onSubmitted,
                ),
              decoration: widget.errorMessage != null ? null : JudoComponentCustomizer.get().getInputBoxCustomizer(theme, widget.disabled, widget.readOnly),
            ),
          data: JudoComponentCustomizer.get().getInputDateTimeThemeCustomizer(theme, widget.disabled, widget.readOnly, widget.inCard, widget.errorMessage),
        )
    );
  }

  IconButton iconDatePicker(BuildContext context) {
    var tempDateTime = widget.initialDate ?? DateTime.now();
    var tempTimeOfDay = TimeOfDay.fromDateTime(widget.initialDate ?? DateTime.now());
    return IconButton(
        icon: Icon(
          Icons.calendar_today,
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
