import 'package:html/dom.dart' as dom;

extension NumberParsing on dom.Element {
  double? tryParseDouble() {
    return double.tryParse(text);
  }

  double get doubleValue => tryParseDouble() ?? 0.0;
}