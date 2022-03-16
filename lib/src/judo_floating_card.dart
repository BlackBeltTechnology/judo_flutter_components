part of judo.components;

enum MessageLevel { error, warning, info, success }

abstract class FloatingMessage {
  String get actionCallName;
  String get message;
  MessageLevel get messageLevel;
}

class JudoFloatingCard extends StatelessWidget {
  const JudoFloatingCard({
    Key key,
    this.messageStack = const [],
    @required this.closeAction,
  }) : super(key: key);

  final List<FloatingMessage> messageStack;
  final Function closeAction;
  final double height = 144;
  final double width = 444;

  @override
  Widget build(BuildContext context) {
    if(messageStack.isNotEmpty) {
      final ThemeData theme = Theme.of(context);

      return Positioned.fill(
        bottom: 15,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              ..._floatingCardsStack(messageStack),
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Colors.black26,
                    blurRadius: 60,
                  )],
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20)
                  ),
                  color: _getBackgroundColor(messageStack.first.messageLevel),
                ),
              ),
              Positioned(
                  right: 350,
                  child: _getIcon(messageStack.first.messageLevel, theme),
              ),
              _getText(messageStack.first.messageLevel),
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
                        messageStack.first.actionCallName ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _getTextColor(messageStack.first.messageLevel, theme),
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
                      onPressed: closeAction,
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
      );
    }
    return SizedBox.shrink();

  }

  List<Widget> _floatingCardsStack(final List<FloatingMessage> messageStack) {
    if (messageStack.length < 2) return [SizedBox.shrink()];
    List<Widget> floatingCards = [];

    for (int i = 1; i < messageStack.length; i++) {
      floatingCards.insert(0,
          Positioned(
            top: 7 * i.toDouble(),
            left: 7 * i.toDouble(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20)
                ),
                color: Color.fromRGBO(
                    _getBackgroundColor(messageStack[i].messageLevel).red - 10 - i * 2,
                    _getBackgroundColor(messageStack[i].messageLevel).green - 10 - i * 2,
                    _getBackgroundColor(messageStack[i].messageLevel).blue - 10 - i * 2,
                    0.7
                ),
              ),
              width: width,
              height: height,
            ),
          )
      );
    }

    return floatingCards;
  }

  Widget _getText(MessageLevel messageLevel) {
    double leftPosition = 132;

    if (messageLevel == MessageLevel.info) {
      leftPosition = 44;
    }

    return Positioned(
        top: 24,
        left: leftPosition,
        child: Container(
          height: 72,
          width: 280,
          child: Text(
            messageStack.first.message ?? '',
            style: TextStyle(
              fontSize: 14,
            ),
            maxLines: 4,
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        )
    );
  }

  Color _getBackgroundColor(MessageLevel messageLevel) {
    switch(messageLevel) {
      case MessageLevel.error:
        return JudoComponentCustomizer.get().floatingCardErrorBackgroundColor;
      case MessageLevel.warning:
        return JudoComponentCustomizer.get().floatingCardWarningBackgroundColor;
      case MessageLevel.info:
        return JudoComponentCustomizer.get().floatingCardInfoBackgroundColor;
      case MessageLevel.success:
        return JudoComponentCustomizer.get().floatingCardSuccessBackgroundColor;
    }
  }

  Widget _getIcon(MessageLevel messageLevel, ThemeData theme) {
    switch(messageLevel) {
      case MessageLevel.error:
        return Icon(
          Icons.error_outline,
          color: theme.errorColor,
          size: 50,
        );
      case MessageLevel.warning:
        return Icon(
          Icons.warning_amber_outlined,
          color: JudoComponentCustomizer.get().floatingCardWarningIconColor,
          size: 50,
        );
      case MessageLevel.info:
        return SizedBox.shrink();
      case MessageLevel.success:
        return Icon(
          Icons.check_circle_outlined,
          color: JudoComponentCustomizer.get().floatingCardSuccessIconAndTextColor,
          size: 50,
        );
    }
  }

  Color _getTextColor(MessageLevel messageLevel, ThemeData theme) {
    switch(messageLevel) {
      case MessageLevel.error:
        return theme.errorColor;
      case MessageLevel.warning:
      case MessageLevel.info:
        return JudoComponentCustomizer.get().floatingCardWarningAndInfoTextColor;
      case MessageLevel.success:
        return JudoComponentCustomizer.get().floatingCardSuccessIconAndTextColor;
    }
  }

}
