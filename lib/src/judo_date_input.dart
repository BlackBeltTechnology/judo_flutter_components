part of judo.components;

class JudoDateInput extends StatefulWidget {
  JudoDateInput({
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
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.inCard = false,
    this.hidden = false,
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
  final bool inCard;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool hidden;
  final double order;

  @override
  _JudoDateInputState createState() => _JudoDateInputState();
}

class _JudoDateInputState extends State<JudoDateInput> {
  final TextEditingController controller = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialDate != null ? formatter.format(widget.initialDate) : null;
  }

  @override
  void didUpdateWidget(JudoDateInput oldWidget) {
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
    if (widget.hidden) return JudoSpacer(col: widget.col, row: widget.row);

    final ThemeData theme = Theme.of(context);
    return JudoContainer(
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
      order: widget.order,
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child:
        Theme(
          child: Container(
              child: TextField(
                  controller: controller,
                  readOnly: widget.readOnly,
                  enabled: !widget.disabled,
                  decoration: JudoComponentCustomizer.get().getInputDateDecoration(theme, widget.label, widget.icon, (widget.disabled || widget.readOnly) ? null : iconDatePicker(context), widget.mandatory, widget.disabled, widget.readOnly, widget.errorMessage),
                  onChanged: (value) => onChangedHandler(value != '' ? DateTime.parse(value) : null),
                  onSubmitted: widget.onSubmitted,
                ),
              decoration: widget.errorMessage != null ? null :  JudoComponentCustomizer.get().getInputBoxCustomizer(theme, widget.disabled, widget.readOnly),
            ),
          data: JudoComponentCustomizer.get().getInputDateThemeCustomizer(theme, widget.disabled, widget.readOnly, widget.inCard, widget.errorMessage),
        )
    );
  }

  IconButton iconDatePicker(BuildContext context) {
    var initial = widget.initialDate;
    return IconButton(
        icon: Icon(
          Icons.calendar_today,
        ),
        onPressed: (widget.disabled || widget.readOnly) ? null : () async {
          var tempDateTime = await showDatePicker(
            context: context,
            initialDate: initial ?? DateTime.now(),
            firstDate: widget.firstDate ?? DateTime(1900),
            lastDate: widget.lastDate ?? DateTime(2100),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
          );
          /// tempDateTime is NULL if dialog is cancelled...
          onChangedHandler(tempDateTime != null ? tempDateTime : initial);
        }
    );

  }

  void onChangedHandler(DateTime value) {
    controller.text = value != null ? formatter.format(value) : '';

    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }
}
