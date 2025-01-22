part of 'extension.dart';

extension PhoneNumberFormatter on String {
  String toUzbekPhoneFormat() {
    final digits = replaceAll(RegExp(r'\D'), '');

    if (digits.length == 12 && digits.startsWith('998')) {
      final regionCode = digits.substring(3, 5);
      final mainPart = digits.substring(5);
      return '+998 ($regionCode) ${mainPart.substring(0, 3)}-${mainPart.substring(3, 5)}-${mainPart.substring(5)}';
    } else if (digits.length == 9) {
      final regionCode = digits.substring(0, 2);
      final mainPart = digits.substring(2);
      return '+998 ($regionCode) ${mainPart.substring(0, 3)}-${mainPart.substring(3, 5)}-${mainPart.substring(5)}';
    } else {
      return this;
    }
  }

  String calculateAge() {
    try {
      DateTime birthDate = DateTime.parse(this);
      DateTime today = DateTime.now();

      int age = today.year - birthDate.year;

      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return age.toString();
    } catch (e) {
      throw FormatException("Invalid date format. Use 'YYYY-MM-DD'.");
    }
  }
}
