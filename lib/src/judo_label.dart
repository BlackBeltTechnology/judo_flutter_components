part of judo.components;

class JudoLabel extends StatefulWidget {

  JudoLabel({
    Key key,
    this.col = 4,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
    this.text,
    this.trailingIcon,
    this.leadingIcon,
  }) : super(key: key);

  final int col;
  final EdgeInsets padding;
  final bool stretch;
  final Alignment alignment;
  final String text;
  final Icon trailingIcon;
  final Icon leadingIcon;

  @override
  JudoLabelState createState() => JudoLabelState();
}

class JudoLabelState extends State<JudoLabel> {

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: widget.col,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: Row(
        children: [
          widget.leadingIcon ?? Text(''),
          Text(
            widget.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          widget.trailingIcon ?? Text(''),
        ],
      ),
    );
  }

}
