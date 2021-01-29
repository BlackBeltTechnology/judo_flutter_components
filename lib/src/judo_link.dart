part of judo.components;

class JudoLink extends StatelessWidget {
  JudoLink({
    Key key,
    @required this.col,
    this.row = 1.0,
    this.formatter = defaultFormatter,
    @required this.data,
    this.label,
    this.icon,
    this.setAction,
    this.actions,
    this.disabled = false,
    this.readOnly = false,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final int col;
  final double row;
  final bool disabled;
  final bool readOnly;
  final Function formatter;
  final String label;
  final Icon icon;
  final dynamic data;
  final Function setAction;
  final List<Widget> actions;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

  static String defaultFormatter(dynamic e) {
    return e != null ? e.toString() : '';
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith();

    return JudoContainer(
        // color: disabled ? JudoComponentsSettings.disabledColor : null,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
        col: col,
        row: row,
        stretch: stretch,
        alignment: alignment,
        child:
          Theme(
            child:
                Container(
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child:
                          InkWell(
                              onTap: !readOnly ? setAction : null,
                              child: getTextField()
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child:
                          Padding(padding: EdgeInsets.symmetric(vertical: 6), child:
                          Row(
                            children: getActionWidgets(),
                          ),
                          )
                        )
                      ]
                  ),
                  decoration: JudoComponentCustomizer.get().getInputBoxCustomizer(disabled, readOnly),
                ),
            data: JudoComponentCustomizer.get().getInputLinkThemeCustomizer(theme, disabled, readOnly),
          )
        );
  }

  Widget getTextField() {
      final TextEditingController controller = TextEditingController(text: data != null ? Function.apply(formatter, [data]) : '');

      return TextField(
        controller: controller,
        readOnly: true,
        /*
          decoration: readOnly ?
        InputDecoration(
          enabled: false,
          labelText: label,
          prefixIcon: icon,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          //suffixIcon: iconDatePicker(context),
        ) :
        InputDecoration(
          enabled: false,
          labelText: label,
          prefixIcon: icon,
          //suffixIcon: iconDatePicker(context),
        ), */
        decoration: JudoComponentCustomizer.get().getInputLinkDecoration(label, icon, null),

    //onChanged: (value) => onChangedHandler(value != '' ? DateTime.parse(value) : null),
      );
  }

  List<Widget> getActionWidgets() {
    List ret = actions;
    if (ret == null) {
      return [];
    }
    ret.removeWhere((value) => value == null);
    return ret;
  }
}
