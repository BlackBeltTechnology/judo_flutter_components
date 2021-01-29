part of judo.components;



abstract class JudoComponentCustomizer {
  static JudoComponentCustomizer _instance = new DefaultJudoComponentsCustomizer();

  static JudoComponentCustomizer get() {
    return _instance;
  }

  static void set(JudoComponentCustomizer judoComponentCustomizer) {
    _instance = judoComponentCustomizer;
  }

  double getLineHeight();
  EdgeInsets getDefaultPadding();
  Decoration getInputBoxCustomizer(bool disabled, bool readOnly);

  ThemeData getInputThemeCustomizer(ThemeData theme, bool disabled, bool readOnly);
  ThemeData getInputTextThemeCustomizer(ThemeData theme, bool disabled, bool readOnly);
  ThemeData getInputDateThemeCustomizer(ThemeData theme, bool disabled, bool readOnly);
  ThemeData getInputDateTimeThemeCustomizer(ThemeData theme, bool disabled, bool readOnly);
  ThemeData getInputLinkThemeCustomizer(ThemeData theme, bool disabled, bool readOnly);
  ThemeData getInputNumericTimeThemeCustomizer(ThemeData theme, bool disabled, bool readOnly);

  InputDecoration getInputDecoration(String label, Widget prefixIcon, Widget suffixIcon);
  InputDecoration getInputTextDecoration(String label, Widget prefixIcon, Widget suffixIcon);
  InputDecoration getInputDateDecoration(String label, Widget prefixIcon, Widget suffixIcon);
  InputDecoration getInputDateTimeDecoration(String label, Widget prefixIcon, Widget suffixIcon);
  InputDecoration getInputLinkDecoration(String label, Widget prefixIcon, Widget suffixIcon);
  InputDecoration getInputNumericDecoration(String label, Widget prefixIcon, Widget suffixIcon);

  ThemeData getBreadcumbThemeCustomizer(ThemeData themeData);
  TextStyle getBreadcumbTextStyle();
}



class DefaultJudoComponentsCustomizer implements JudoComponentCustomizer {

  double getLineHeight() {
    return kToolbarHeight;
  }

  EdgeInsets getDefaultPadding() {
    return EdgeInsets.symmetric(horizontal: 10);
  }

  Decoration getInputBoxCustomizer(bool disabled, bool readOnly) {}

  InputDecoration getInputDecoration(String label, Widget prefixIcon, Widget suffixIcon) {
    return InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon
    );
  }

  InputDecoration getInputTextDecoration(String label, Widget prefixIcon, Widget suffixIcon) {
    return getInputDecoration(label, prefixIcon, suffixIcon);
  }

  InputDecoration getInputDateDecoration(String label, Widget prefixIcon, Widget suffixIcon) {
    return getInputDecoration(label, prefixIcon, suffixIcon);
  }

  InputDecoration getInputDateTimeDecoration(String label, Widget prefixIcon, Widget suffixIcon) {
    return getInputDecoration(label, prefixIcon, suffixIcon);
  }

  InputDecoration getInputLinkDecoration(String label, Widget prefixIcon, Widget suffixIcon) {
    return InputDecoration(
      enabled: false,
      labelText: label,
      prefixIcon: prefixIcon,
    );
  }

  InputDecoration getInputNumericDecoration(String label, Widget prefixIcon, Widget suffixIcon) {
    return getInputDecoration(label, prefixIcon, suffixIcon);
  }

  @override
  ThemeData getInputThemeCustomizer(ThemeData theme, bool disabled, bool readOnly) {
    return theme.copyWith(
      primaryColor: (disabled || readOnly) ?
      theme.iconTheme.color : theme.colorScheme.secondary,
      inputDecorationTheme:
      (disabled || readOnly) ?
      theme.inputDecorationTheme.copyWith(
        filled: false,
      ) : null,
    );
  }


  ThemeData getInputTextThemeCustomizer(ThemeData theme, bool disabled, bool readOnly) {
    return getInputThemeCustomizer(theme, disabled, readOnly);
  }

  ThemeData getInputDateThemeCustomizer(ThemeData theme, bool disabled, bool readOnly) {
    return getInputThemeCustomizer(theme, disabled, readOnly);
  }

  ThemeData getInputDateTimeThemeCustomizer(ThemeData theme, bool disabled, bool readOnly) {
    return getInputThemeCustomizer(theme, disabled, readOnly);
  }

  ThemeData getInputLinkThemeCustomizer(ThemeData theme, bool disabled, bool readOnly) {
    return getInputThemeCustomizer(theme, disabled, readOnly);
  }

  ThemeData getInputNumericTimeThemeCustomizer(ThemeData theme, bool disabled, bool readOnly) {
    return getInputThemeCustomizer(theme, disabled, readOnly);
  }

  ThemeData getBreadcumbThemeCustomizer(ThemeData theme) {
    return theme;
  }

  TextStyle getBreadcumbTextStyle() {
    return TextStyle(
        fontSize: 16
    );
  }
}
