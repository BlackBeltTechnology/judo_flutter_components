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
  double getMenuWidth();
  EdgeInsets getDefaultPadding();
  EdgeInsets getNavigationButtonBarPadding();
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
      ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage);
  InputDecoration getInputTextDecoration(
      ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool multiline, bool disabled, bool readOnly, String errorMessage);
  InputDecoration getInputDateDecoration(
      ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage);
  InputDecoration getInputDateTimeDecoration(
      ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage);
  InputDecoration getInputLinkDecoration(
      ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage);
  InputDecoration getInputNumericDecoration(
      ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage);
  InputDecoration getInputComboboxDecoration(
      ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage);

  ThemeData getBreadcumbThemeCustomizer(ThemeData themeData);
  ThemeData getFilterThemeCustomizer(ThemeData themeData);
  ThemeData getMenuTheme(ThemeData theme);
  @deprecated
  TextStyle getBreadcumbTextStyle();
  TextStyle getBreadcumbItemTextStyle(ThemeData theme);
  TextStyle getBreadcumbTitleTextStyle(ThemeData theme);
  TextStyle getTableHeaderTextStyle(ThemeData theme);
  TextStyle getSwitchTextStyle(ThemeData theme, String errorMessage);
  TextStyle getRadioTextStyle(ThemeData theme, String errorMessage);
  TextStyle getAppNameTextStyle(ThemeData theme);
  TextStyle getSloganTextStyle(ThemeData theme);
  TextStyle getActorNameTextStyle(ThemeData theme);
  TextStyle getUserNameTextStyle(ThemeData theme);
  TextStyle getEmailTextStyle(ThemeData theme);
  TextStyle getRowCounterTextStyle(ThemeData theme);
  MaterialStateProperty<Color> getRowColour(ThemeData theme, int index, bool inCard);
}

class DefaultJudoComponentsCustomizer implements JudoComponentCustomizer {

  Color displayColor = Color(0xff17191d);
  Color bodyColor = Color(0xff434448);
  Color inputUnderlineColor = Color(0xfff0f0f0);
  Color shadowColor = Colors.black12;
  Color transparentColor = Colors.transparent;
  Color inputLabelColor = Color(0xff8f8f8f);
  Color errorColor = Colors.red[700];

  @override
  double getLineHeight() {
    return 72;
  }

  @override
  EdgeInsets getDefaultPadding() {
    return EdgeInsets.symmetric(horizontal: 10);
  }

  EdgeInsets getNavigationButtonBarPadding() {
    return EdgeInsets.all(10);
  }

  @override
  double getMenuWidth() {
    return 304.0;
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
  InputDecoration getInputDecoration(ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage) {
    return InputDecoration(
      labelText: label != null ?
      ( mandatory ? label + ' *' : label )
          : null,
      prefixIcon: errorMessage != null && prefixIcon != null ? Icon(
        prefixIcon.icon,
        color: errorColor,
      ) : prefixIcon,
      suffixIcon: suffixIcon,
      counterText: '',
      errorText: errorMessage,
      errorBorder: errorMessage != null ? UnderlineInputBorder(borderSide: BorderSide(color: errorColor, width: 2.0)) : null,
      fillColor: errorMessage != null ? errorColor.withOpacity(0.3) : null,
      errorStyle: TextStyle(
        color: errorColor,
        fontWeight: FontWeight.bold,
        fontSize: 11,
        height: 0.4,
      ),
      labelStyle: errorMessage != null ? theme.inputDecorationTheme.labelStyle.copyWith(
        color: errorColor.withOpacity(0.8),

      ) : null,
    );
  }

  @override
  InputDecoration getInputTextDecoration(ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool multiline, bool disabled, bool readOnly, String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory, disabled, readOnly, errorMessage).copyWith(
        floatingLabelBehavior: multiline ? FloatingLabelBehavior.always : null
    );
  }

  @override
  InputDecoration getInputDateDecoration(ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory, disabled, readOnly, errorMessage);
  }

  @override
  InputDecoration getInputDateTimeDecoration(ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory, disabled, readOnly, errorMessage);
  }

  @override
  InputDecoration getInputLinkDecoration(ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory, disabled, readOnly, errorMessage).copyWith(
      errorBorder: errorMessage != null ? OutlineInputBorder(borderSide: BorderSide(color: errorColor, width: 2.0)) : null,
    );
  }

  @override
  InputDecoration getInputNumericDecoration(ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory, disabled, readOnly, errorMessage);
  }

  @override
  InputDecoration getInputComboboxDecoration(ThemeData theme, String label, Icon prefixIcon, Widget suffixIcon, bool mandatory, bool disabled, bool readOnly, String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory, disabled, readOnly, errorMessage).copyWith();
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
        primaryColor: theme.colorScheme.secondary,
        colorScheme: theme.colorScheme.copyWith(primary: theme.colorScheme.secondary)
    );
  }

  @override
  @deprecated
  TextStyle getBreadcumbTextStyle() {
    return TextStyle(
        color: bodyColor,
        fontSize: 16,
        fontFamily: 'SourceSansPro',
        fontWeight: FontWeight.w500
    );
  }

  @override
  TextStyle getBreadcumbItemTextStyle(ThemeData theme) {
    return TextStyle(
        color: bodyColor,
        fontSize: 16,
        fontFamily: 'SourceSansPro',
        fontWeight: FontWeight.w500
    );
  }

  @override
  TextStyle getBreadcumbTitleTextStyle(ThemeData theme) {
    return theme.textTheme.headline4.copyWith(fontSize: 16);
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
  TextStyle getSwitchTextStyle(ThemeData theme, String errorMessage) {
    return theme.textTheme.subtitle1.copyWith(
        fontWeight: errorMessage != null ? FontWeight.w700 : FontWeight.w500,
        color: errorMessage != null ? errorColor : null,
    );
  }

  @override
  TextStyle getRadioTextStyle(ThemeData theme, String errorMessage) {
    return theme.textTheme.subtitle1.copyWith(
        fontWeight: errorMessage != null ? FontWeight.w700 : FontWeight.w500,
        color: errorMessage != null ? errorColor : null,
    );
  }

  @override
  TextStyle getAppNameTextStyle(ThemeData theme) {
    return theme.textTheme.headline6.copyWith(fontWeight: FontWeight.w900);
  }

  @override
  TextStyle getSloganTextStyle(ThemeData theme) {
    return theme.textTheme.headline6.copyWith(
        fontWeight: FontWeight.w100,
        color: theme.textTheme.subtitle1.color
    );
  }

  @override
  TextStyle getActorNameTextStyle(ThemeData theme) {
    return theme.textTheme.subtitle1.copyWith(
        fontWeight: FontWeight.w900,
        color: theme.colorScheme.secondary,
    );
  }

  @override
  TextStyle getUserNameTextStyle(ThemeData theme) {
    return theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w900);
  }

  @override
  TextStyle getEmailTextStyle(ThemeData theme) {
    return theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w100);
  }

  @override
  ThemeData getBreadcumbThemeCustomizer(ThemeData theme) {
    return theme;
  }

  @override
  ThemeData getFilterThemeCustomizer(ThemeData theme) {
    return theme;
  }

  @override
  MaterialStateProperty<Color> getRowColour(ThemeData theme, int index, bool inCard) {
    return MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          // All rows will have the same selected color.
          if (states.contains(MaterialState.selected)) {
            return theme.colorScheme.primary.withOpacity(0.08);
          }
          // Even rows will have a grey color.
          if (index % 2 == 0) {
            return inCard ? theme.backgroundColor : theme.cardColor;
          }
          return inCard ? theme.cardColor : theme.backgroundColor;
        }
    );
  }


}
