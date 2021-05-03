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

  InputDecoration getInputDecoration(
      String label, Widget prefixIcon, Widget suffixIcon);
  InputDecoration getInputTextDecoration(
      String label, Widget prefixIcon, Widget suffixIcon);
  InputDecoration getInputDateDecoration(
      String label, Widget prefixIcon, Widget suffixIcon);
  InputDecoration getInputDateTimeDecoration(
      String label, Widget prefixIcon, Widget suffixIcon);
  InputDecoration getInputLinkDecoration(
      String label, Widget prefixIcon, Widget suffixIcon);
  InputDecoration getInputNumericDecoration(
      String label, Widget prefixIcon, Widget suffixIcon);

  ThemeData getBreadcumbThemeCustomizer(ThemeData themeData);
  TextStyle getBreadcumbTextStyle();
}

class DefaultJudoComponentsCustomizer implements JudoComponentCustomizer {
  double getLineHeight() {
    return 72;
  }

  EdgeInsets getDefaultPadding() {
    return EdgeInsets.symmetric(horizontal: 10);
  }

  Decoration getInputBoxCustomizer(bool disabled, bool readOnly) {}

  InputDecoration getInputDecoration(
      String label, Widget prefixIcon, Widget suffixIcon) {
    return InputDecoration(
        labelText: label, prefixIcon: prefixIcon, suffixIcon: suffixIcon);
  }

  InputDecoration getInputTextDecoration(
      String label, Widget prefixIcon, Widget suffixIcon) {
    return getInputDecoration(label, prefixIcon, suffixIcon);
  }

  InputDecoration getInputDateDecoration(
      String label, Widget prefixIcon, Widget suffixIcon) {
    return getInputDecoration(label, prefixIcon, suffixIcon);
  }

  InputDecoration getInputDateTimeDecoration(
      String label, Widget prefixIcon, Widget suffixIcon) {
    return getInputDecoration(label, prefixIcon, suffixIcon);
  }

  InputDecoration getInputLinkDecoration(
      String label, Widget prefixIcon, Widget suffixIcon) {
    return InputDecoration(
      enabled: false,
      labelText: label,
      prefixIcon: prefixIcon,
    );
  }

  InputDecoration getInputNumericDecoration(
      String label, Widget prefixIcon, Widget suffixIcon) {
    return getInputDecoration(label, prefixIcon, suffixIcon);
  }

  @override
  ThemeData getInputThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return theme.copyWith(
        primaryColor: (disabled || readOnly)
            ? theme.iconTheme.color
            : theme.colorScheme.secondary,
        inputDecorationTheme: (disabled || readOnly)
            ? theme.inputDecorationTheme.copyWith(
                labelStyle: theme.inputDecorationTheme.labelStyle
                    .copyWith(color: Colors.black),
                filled: false)
            : inCard
                ? theme.inputDecorationTheme.copyWith(
                    fillColor: Color(0xfffafafa),
                  )
                : null);
  }

  ThemeData getInputTextThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return getInputThemeCustomizer(theme, disabled, readOnly, inCard);
  }

  ThemeData getInputDateThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return getInputThemeCustomizer(theme, disabled, readOnly, inCard);
  }

  ThemeData getInputDateTimeThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return getInputThemeCustomizer(theme, disabled, readOnly, inCard);
  }

  ThemeData getInputLinkThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return getInputThemeCustomizer(theme, disabled, readOnly, inCard);
  }

  ThemeData getInputNumericTimeThemeCustomizer(
      ThemeData theme, bool disabled, bool readOnly, bool inCard) {
    return getInputThemeCustomizer(theme, disabled, readOnly, inCard);
  }

  ThemeData getBreadcumbThemeCustomizer(ThemeData theme) {
    return theme;
  }

  TextStyle getBreadcumbTextStyle() {
    return TextStyle(fontSize: 16);
  }
}
