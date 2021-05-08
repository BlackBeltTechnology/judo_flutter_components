part of judo.components;

abstract class JudoComponentCustomizer {
  static JudoComponentCustomizer _instance =
      new DefaultJudoComponentsCustomizer();

  static JudoComponentCustomizer get() {
    return _instance;
  }

  static void set(JudoComponentCustomizer judoComponentCustomizer) {
    _instance = judoComponentCustomizer;
  }

  double getLineHeight();
  double getInputHeight();
  double getMenuWidth();
  double getGeneratedButtonWidth();
  double getWidthOfButtonContainer(BuildContext context, double col);
  EdgeInsets getDefaultPadding();
  Decoration getInputBoxCustomizer(bool disabled, bool readOnly);

  ThemeData getInputThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard);
  ThemeData getInputTextThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard);
  ThemeData getInputDateThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard);
  ThemeData getInputDateTimeThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard);
  ThemeData getInputLinkThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard);
  ThemeData getInputNumericTimeThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard);
  ThemeData getInputComboboxThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard);

  InputDecoration getInputDecoration(
      String label, Widget prefixIcon, Widget suffixIcon, bool mandatory);
  InputDecoration getInputTextDecoration(
      String label, Widget prefixIcon, Widget suffixIcon, bool mandatory, bool multiline);
  InputDecoration getInputDateDecoration(
      String label, Widget prefixIcon, Widget suffixIcon, bool mandatory);
  InputDecoration getInputDateTimeDecoration(
      String label, Widget prefixIcon, Widget suffixIcon, bool mandatory);
  InputDecoration getInputLinkDecoration(
      String label, Widget prefixIcon, Widget suffixIcon);
  InputDecoration getInputNumericDecoration(
      String label, Widget prefixIcon, Widget suffixIcon, bool mandatory);
  InputDecoration getInputComboboxDecoration(
      String label, Widget prefixIcon, Widget suffixIcon, bool mandatory);

  ThemeData getBreadcumbThemeCustomizer(ThemeData themeData);
  ThemeData getFilterThemeCustomizer(ThemeData themeData);
  ThemeData getMenuTheme(ThemeData theme);
  TextStyle getBreadcumbTextStyle();
  TextStyle getTableHeaderTextStyle(ThemeData theme);
  TextStyle getSwitchTextStyle(ThemeData theme);
  TextStyle getRadioTextStyle(ThemeData theme);
  TextStyle getAppNameTextStyle(ThemeData theme);
  TextStyle getActorNameTextStyle(ThemeData theme);
  TextStyle getUserNameTextStyle(ThemeData theme);
  TextStyle getRowCounterTextStyle(ThemeData theme);
}

class DefaultJudoComponentsCustomizer implements JudoComponentCustomizer {

  Color displayColor = Color(0xff17191d);
  Color bodyColor = Color(0xff434448);
  Color inputUnderlineColor = Color(0xfff0f0f0);
  Color shadowColor = Colors.black12;
  Color transparentColor = Colors.transparent;
  Color inputLabelColor = Color(0xff8f8f8f);

  @override
  double getLineHeight() {
    return 72;
  }

  @override
  double getInputHeight() {
    return 52;
  }

  @override
  EdgeInsets getDefaultPadding() {
    return EdgeInsets.symmetric(horizontal: 10);
  }

  @override
  double getMenuWidth() {
    return 304.0;
  }

  @override
  double getGeneratedButtonWidth() {
    return 130.0;
  }

  @override
  Decoration getInputBoxCustomizer(bool disabled, bool readOnly) {
    return (disabled || readOnly) ? null :
    BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: shadowColor,
              blurRadius: 4,
              offset: const Offset(0, 0)
          )
        ]
    );
  }

  @override
  InputDecoration getInputDecoration(String label, Widget prefixIcon, Widget suffixIcon, bool mandatory) {
    return label != null ?
    InputDecoration(
      labelText: mandatory ? label + ' *' : label,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      counterText: '',
    ) :
    InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      counterText: '',
      contentPadding:  EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0, bottom: 24.0),
    );
  }

  @override
  InputDecoration getInputTextDecoration(String label, Widget prefixIcon, Widget suffixIcon, bool mandatory, bool multiline) {
    return getInputDecoration(label, prefixIcon, suffixIcon, mandatory).copyWith(
        floatingLabelBehavior: multiline ? FloatingLabelBehavior.always : null
    );
  }

  @override
  InputDecoration getInputDateDecoration(String label, Widget prefixIcon, Widget suffixIcon, bool mandatory) {
    return getInputDecoration(label, prefixIcon, suffixIcon, mandatory);
  }

  @override
  InputDecoration getInputDateTimeDecoration(String label, Widget prefixIcon, Widget suffixIcon, bool mandatory) {
    return getInputDecoration(label, prefixIcon, suffixIcon, mandatory);
  }

  @override
  InputDecoration getInputLinkDecoration(String label, Widget prefixIcon, Widget suffixIcon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: prefixIcon,
    );
  }

  @override
  InputDecoration getInputNumericDecoration(String label, Widget prefixIcon, Widget suffixIcon, bool mandatory) {
    return getInputDecoration(label, prefixIcon, suffixIcon, mandatory);
  }

  @override
  InputDecoration getInputComboboxDecoration(String label, Widget prefixIcon, Widget suffixIcon, bool mandatory) {
    return label != null ?
    getInputDecoration(label, prefixIcon, suffixIcon, mandatory).copyWith(
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ) :
    getInputDecoration(label, prefixIcon, suffixIcon, mandatory).copyWith(
      contentPadding:  EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
    );
  }

  @override
  ThemeData getInputThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return theme.copyWith(
        textTheme: theme.textTheme.copyWith(
          subtitle1: theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500),
        ),
        primaryColor: (disabled || readOnly)
            ? theme.iconTheme.color
            : theme.colorScheme.secondary,
        inputDecorationTheme: (disabled || readOnly)
            ? theme.inputDecorationTheme.copyWith(
            filled: false)
            : inCard
            ? theme.inputDecorationTheme.copyWith(
          fillColor: theme.backgroundColor,
        )
            : null);
  }

  @override
  ThemeData getInputTextThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return getInputThemeCustomizer(theme, disabled, readOnly, inCard);
  }

  @override
  ThemeData getInputDateThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return getInputThemeCustomizer(theme, disabled, readOnly, inCard);
  }

  @override
  ThemeData getInputDateTimeThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return getInputThemeCustomizer(theme, disabled, readOnly, inCard);
  }

  @override
  ThemeData getInputLinkThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return theme.copyWith(
        textTheme: theme.textTheme.copyWith(
          subtitle1: theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500),
        ),
        primaryColor: theme.colorScheme.secondary,
        iconTheme: theme.iconTheme.copyWith(color: theme.colorScheme.secondary),
        inputDecorationTheme: (disabled || readOnly)
            ? theme.inputDecorationTheme.copyWith(
            filled: false)
            : inCard
            ? theme.inputDecorationTheme.copyWith(
          fillColor: theme.backgroundColor,
        )
            : theme.inputDecorationTheme);
  }

  @override
  ThemeData getInputNumericTimeThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return getInputThemeCustomizer(theme, disabled, readOnly, inCard);
  }

  @override
  ThemeData getInputComboboxThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return getInputThemeCustomizer(theme, disabled, readOnly, inCard).copyWith(
      disabledColor: bodyColor
    );
  }

  @override
  ThemeData getBreadcumbTheme(ThemeData theme) {
    return theme.copyWith(
      primaryColor: theme.cardColor,
    );
  }

  @override
  ThemeData getMenuTheme(ThemeData theme) {
    return theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(primary: theme.colorScheme.secondary)
    );
  }

  @override
  TextStyle getBreadcumbTextStyle() {
    return TextStyle(
        color: bodyColor,
        fontSize: 16,
        fontFamily: 'SourceSansPro',
        fontWeight: FontWeight.w500
    );
  }

  @override
  TextStyle getRowCounterTextStyle(ThemeData theme) {
    return theme.textTheme.caption.copyWith(color: theme.colorScheme.primaryVariant);
  }

  @override
  TextStyle getTableHeaderTextStyle(ThemeData theme) {
    return theme.textTheme.subtitle1.copyWith(color: displayColor);
  }

  @override
  TextStyle getSwitchTextStyle(ThemeData theme) {
    return theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500);
  }

  @override
  TextStyle getRadioTextStyle(ThemeData theme) {
    return theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500);
  }

  @override
  TextStyle getAppNameTextStyle(ThemeData theme) {
    return theme.textTheme.headline6.copyWith(fontWeight: FontWeight.w900);
  }

  @override
  TextStyle getActorNameTextStyle(ThemeData theme) {
    return theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w100);
  }

  @override
  TextStyle getUserNameTextStyle(ThemeData theme) {
    return theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w900);
  }

  double getContentMargin(BuildContext context) {
    double ceil = 2000;
    double floor = 1300;
    double min_margin = 10;
    double max_margin = 116;
    return ((min(max(floor, MediaQuery.of(context).size.width), ceil) - floor) / (ceil - floor)) * (max_margin - min_margin) + min_margin;
  }

  @override
  double getWidthOfButtonContainer(BuildContext context, double col) {
    if (MediaQuery.of(context).size.width >= 0 && MediaQuery.of(context).size.width <= 599) {
      return (col * (MediaQuery.of(context).size.width - 20.0) / 4.0) - 20.0;
    }
    if (MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width <= 839) {
      return (col * (MediaQuery.of(context).size.width - 20.0) / 8.0) - 20.0;
    }
    if (MediaQuery.of(context).size.width >= 840 && MediaQuery.of(context).size.width <= 32767) {
      return col * (MediaQuery.of(context).size.width - getMenuWidth() - 2 * getContentMargin(context)) / 12.0;
    }
  }

  @override
  ThemeData getBreadcumbThemeCustomizer(ThemeData theme) {
    return theme;
  }

  @override
  ThemeData getFilterThemeCustomizer(ThemeData theme) {
    return theme;
  }


}
