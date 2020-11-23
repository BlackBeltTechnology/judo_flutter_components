part of judo.components;

class JudoContainer extends StatelessWidget {
  JudoContainer({
    this.child,
    this.col = 4,
    this.row = 1,
    this.padding,
    this.color,
    this.stretch = false,
    this.alignment,
  });

  final Widget child;
  final EdgeInsets padding;
  final int col;
  final int row;
  final Color color;
  final bool stretch;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: col,
      child: Container(
        color: color,
        height: row * JudoComponentsSettings.height,
        padding: padding,
        child: Align(
          alignment: alignment,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: stretch ? FlexFit.tight : FlexFit.loose,
                child: child
              ),
            ],
          ),
        ),
      ),
    );
  }
}
