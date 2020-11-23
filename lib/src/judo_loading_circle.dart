part of judo.components;

class JudoLoadingProgress extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return JudoContainer(
      col: 1,
      row: 1,
      stretch: false,
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              backgroundColor: JudoComponentsSettings.primaryColor,
              strokeWidth: 8,
            )
        ),
      ),
    );
  }
}
