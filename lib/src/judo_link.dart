part of judo.components;

class JudoLink extends StatelessWidget {
  JudoLink({
    Key? key,
    required this.col,
    this.row = 1.0,
    this.mandatory = false,
    this.formatter = defaultFormatter,
    required this.data,
    this.label,
    this.icon,
    this.errorMessage,
    this.setAction,
    this.actions,
    this.disabled = false,
    this.readOnly = false,
    this.padding,
    this.stretch = false,
    this.inCard = false,
    this.alignment = Alignment.topLeft,
  }) : super(key: key);

  final double col;
  final double row;
  final bool mandatory;
  final bool disabled;
  final bool readOnly;
  final Function formatter;
  final String? label;
  final Icon? icon;
  final dynamic data;
  final String? errorMessage;
  final GestureTapCallback? setAction;
  final List<Widget>? actions;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets? padding;
  final bool inCard;

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
                                    onTap: !readOnly && !disabled ? setAction : null,
                                    child: getTextField(context),
                                ),
                                decoration: errorMessage != null && errorMessage!.isNotEmpty ? null : JudoComponentCustomizer.get().getInputBoxCustomizer(disabled, readOnly),
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
            data: JudoComponentCustomizer.get().getInputLinkThemeCustomizer(theme, disabled, readOnly, inCard),
          )
        );
  }

  Widget getTextField(BuildContext context) {
      final TextEditingController controller = TextEditingController(text: data != null ? Function.apply(formatter, [data]) : '');

      return TextField(
        controller: controller,
        readOnly: true,
        enabled: false,
        decoration: JudoComponentCustomizer.get().getInputLinkDecoration(Theme.of(context).copyWith(), label, icon, null, mandatory, errorMessage)
      );
  }

  List<Widget> getActionWidgets() {
    if (actions == null) {
      return [];
    }
    actions!.removeWhere((value) => value == null);
    return actions!;
  }
}
