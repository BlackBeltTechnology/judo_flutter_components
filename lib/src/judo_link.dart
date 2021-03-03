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
                              Container(
                                child: InkWell(
                                    onTap: !readOnly ? setAction : null,
                                    child: getTextField()
                                ),
                                decoration: JudoComponentCustomizer.get().getInputBoxCustomizer(disabled, readOnly),
                              )
                        ),
                        Container(
                          child:
                          Padding(padding: EdgeInsets.symmetric(vertical: 6), child:
                          Row(
                            children: getActionWidgets(),
                          ),
                          )
                        )
                      ]
                  ),
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
        enabled: false,
        decoration: JudoComponentCustomizer.get().getInputLinkDecoration(label, icon, null)
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
