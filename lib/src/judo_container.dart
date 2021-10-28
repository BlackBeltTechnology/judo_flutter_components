part of judo.components;

class JudoContainer extends StatefulWidget {

  JudoContainer({
    Key key,
    this.child,
    this.col = 4,
    this.row = 1.0,
    this.padding,
    this.color,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.order,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final double col;
  final double row;
  final Color color;
  final bool stretch;
  final Alignment alignment;
  final double order;

  @override
  JudoContainerState createState() => JudoContainerState();
}

class JudoContainerState extends State<JudoContainer> {

  @override
  Widget build(BuildContext context) {
    if (widget.order != null) {
      return FocusTraversalOrder(
        order: NumericFocusOrder(widget.order),
        child: JudoContainerWidget(),
      );
    }
    return JudoContainerWidget();
  }

  Widget JudoContainerWidget() {
    return Expanded(
      flex: (widget.col * 100).round(),
      child: Container(
        color: widget.color,
        height: widget.row * JudoComponentCustomizer.get().getLineHeight(),
        padding: widget.padding,
        child: Align(
          alignment: widget.alignment,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: widget.stretch ? FlexFit.tight : FlexFit.loose,
                child: widget.child
              ),
            ],
          ),
        ),
      ),
    );
  }
}
