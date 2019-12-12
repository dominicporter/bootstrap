// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizations.dart';

// **************************************************************************
// SheetLocalizationGenerator
// **************************************************************************

class AppLocalizations {
  AppLocalizations(this.locale) : this.labels = languages[locale];

  final Locale locale;

  static final Map<Locale, AppLocalizations_Labels> languages = {
    Locale.fromSubtags(languageCode: "en"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "Monday",
          tuesday: "Tuesday",
          wednesday: "Wednesday",
          thursday: "Thursday",
          friday: "Friday",
          saturday: "Saturday",
          sunday: "Sunday",
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: "January",
          february: "February",
          march: "March",
          april: "April",
        ),
      ),
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstName}) => "Hello ${firstName}",
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "Mr ${lastName}";
          if (condition == Gender.female) return "Mrs ${lastName}";
          throw Exception();
        },
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.zero) return "man";
          if (condition == Plural.one) return "man";
          if (condition == Plural.multiple) return "men";
          throw Exception();
        },
      ),
      login: AppLocalizations_Labels_Login(
        signIn: "Sign In",
        getStarted: "Get Started",
      ),
      home: AppLocalizations_Labels_Home(
        news: "News",
        chat: "Chats",
        enrollments: "Enrollments",
        title: "Title",
        tltle1: "Data",
      ),
    ),
    Locale.fromSubtags(languageCode: "fr"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "Lundi",
          tuesday: "Mardi",
          wednesday: "Mercredi",
          thursday: "Jeudi",
          friday: "Vendredi",
          saturday: "samedi",
          sunday: "dimanche",
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: "janvier",
          february: "février",
          march: "Mars",
          april: "avril",
        ),
      ),
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstName}) => "Bonjour ${firstName}",
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "M. ${lastName}";
          if (condition == Gender.female) return "Mme ${lastName}";
          throw Exception();
        },
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.zero) return "homme";
          if (condition == Plural.one) return "homme";
          if (condition == Plural.multiple) return "Hommes";
          throw Exception();
        },
      ),
      login: AppLocalizations_Labels_Login(
        signIn: "Se connecter",
        getStarted: "Commencer",
      ),
      home: AppLocalizations_Labels_Home(
        news: "Nouvelles",
        chat: "chats",
        enrollments: "Les inscriptions",
        title: "Titre",
        tltle1: "Les données",
      ),
    ),
    Locale.fromSubtags(languageCode: "zh"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "星期一",
          tuesday: "星期二",
          wednesday: "星期三",
          thursday: "星期四",
          friday: "星期五",
          saturday: "星期六",
          sunday: "星期日",
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: "一月",
          february: "二月",
          march: "游行",
          april: "四月",
        ),
      ),
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstName}) => "您好${firstName}您好",
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "先生{{姓氏}}";
          if (condition == Gender.female) return "太太{{姓氏}}";
          throw Exception();
        },
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.zero) return "男人";
          if (condition == Plural.one) return "男人";
          if (condition == Plural.multiple) return "男人";
          throw Exception();
        },
      ),
      login: AppLocalizations_Labels_Login(
        signIn: "登入",
        getStarted: "入门",
      ),
      home: AppLocalizations_Labels_Home(
        news: "新闻",
        chat: "聊天",
        enrollments: "扩招",
        title: "标题",
        tltle1: "数据",
      ),
    ),
    Locale.fromSubtags(languageCode: "de"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "Montag",
          tuesday: "Dienstag",
          wednesday: "Mittwoch",
          thursday: "Donnerstag",
          friday: "Freitag",
          saturday: "Samstag",
          sunday: "Sonntag",
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: "Januar",
          february: "Februar",
          march: "März",
          april: "April",
        ),
      ),
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstName}) => "Hallo ${firstName}",
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "Herr ${lastName}";
          if (condition == Gender.female) return "Frau ${lastName}";
          throw Exception();
        },
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.zero) return "Mann";
          if (condition == Plural.one) return "Mann";
          if (condition == Plural.multiple) return "Männer";
          throw Exception();
        },
      ),
      login: AppLocalizations_Labels_Login(
        signIn: "Anmelden",
        getStarted: "Loslegen",
      ),
      home: AppLocalizations_Labels_Home(
        news: "Nachrichten",
        chat: "Chats",
        enrollments: "Einschreibungen",
        title: "Titel",
        tltle1: "Daten",
      ),
    ),
    Locale.fromSubtags(languageCode: "es"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "lunes",
          tuesday: "martes",
          wednesday: "miércoles",
          thursday: "jueves",
          friday: "viernes",
          saturday: "sábado",
          sunday: "domingo",
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: "enero",
          february: "febrero",
          march: "marzo",
          april: "abril",
        ),
      ),
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstName}) => "Hola ${firstName}",
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "Mr {{}} apellidos";
          if (condition == Gender.female) return "Sra {{}} apellidos";
          throw Exception();
        },
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.zero) return "hombre";
          if (condition == Plural.one) return "hombre";
          if (condition == Plural.multiple) return "hombres";
          throw Exception();
        },
      ),
      login: AppLocalizations_Labels_Login(
        signIn: "Registrarse",
        getStarted: "Empezar",
      ),
      home: AppLocalizations_Labels_Home(
        news: "Noticias",
        chat: "chats",
        enrollments: "Las inscripciones",
        title: "Título",
        tltle1: "Datos",
      ),
    ),
    Locale.fromSubtags(languageCode: "he"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: "יום שני",
          tuesday: "יום שלישי",
          wednesday: "יום רביעי",
          thursday: "יום חמישי",
          friday: "יום שישי",
          saturday: "יום שבת",
          sunday: "יום ראשון",
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: "ינואר",
          february: "פברואר",
          march: "מרץ",
          april: "אפריל",
        ),
      ),
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstName}) => "שלום ${firstName}",
        contact: (condition, {lastName}) {
          if (condition == Gender.male) return "מר ${lastName}";
          if (condition == Gender.female) return "גברת ${lastName}";
          throw Exception();
        },
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.zero) return "איש";
          if (condition == Plural.one) return "איש";
          if (condition == Plural.multiple) return "גברים";
          throw Exception();
        },
      ),
      login: AppLocalizations_Labels_Login(
        signIn: "היכנס",
        getStarted: "להתחיל",
      ),
      home: AppLocalizations_Labels_Home(
        news: "חדשות",
        chat: "צ'אטים",
        enrollments: "הרשמות",
        title: "כותרת",
        tltle1: "נתונים",
      ),
    ),
  };

  final AppLocalizations_Labels labels;

  static AppLocalizations_Labels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)?.labels;
}

enum Gender {
  male,
  female,
}
enum Plural {
  zero,
  one,
  multiple,
}

class AppLocalizations_Labels_Dates_Weekday {
  const AppLocalizations_Labels_Dates_Weekday(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  final String monday;

  final String tuesday;

  final String wednesday;

  final String thursday;

  final String friday;

  final String saturday;

  final String sunday;
}

class AppLocalizations_Labels_Dates_Month {
  const AppLocalizations_Labels_Dates_Month(
      {this.january, this.february, this.march, this.april});

  final String january;

  final String february;

  final String march;

  final String april;
}

class AppLocalizations_Labels_Dates {
  const AppLocalizations_Labels_Dates({this.weekday, this.month});

  final AppLocalizations_Labels_Dates_Weekday weekday;

  final AppLocalizations_Labels_Dates_Month month;
}

typedef String AppLocalizations_Labels_Templated_hello(
    {@required String firstName});
typedef String AppLocalizations_Labels_Templated_contact(Gender condition,
    {@required String lastName});

class AppLocalizations_Labels_Templated {
  const AppLocalizations_Labels_Templated(
      {AppLocalizations_Labels_Templated_hello hello,
      AppLocalizations_Labels_Templated_contact contact})
      : this._hello = hello,
        this._contact = contact;

  final AppLocalizations_Labels_Templated_hello _hello;

  final AppLocalizations_Labels_Templated_contact _contact;

  String hello({@required String firstName}) => this._hello(
        firstName: firstName,
      );
  String contact(Gender condition, {@required String lastName}) =>
      this._contact(
        condition,
        lastName: lastName,
      );
}

typedef String AppLocalizations_Labels_Plurals_man(Plural condition);

class AppLocalizations_Labels_Plurals {
  const AppLocalizations_Labels_Plurals(
      {AppLocalizations_Labels_Plurals_man man})
      : this._man = man;

  final AppLocalizations_Labels_Plurals_man _man;

  String man(Plural condition) => this._man(
        condition,
      );
}

class AppLocalizations_Labels_Login {
  const AppLocalizations_Labels_Login({this.signIn, this.getStarted});

  final String signIn;

  final String getStarted;
}

class AppLocalizations_Labels_Home {
  const AppLocalizations_Labels_Home(
      {this.news, this.chat, this.enrollments, this.title, this.tltle1});

  final String news;

  final String chat;

  final String enrollments;

  final String title;

  final String tltle1;
}

class AppLocalizations_Labels {
  const AppLocalizations_Labels(
      {this.dates, this.templated, this.plurals, this.login, this.home});

  final AppLocalizations_Labels_Dates dates;

  final AppLocalizations_Labels_Templated templated;

  final AppLocalizations_Labels_Plurals plurals;

  final AppLocalizations_Labels_Login login;

  final AppLocalizations_Labels_Home home;
}
