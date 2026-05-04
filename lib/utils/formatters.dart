import 'package:intl/intl.dart';

// Create a single, private instance of the formatter.
// This prevents recreating it on every single frame during a counter animation.
// Using 'decimalPattern' adds thousands separators if numbers get big.
final NumberFormat _arabicFormatter = NumberFormat.decimalPattern('ar_EG');

// Create the extension on 'num' (covers both int and double)
extension ArabicNumberExtension on num {
  String toArabic() {
    return _arabicFormatter.format(this);
  }
}
