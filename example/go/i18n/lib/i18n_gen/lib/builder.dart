import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import './i18n_gen.dart';

Builder i18nGen(BuilderOptions options) =>
    SharedPartBuilder([I18nGenerator()], 'i18n_gen');
