import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'
    show
        debugDumpRenderTree,
        debugDumpLayerTree,
        debugDumpSemanticsTree,
        DebugSemanticsDumpOrder;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_model/i18n.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import './widget/bottom_nav.dart';
import './widget/drawer.dart';
import 'localizations.dart';
import './data/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale;

  @override
  void initState() {
    _currentLocale = AppLocalizations.languages.keys.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        locale: this._currentLocale,
        onLocaleChanged: (locale) {
          print(_currentLocale);
          print(locale);
          if (this._currentLocale != locale) {
            this.setState(() => this._currentLocale = locale);
          }
        },
      ),
      locale: _currentLocale,
      localizationsDelegates: [
        const AppLocalizationsDelegate(), // <- Your custom delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales:
          AppLocalizations.languages.keys.toList(), // <- Supported locales
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.locale, this.onLocaleChanged})
      : super(key: key);
  final String title;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @IEighteenn(key: 'test', en: 'en test')
  @IEighteenn(key: 'test1', en: 'en test1')
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<Locale>(
          key: Key("Picker"),
          value: widget.locale,
          items: AppLocalizations.languages.keys.map((locale) {
            return DropdownMenuItem<Locale>(
              value: locale,
              child: Text(
                locale.toString(),
                // style: TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: widget.onLocaleChanged,
        ),
      ),
      body: ResponsiveListScaffold.builder(
        appBar: AppBar(
          title: Text(TextLabel(key: 'home.title', en: 'Title').label(context)),
        ),
        bottomNavigationBar: MediaQuery.of(context).size.width >= 720.0
            ? null
            : BottomNav(
                index: 0,
              ),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              // Shows that if a label is not available, it returns the en label
              Text(TextLabel(key: 'test', en: 'Test').label(context)),
              const Divider()
            ]),
          ),
        ],
        detailBuilder: (BuildContext context, int index, bool flag) {
          final i = emails[index];
          return DetailsScreen(
            appBar: AppBar(
              title: Text(i.title),
              elevation: 0.0,
              actions: [
                IconButton(
                  icon: Icon(Icons.archive),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    // setState(() {
                    //   _emails.removeAt(index);
                    // });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.mail_outline),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
            body: ListTile(
              leading: Text(i.avatar),
              title: Text(i.title),
              subtitle: Text(i.description),
            ),
          );
        },
        tabletSideMenu: (kIsWeb ||
                debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia)
            ? Flexible(
                flex: 0,
                child: LeftDrawer(
                  index: 0,
                ),
                fit: FlexFit.tight,
              )
            : null,
        tabletFlexListView: 4,
        nullItems: const Center(child: CircularProgressIndicator()),
        emptyItems: const Center(child: CircularProgressIndicator()),
        itemCount: emails.length,
        itemBuilder: (BuildContext context, int index) {
          final i = emails[index];
          return ListTile(
            leading: Text(i.avatar),
            title: Text(i.title),
            subtitle: Text(i.description),
          );
        },
      ),
    );
  }
}
