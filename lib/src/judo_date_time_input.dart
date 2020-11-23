part of judo.components;

class JudoDateTimeInput extends StatelessWidget {
  JudoDateTimeInput({
    this.key,
    this.col,
    this.label,
    this.icon,
    this.onChanged,
    @required this.initialDate,
    this.readOnly = false,
    this.disabled = false,
    this.firstDate,
    this.lastDate,
    this.use24HourFormat,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  });

  final Key key;
  final int col;
  final String label;
  final Icon icon;
  final Function onChanged;
  final DateTime initialDate;
  final bool readOnly;
  final bool disabled;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool use24HourFormat;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      color: disabled ? JudoComponentsSettings.disabledColor : null,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: col,
      stretch: stretch,
      alignment: alignment,
      child: TextFormField(
        key: key,
        readOnly: disabled ? true : readOnly,
        enabled: disabled ? false : !readOnly,
        initialValue: initialDate != null ? formatter.format(initialDate) : null,
        decoration: disabled ?
        InputDecoration(
          labelText: label,
          prefixIcon: icon,
          suffixIcon: iconDatePicker(context),
        )
            : readOnly ?
        InputDecoration(
          labelText: label,
          prefixIcon: icon,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        )
            :
        InputDecoration(
          labelText: label,
          prefixIcon: icon,
          suffixIcon: iconDatePicker(context),
        ),
        onChanged: (value) => onChangedHandler(DateTime.parse(value)),
      ),
    );
  }

  Widget iconDatePicker(BuildContext context) {
    var tempDateTime = this.initialDate ?? DateTime.now();
    var tempTimeOfDay = TimeOfDay.fromDateTime(this.initialDate ?? DateTime.now());
    return IconButton(
        icon: Icon(
          Icons.calendar_today,
          color: disabled ? JudoComponentsSettings.disabledColor : null,
        ),
        onPressed: disabled ? null : () async {
          tempDateTime = await showDatePicker(
            context: context,
            initialDate: tempDateTime,
            firstDate: this.firstDate ?? DateTime(1900),
            lastDate: this.lastDate ?? DateTime(2100),
          );
          tempTimeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(initialDate ?? DateTime.now()),
              initialEntryMode: TimePickerEntryMode.input,
              builder: use24HourFormat ? (BuildContext context, Widget child) {
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
    if (this.onChanged != null) {
      this.onChanged(value);
    }
  }
}
