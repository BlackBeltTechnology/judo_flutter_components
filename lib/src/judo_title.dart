part of judo.components;

class JudoTitle extends StatefulWidget {
  JudoTitle({
    this.col,
    @required this.text,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  });

  final String text;
  final int col;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

  @override
  JudoTitleState createState() => JudoTitleState();
}

class JudoTitleState extends State<JudoTitle> {
  
  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
      stretch: widget.stretch,
      alignment: widget.alignment,
      col: widget.col,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.text,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: JudoComponentsSettings.secondaryColor,
                fontSize: 24),
          ),
          SizedBox(
            height: 10,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
