import '../../presentation/protocols/validation.dart';

class DateHelper {
  /*
    * Is valid date and format
    *
    * Format: dd/MM/yyyy
    * valid:
    *   01/12/1996
    * invalid:
    *   01/13/1996
    *
    * Format: MM/dd/yyyy
    * valid:
    *  12/01/1996
    * invalid
    *  13/01/1996
    * */
  String date;
  String format;

  DateHelper(this.date, {this.format = 'dd/MM/yyyy'});

  ValidationError isValidDateBirth(String date, String format) {
    if (date == null) return null;

    try {
      int day, month, year;

      //Get separator data  10/10/2020, 2020-10-10, 10.10.2020
      String separator = RegExp("([-/.])").firstMatch(date).group(0)[0];

      //Split by separator [mm, dd, yyyy]
      var frSplit = format.split(separator);
      //Split by separtor [10, 10, 2020]
      var dtSplit = date.split(separator);

      for (int i = 0; i < frSplit.length; i++) {
        var frm = frSplit[i].toLowerCase();
        var vl = dtSplit[i];

        if (frm == "dd")
          day = int.parse(vl);
        else if (frm == "mm")
          month = int.parse(vl);
        else if (frm == "yyyy") year = int.parse(vl);
      }

      //First date check
      //The dart does not throw an exception for invalid date.
      var now = DateTime.now();
      if (month > 12 ||
          month < 1 ||
          day < 1 ||
          day > daysInMonth(month, year) ||
          year < 1810 ||
          (year > now.year && day > now.day && month > now.month)) throw ValidationError.invalidField;

      return null;
    } catch (e) {
      return ValidationError.invalidField;
    }
  }

  int daysInMonth(int month, int year) {
    int days = 28 + (month + (month / 8).floor()) % 2 + 2 % month + 2 * (1 / month).floor();
    return (isLeapYear(year) && month == 2) ? 29 : days;
  }

  bool isLeapYear(int year) => ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0);
}
