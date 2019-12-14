import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

class DartBuilder {
  LibraryBuilder _library;

  String build(Map<String, Map<String, String>> list) {
    _library = LibraryBuilder();

    _library.body.add(_createLocalization(list));
    _library.body.add(_createLabels());

    // Code generation
    final emitter = DartEmitter();
    final source = '${_library.build().accept(emitter)}';
    return DartFormatter().format(source);
  }

  Class _createLocalization(Map<String, Map<String, String>> list) {
    final result = ClassBuilder()..name = 'AppLocalizations';

    var constructor = ConstructorBuilder();

    result.fields.add(Field((b) => b
      ..name = "locale"
      ..modifier = FieldModifier.final$
      ..type = refer("Locale")));

    constructor.requiredParameters.add(Parameter((p) => p
      ..name = "locale"
      ..toThis = true));

    constructor.initializers.add(Code("this.labels = languages[locale]"));

    result.fields.add(Field((b) => b
      ..name = "languages"
      ..static = true
      ..assignment = _createLanguageMap(list)
      ..modifier = FieldModifier.final$
      ..type = refer("Map<Locale, Label>")));

    result.fields.add(Field((b) => b
      ..name = "labels"
      ..modifier = FieldModifier.final$
      ..type = refer('Label')));

    result.methods.add(Method((b) => b
      ..name = "of"
      ..lambda = true
      ..static = true
      ..returns = refer('Label')
      ..body = Code(
          "Localizations.of<AppLocalizations>(context, AppLocalizations)?.labels")
      ..requiredParameters.add(Parameter((b) => b
        ..name = "context"
        ..type = refer("BuildContext")))));

    result.constructors.add(constructor.build());

    return result.build();
  }

  Code _createLanguageMap(Map<String, Map<String, String>> list) {
    final result = StringBuffer();

    result.write("{");

    for (var languageCode in list.keys) {
      final code = _createSectionInstance(list[languageCode]);
      var key = "Locale.fromSubtags(languageCode: \"$languageCode\"";
      key += ")";
      result.write(key + " : Label(<String, String>{" + code + "},),");
    }

    result.write("}");

    return Code(result.toString());
  }

  String _createSectionInstance(Map<String, String> section) {
    final result = StringBuffer();
    section.keys.forEach((String key) {
      result.write('"$key"');
      result.write(":");
      result.write('"${section[key]}"');
      result.write(",");
    });

    //result.write("}");

    return result.toString();
  }
}

Class _createLabels() {
  final result = ClassBuilder()..name = 'Label';

  var constructor = ConstructorBuilder()..constant = true;

  result.fields.add(Field((b) => b
    ..name = "label"
    ..modifier = FieldModifier.final$
    ..type = refer("Map<String, String>")));

  constructor.requiredParameters.add(Parameter((p) => p
    ..named = true
    ..annotations
    ..name = "label"
    ..toThis = true));

  result.constructors.add(constructor.build());

  return result.build();
}
