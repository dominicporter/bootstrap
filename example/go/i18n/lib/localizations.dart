import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

part 'localizations.g.dart';

@SheetLocalization()
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.languages.containsKey(locale);
  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class TextLabel {
  const TextLabel({this.key, this.en});
  final String key;
  final String en;
  String label(BuildContext context) {
    final labels = AppLocalizations.of(context);
    if (labels.label.containsKey(key)) {
      return labels.label[key];
    } else {
      return en;
    }
  }
}
