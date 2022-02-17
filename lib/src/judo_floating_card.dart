part of judo.components;

enum ErrorLevel { error, warning, info, complete }

class JudoFloatingCard extends StatefulWidget {
  const JudoFloatingCard({
    Key key,
    this.visible,
    this.errorLevel,
    this.message,
    this.actionName,
  }) : super(key: key);

  final bool visible;
  final ErrorLevel errorLevel;
  final String message;
  final String actionName;

  @override
  _JudoFloatingCardState createState() => _JudoFloatingCardState();
}

class _JudoFloatingCardState extends State<JudoFloatingCard> {
  bool _visible = false;
  double height = 0;
  double width = 0;

  void close() {
    setState(() {
      height = 144;
      width = 444;
    });
  }

  @override
  void initState() {
    super.initState();
    _visible = widget.visible;
    close();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 15,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20)
            ),
            color: Color.fromRGBO(255, 233, 233, 0.9),
          ),
          width: width,
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  right: 350,
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50,
                  )
              ),
              Positioned(
                  top: 24,
                  left: 132,
                  child: Container(
                    height: 72,
                    width: 280,
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 4,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  )
              ),
              Positioned(
                left: 132,
                bottom: 24,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 280,
                  ),
                  child: Container(
                    height: 24,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.actionName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 2,
                  right: 2,
                  child: Material(
                    type: MaterialType.transparency, // InkSplash occurs on the closest ancestor Material widget.
                    child: IconButton(
                      onPressed: () => close(),
                      icon: Icon(
                        Icons.close,
                        size: 18,
                      ),
                      splashRadius: 20,
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

}
