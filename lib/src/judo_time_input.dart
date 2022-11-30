part of judo.components;

class JudoTimeInput extends StatefulWidget {
  JudoTimeInput({
    Key key,
    @required this.col,
    this.row = 1.0,
    this.label,
    this.mandatory = false,
    this.shortFormat = false,
    this.icon,
    this.onChanged,
    this.onSubmitted,
    this.onPickerSubmitted,
    this.errorMessage,
    this.initialTime,
    this.readOnly = false,
    this.disabled = false,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.inCard = false,
    this.hidden = false,
    this.order,
  }) : super(key: key);

  final double col;
  final double row;
  final String label;
  final bool mandatory;
  /// if it's true, then it cuts seconds from time (hh:mm instead of hh:mm:ss format)
  final bool shortFormat;
  final Icon icon;
  final Function onChanged;
  final Function onSubmitted;
  final Function onPickerSubmitted;
  final String errorMessage;
  final String initialTime;
  final bool readOnly;
  final bool disabled;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool inCard;
  final bool hidden;
  final double order;

  @override
  _JudoTimeInputState createState() => _JudoTimeInputState();
}

class _JudoTimeInputState extends State<JudoTimeInput> {
  final TextEditingController controller = TextEditingController();
  // regexp for hh:mm:ss input format
  final RegExp _regExp = RegExp(r"(^([01]?[0-9]?|2[0-3])$)|(^([01][0-9]|2[0-3]):[0-5]?[0-9]?$)|(^([01][0-9]|2[0-3]):[0-5][0-9]:[0-5]?[0-9]?$)");
  // regexp for hh:mm input format
  final RegExp _shortFormatRegExp = RegExp(r"(^([01]?[0-9]?|2[0-3])$)|(^([01][0-9]|2[0-3]):[0-5]?[0-9]?$)");
  
  @override
  void initState() {
    super.initState();
    controller.text = widget.initialTime != null ? formatInitialTime(widget.initialTime) : null;
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
      child: Theme(
        child: Container(
          child: TextField(
            controller: controller,
            readOnly: widget.readOnly,
            enabled: !widget.disabled,
            decoration: JudoComponentCustomizer.get().getInputDecoration(
                theme, widget.label, widget.icon,
                (widget.disabled || widget.readOnly) ? null : iconDatePicker(context),
                widget.mandatory, widget.disabled, widget.readOnly, widget.errorMessage,
                hintText: widget.shortFormat ? 'hh:mm' : 'hh:mm:ss',
            ),
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) {
                RegExp correctRegExp = widget.shortFormat ? _shortFormatRegExp : _regExp;
                var correctTextEditingValue = TextEditingValue();
                if(correctRegExp.hasMatch(newValue.text)){
                  correctTextEditingValue = TextEditingValue().copyWith(text: newValue.text, composing: newValue.composing, selection: newValue.selection);
                } else {
                  correctTextEditingValue = TextEditingValue().copyWith(text: oldValue.text, composing: oldValue.composing, selection: oldValue.selection);
                }
                return correctTextEditingValue;
              }),
            ],
          ),
          decoration: widget.errorMessage != null ? null : JudoComponentCustomizer.get().getInputBoxCustomizer(theme, widget.disabled, widget.readOnly),
        ),
        data: JudoComponentCustomizer.get().getInputDateTimeThemeCustomizer(theme, widget.disabled, widget.readOnly, widget.inCard, widget.errorMessage),
      ),
    );
  }

  IconButton iconDatePicker(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.calendar_today,
        ),
        onPressed: (widget.disabled || widget.readOnly) ? null : () async {
          TimeOfDay tempTime = await showTimePicker(
              context: context,
              initialTime: toTimeOfDay(widget.initialTime) ?? TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.input,
              builder: (BuildContext context, Widget child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                  child: child,
                );
              }
          );
          onChangedHandler(tempTime);
          if (widget.onPickerSubmitted != null) {
            widget.onPickerSubmitted(tempTime);
          }
        }
    );
  }

  void onChangedHandler(TimeOfDay value) {
    if (widget.onChanged != null) {
      if (value != null) {
        controller.text = formatTimeOfDay(value);
        widget.onChanged(formatTimeOfDay(value));
      }
    }
  }

  String formatTimeOfDay(TimeOfDay value) {
    String time = '';
    time += value.hour > 9 ? value.hour.toString() : '0' + value.hour.toString();
    time += ':';
    time += value.minute > 9 ? value.minute.toString() : '0' + value.minute.toString();
    if (!widget.shortFormat) {
      time += ':00';
    }
    return time;
  }

  TimeOfDay toTimeOfDay(String time) {
    if (time == null || time.isEmpty) return null;

    List timeParts = time.split(':');
    if (timeParts != null && timeParts.length > 1) {
      int hour = int.tryParse(timeParts[0]);
      int minute = int.tryParse(timeParts[1]);
      if (hour != null && minute != null) {
        return TimeOfDay(hour: hour, minute: minute);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // cuts seconds from the initial time
  String formatInitialTime(String time) {
    if (!widget.shortFormat) return time;

    List timeParts = time.split(':');
    if (timeParts.length > 2) {
      timeParts.removeLast();
    }
    return timeParts.join(':');
  }
}
