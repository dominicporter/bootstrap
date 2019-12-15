import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'dart:io';
import 'package:i18n/i18n_model/lib/i18n.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

class I18nGenerator extends GeneratorForAnnotation<IEighteenn> {
  const I18nGenerator();

  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    print('here');
    if (element is! ClassElement) {
      final name = element.name;
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the SheetLocalization annotation from `$name`.',
          element: element);
    }

    final String key = annotation.objectValue.getField("key").toStringValue();
    final String en = annotation.objectValue.getField("en").toStringValue();
    print(key);
    return key + ',' + en;
  }

  Future<Map<String, Map<String, String>>> loadFile() async {
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
    return list;
  }
}
