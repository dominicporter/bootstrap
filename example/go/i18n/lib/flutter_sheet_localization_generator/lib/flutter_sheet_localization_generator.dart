import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

import 'src/builder.dart';
import 'src/localizations.dart';

class SheetLocalizationGenerator
    extends GeneratorForAnnotation<SheetLocalization> {
  const SheetLocalizationGenerator();

  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (element is! ClassElement) {
      final name = element.name;
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the SheetLocalization annotation from `$name`.',
          element: element);
    }

    if (!element.name.endsWith("Delegate")) {
      final name = element.name;
      throw InvalidGenerationSourceError(
          'Generator for target `$name` should have a name that ends with `Delegate`.',
          todo:
              'Refactor the class name `$name` for a name ending with `Delegate` (example: `${name}Delegate`).',
          element: element);
    }

    final classElement = element as ClassElement;

    final localizationDelegateSupertype = classElement.allSupertypes
        .firstWhere((x) => x.name == "LocalizationsDelegate");
    if (localizationDelegateSupertype != null) {
      var localizations = await loadFile();

      localizations = localizations.copyWith(
          name: classElement.name.replaceAll("Delegate", ""));

      final builder = DartBuilder();
      return builder.build(localizations);
    }
    throw InvalidGenerationSourceError(
        'Supertype aren\'t valid : [${classElement.allSupertypes.join(', ')}].',
        todo:
            'Define only one supertype of type LocalizationsDelegate<LOCALIZATION_CLASS_NAME>.',
        element: element);
  }

  Future<Localizations> loadFile() async {
    final Map<String, dynamic> iterable =
        await File('assets/labels/labels.json')
            .readAsString()
            .then((String fileContent) => json.decode(fileContent));
    final Map<String, Map<String, String>> list =
        <String, Map<String, String>>{};
    for (String key in iterable.keys) {
      final Map<String, String> map = Map<String, String>.from(iterable[key]);
      list[key] = map;
    }
    return await parse(list);
  }

  Future<Localizations> parse(Map<String, Map<String, String>> input) async {
    final Localizations result =
        Localizations(supportedLanguageCodes: input.keys.toList());

    for (String path in input['en'].keys) {
      final List<Translation> translations = <Translation>[];
      for (String lang in input.keys) {
        translations.add(Translation(lang, input[lang][path]));
      }
      result.insert(path, translations);
    }

    return result;
  }
}
