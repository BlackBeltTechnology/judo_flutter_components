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

  ThemeData getInputThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage);

  ThemeData getInputTextThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage);

  ThemeData getInputDateThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage);

  ThemeData getInputDateTimeThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage);

  ThemeData getInputLinkThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage);

  ThemeData getInputNumericTimeThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage);

  ThemeData getInputComboboxThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage);

  ThemeData getSwitchThemeData(
      ThemeData theme, bool disabled, bool readOnly, String errorMessage);

  ThemeData getRadioThemeData(ThemeData theme, bool disabled, bool readOnly,
      bool selected, String errorMessage);

  ThemeData getTableThemeData(ThemeData theme);

  ThemeData getBreadcrumbThemeCustomizer(ThemeData themeData);

  ThemeData getFilterThemeCustomizer(ThemeData themeData);

  ThemeData getMenuTheme(ThemeData theme);

  ThemeData getBooleanColorTheme(ThemeData theme, bool value);

  Decoration getInputBoxCustomizer(
      ThemeData theme, bool disabled, bool readOnly);

  InputDecoration getInputDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage);

  InputDecoration getInputTextDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      bool multiline,
      String errorMessage);

  InputDecoration getInputDateDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage);

  InputDecoration getInputDateTimeDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage);

  InputDecoration getInputLinkDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage);

  InputDecoration getInputNumericDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage);

  InputDecoration getInputComboboxDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage);

  TextStyle getBreadcrumbItemTextStyle(ThemeData theme);

  TextStyle getBreadcrumbTitleTextStyle(ThemeData theme);

  TextStyle getTableHeaderTextStyle(ThemeData theme);

  TextStyle getSwitchTextStyle(
      ThemeData theme, bool disabled, bool readOnly, String errorMessage);

  TextStyle getRadioTextStyle(
      ThemeData theme, bool disabled, bool readOnly, String errorMessage);

  TextStyle getAppNameTextStyle(ThemeData theme);

  TextStyle getSloganTextStyle(ThemeData theme);

  TextStyle getActorNameTextStyle(ThemeData theme);

  TextStyle getUserNameTextStyle(ThemeData theme);

  TextStyle getEmailTextStyle(ThemeData theme);

  TextStyle getLabelTextStyle(ThemeData theme);

  TextStyle getTitleTextStyle(ThemeData theme);

  TextStyle getRowCounterTextStyle(ThemeData theme);

  MaterialStateProperty<Color> getRowColor(
      ThemeData theme, int index, bool inCard);
}

class DefaultJudoComponentsCustomizer implements JudoComponentCustomizer {
  Color booleanTrueColor = Colors.green.shade500.withOpacity(0.7);
  Color booleanFalseColor = Colors.red.shade500.withOpacity(0.7);

  @override
  double getLineHeight() {
    return 72;
  }

  @override
  double getMenuWidth() {
    return 304.0;
  }

  @override
  EdgeInsets getDefaultPadding() {
    return EdgeInsets.symmetric(horizontal: 10);
  }

  @override
  EdgeInsets getNavigationButtonBarPadding() {
    return EdgeInsets.all(10);
  }

  @override
  ThemeData getInputThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage) {
    if (errorMessage != null) {
      return theme.copyWith(
          colorScheme:
              theme.colorScheme.copyWith(primary: theme.colorScheme.secondary),
          textTheme: theme.textTheme.copyWith(
            subtitle1: theme.textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: theme.errorColor),
          ),
          inputDecorationTheme: theme.inputDecorationTheme.copyWith(
            fillColor: theme.errorColor.withOpacity(0.1),
            hoverColor: theme.errorColor.withOpacity(0.1),
          ),
          iconTheme: theme.iconTheme.copyWith(color: theme.errorColor),
          buttonTheme: theme.buttonTheme.copyWith());
    }
    return theme.copyWith(
        colorScheme:
            theme.colorScheme.copyWith(primary: theme.colorScheme.secondary),
        textTheme: disabled
            ? theme.textTheme.copyWith(
                subtitle1: theme.textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: theme.disabledColor),
              )
            : theme.textTheme.copyWith(
                subtitle1: theme.textTheme.subtitle1
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 16.0),
              ),
        inputDecorationTheme: (disabled || readOnly)
            ? theme.inputDecorationTheme.copyWith(filled: false)
            : inCard
                ? theme.inputDecorationTheme.copyWith(
                    fillColor: theme.backgroundColor,
                    hoverColor: theme.cardColor,
                  )
                : null);
  }

  @override
  ThemeData getInputTextThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage) {
    return getInputThemeCustomizer(
        theme, disabled, readOnly, inCard, errorMessage);
  }

  @override
  ThemeData getInputDateThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage) {
    return getInputThemeCustomizer(
        theme, disabled, readOnly, inCard, errorMessage);
  }

  @override
  ThemeData getInputDateTimeThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage) {
    return getInputThemeCustomizer(
        theme, disabled, readOnly, inCard, errorMessage);
  }

  @override
  ThemeData getInputLinkThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage) {
    return getInputThemeCustomizer(
            theme, disabled, readOnly, inCard, errorMessage)
        .copyWith(
      iconTheme: theme.iconTheme.copyWith(color: theme.colorScheme.secondary),
    );
  }

  @override
  ThemeData getInputNumericTimeThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage) {
    return getInputThemeCustomizer(
        theme, disabled, readOnly, inCard, errorMessage);
  }

  @override
  ThemeData getInputComboboxThemeCustomizer(ThemeData theme, bool disabled,
      bool readOnly, bool inCard, String errorMessage) {
    return readOnly
        ? getInputThemeCustomizer(
                theme, disabled, readOnly, inCard, errorMessage)
            .copyWith(
            disabledColor: theme.unselectedWidgetColor,
          )
        : getInputThemeCustomizer(
            theme, disabled, readOnly, inCard, errorMessage);
  }

  @override
  ThemeData getSwitchThemeData(
      ThemeData theme, bool disabled, bool readOnly, String errorMessage) {
    return disabled
        ? theme.copyWith(
            checkboxTheme: theme.checkboxTheme.copyWith(
              fillColor: MaterialStateProperty.all<Color>(theme.disabledColor),
              side: BorderSide(width: 2.0, color: theme.disabledColor),
            ),
          )
        : errorMessage != null
            ? theme.copyWith(
                checkboxTheme: theme.checkboxTheme.copyWith(
                  fillColor: MaterialStateProperty.all<Color>(theme.errorColor),
                  side: BorderSide(width: 2.0, color: theme.errorColor),
                ),
              )
            : theme;
  }

  @override
  ThemeData getRadioThemeData(ThemeData theme, bool disabled, bool readOnly,
      bool selected, String errorMessage) {
    if (errorMessage != null) {
      return theme.copyWith(
        radioTheme: theme.radioTheme.copyWith(
          fillColor: MaterialStateProperty.all<Color>(theme.errorColor),
        ),
      );
    }
    if (disabled) {
      return theme.copyWith(
        radioTheme: theme.radioTheme.copyWith(
          fillColor: MaterialStateProperty.all<Color>(theme.disabledColor),
        ),
      );
    }
    if (selected) {
      return theme.copyWith(
        radioTheme: theme.radioTheme.copyWith(
          fillColor:
              MaterialStateProperty.all<Color>(theme.colorScheme.secondary),
        ),
      );
    }
    return theme;
  }

  @override
  ThemeData getTableThemeData(ThemeData theme) {
    return theme.copyWith(
      iconTheme: theme.iconTheme.copyWith(
        color: theme.colorScheme.secondary,
        size: 24,
      ),
    );
  }

  @override
  ThemeData getBreadcrumbThemeCustomizer(ThemeData theme) {
    return theme.copyWith(
        iconTheme: theme.iconTheme.copyWith(
      color: theme.dividerColor,
      size: 20,
    ));
  }

  @override
  ThemeData getFilterThemeCustomizer(ThemeData theme) {
    return theme;
  }

  @override
  ThemeData getMenuTheme(ThemeData theme) {
    return theme.copyWith(
        primaryColor: theme.colorScheme.secondary,
        colorScheme:
            theme.colorScheme.copyWith(primary: theme.colorScheme.secondary));
  }

  @override
  ThemeData getBooleanColorTheme(ThemeData theme, bool value) {
    return theme.copyWith(
        iconTheme: theme.iconTheme.copyWith(
            color: value == null
                ? theme.dividerColor
                : value
                    ? booleanTrueColor
                    : booleanFalseColor));
  }

  @override
  Decoration getInputBoxCustomizer(
      ThemeData theme, bool disabled, bool readOnly) {
    return (disabled || readOnly)
        ? null
        : BoxDecoration(boxShadow: [
            BoxShadow(
                color: theme.shadowColor,
                blurRadius: 4,
                offset: const Offset(0, 0))
          ]);
  }

  @override
  InputDecoration getInputDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage) {
    if (errorMessage != null) {
      return InputDecoration(
          labelText: label != null ? (mandatory ? label + ' *' : label) : null,
          prefixIcon: Icon(
            prefixIcon.icon,
            color: theme.errorColor,
          ),
          suffixIcon: suffixIcon is Icon
              ? Icon(suffixIcon.icon, color: theme.errorColor)
              : suffixIcon is IconButton
                  ? IconButton(
                      onPressed: suffixIcon.onPressed,
                      icon: suffixIcon.icon,
                      color: theme.errorColor,
                    )
                  : suffixIcon,
          counterText: '',
          errorText: errorMessage,
          fillColor: theme.errorColor.withOpacity(0.1),
          labelStyle: theme.inputDecorationTheme.labelStyle.copyWith(
            color: theme.errorColor,
          ));
    }
    return InputDecoration(
      labelText: label != null ? (mandatory ? label + ' *' : label) : null,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      counterText: '',
      labelStyle: disabled
          ? theme.inputDecorationTheme.labelStyle.copyWith(
              color: theme.disabledColor,
            )
          : null,
    );
  }

  @override
  InputDecoration getInputTextDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      bool multiline,
      String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory,
            disabled, readOnly, errorMessage)
        .copyWith(
      floatingLabelBehavior: multiline ? FloatingLabelBehavior.always : null,
    );
  }

  @override
  InputDecoration getInputDateDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory,
        disabled, readOnly, errorMessage);
  }

  @override
  InputDecoration getInputDateTimeDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory,
        disabled, readOnly, errorMessage);
  }

  @override
  InputDecoration getInputLinkDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory,
        disabled, readOnly, errorMessage);
  }

  @override
  InputDecoration getInputNumericDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory,
        disabled, readOnly, errorMessage);
  }

  @override
  InputDecoration getInputComboboxDecoration(
      ThemeData theme,
      String label,
      Icon prefixIcon,
      Widget suffixIcon,
      bool mandatory,
      bool disabled,
      bool readOnly,
      String errorMessage) {
    return getInputDecoration(theme, label, prefixIcon, suffixIcon, mandatory,
        disabled, readOnly, errorMessage);
  }

  @override
  TextStyle getBreadcrumbItemTextStyle(ThemeData theme) {
    return theme.textTheme.headline6.copyWith(fontSize: 16.0);
  }

  @override
  TextStyle getBreadcrumbTitleTextStyle(ThemeData theme) {
    return theme.textTheme.headline4;
  }

  @override
  TextStyle getTableHeaderTextStyle(ThemeData theme) {
    return theme.textTheme.headline4
        .copyWith(fontSize: 16.0, fontWeight: FontWeight.w600);
  }

  @override
  TextStyle getSwitchTextStyle(
      ThemeData theme, bool disabled, bool readOnly, String errorMessage) {
    return theme.textTheme.subtitle1.copyWith(
      fontWeight: errorMessage != null ? FontWeight.w600 : FontWeight.w600,
      fontSize: 16.0,
      color: errorMessage != null
          ? theme.errorColor
          : disabled
              ? theme.disabledColor
              : null,
    );
  }

  @override
  TextStyle getRadioTextStyle(
      ThemeData theme, bool disabled, bool readOnly, String errorMessage) {
    return theme.textTheme.subtitle1.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      color: errorMessage != null
          ? theme.errorColor
          : disabled
              ? theme.disabledColor
              : null,
    );
  }

  @override
  TextStyle getAppNameTextStyle(ThemeData theme) {
    return theme.textTheme.headline6.copyWith(fontWeight: FontWeight.w900);
  }

  @override
  TextStyle getSloganTextStyle(ThemeData theme) {
    return theme.textTheme.bodyText1.copyWith(
      fontWeight: FontWeight.w300,
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
  TextStyle getLabelTextStyle(ThemeData theme) {
    return theme.textTheme.subtitle1
        .copyWith(fontWeight: FontWeight.w700, fontSize: 25);
  }

  @override
  TextStyle getTitleTextStyle(ThemeData theme) {
    return theme.textTheme.headline1;
  }

  @override
  TextStyle getRowCounterTextStyle(ThemeData theme) {
    return theme.textTheme.caption
        .copyWith(color: theme.colorScheme.primaryVariant);
  }

  @override
  MaterialStateProperty<Color> getRowColor(
      ThemeData theme, int index, bool inCard) {
    return MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
      /// All rows will have the same selected color.
      if (states.contains(MaterialState.selected)) {
        return theme.colorScheme.primary.withOpacity(0.08);
      }

      /// Even rows will have a grey color.
      if (index % 2 == 0) {
        return inCard ? theme.backgroundColor : theme.cardColor;
      }
      return inCard ? theme.cardColor : theme.backgroundColor;
    });
  }
}
