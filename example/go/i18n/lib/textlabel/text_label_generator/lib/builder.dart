import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import '../lib/src/text_label_generator.dart';

Builder textLabel(BuilderOptions options) =>
    SharedPartBuilder([TextLabelGenerator()], 'text_label');
