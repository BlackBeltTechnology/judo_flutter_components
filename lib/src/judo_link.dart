part of judo.components;

class JudoLink extends StatefulWidget {
  JudoLink({
    Key key,
    @required this.col,
    this.row = 1.0,
    this.mandatory = false,
    this.labelList = const [],
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
    this.alignment = Alignment.centerLeft,
    this.hidden = false,
  	this.order,
  }) : super(key: key);

  final double col;
  final double row;
  final bool mandatory;
  final bool disabled;
  final bool readOnly;
  final String label;
  final Icon icon;
  final List<String> labelList;
  final String errorMessage;
  final Function setAction;
  final List<Widget> actions;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;
  final bool inCard;
  final bool hidden;
  final double order;

  @override
  _JudoLinkState createState() => _JudoLinkState();
}

class _JudoLinkState extends State<JudoLink> {
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    if (widget.hidden) return JudoSpacer(col: widget.col, row: widget.row);

    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return JudoContainer(
        padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
        order: widget.order,
        col: widget.col,
        row: widget.row,
        stretch: widget.stretch,
        alignment: widget.alignment,
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
                                    onTap: !widget.readOnly && !widget.disabled ? widget.setAction : null,
                                    child: getTextField(context),
                                    focusColor: Colors.transparent,
                                    onFocusChange: (hasFocus) {
                                      setState(() {
                                        _hasFocus = hasFocus;
                                      });
                                    },
                                ),
                                decoration: widget.errorMessage != null && widget.errorMessage.isNotEmpty ? null : JudoComponentCustomizer.get().getInputBoxCustomizer(theme, widget.disabled, widget.readOnly),
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
            data: JudoComponentCustomizer.get().getInputLinkThemeCustomizer(theme, widget.disabled, widget.readOnly, widget.inCard, widget.errorMessage),
          )
        );
  }

  Widget getTextField(BuildContext context) {
      final TextEditingController controller = TextEditingController(text: formatLabel(widget.labelList));
      return IgnorePointer(
          child: TextField(
            controller: controller,
            readOnly: widget.readOnly,
            enabled: widget.readOnly, // use readOnly here to prevent focus on TextField when creating/editing and to enable copying text from Link component on view pages, while using tab key
            decoration: JudoComponentCustomizer.get().getInputLinkDecoration(Theme.of(context), widget.label, widget.icon, null, widget.mandatory, widget.disabled, widget.readOnly, widget.errorMessage, _hasFocus)
          )
      );
  }

  List<Widget> getActionWidgets() {
    List ret = widget.actions;
    if (ret == null) {
      return [];
    }
    ret.removeWhere((value) => value == null);
    return ret;
  }

  String formatLabel(List<String> labelList) {
    return labelList.where((label) => label != null && label.isNotEmpty).join(' - ');
  }
}
