import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import '../.././../text_label/lib/text_label.dart';

class TextLabelGenerator extends GeneratorForAnnotation<TextLabel> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    print(element.displayName);
    print(annotation.typeValue);
    print(buildStep.inputId);
    return "// Hey! Annotation found!";
  }
}
