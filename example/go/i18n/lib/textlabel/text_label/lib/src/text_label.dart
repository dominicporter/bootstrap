import 'package:meta/meta.dart';

class TextLabel {
  const TextLabel({
    @required this.label,
    @required this.en,
  })  : assert(label != ''),
        assert(en != '');
  final String label;
  final String en;
}
