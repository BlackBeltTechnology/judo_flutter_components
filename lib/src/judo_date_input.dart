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
    this.alignment = Alignment.topLeft,
    this.inCard = false,
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
    final ThemeData theme = Theme.of(context);
    return JudoContainer(
      padding: widget.padding ?? JudoComponentCustomizer.get().getDefaultPadding(),
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
    var tempDateTime = widget.initialDate ?? DateTime.now();
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
          onChangedHandler(tempDateTime);
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
