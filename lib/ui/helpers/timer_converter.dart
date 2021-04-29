import 'package:intl/intl.dart';

enum TimeType { isSeconds, isMinutes, isHours, isDays, isYears }

class TimeConvert {
  static Map<String, dynamic> convertTimeStampToString(int millisecondsSinceEpoch, String language) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    Duration difference = DateTime.now().difference(date);
    Map<String, dynamic> resultTimeDate = {};

    if (difference.inSeconds < 60) {
      resultTimeDate["time"] = difference.inSeconds;
      resultTimeDate["type"] = TimeType.isSeconds;

      switch (language) {
        case "pt":
          resultTimeDate["msg"] = "agora";
          break;
        case "es":
          resultTimeDate["msg"] = "ahora";
          break;
        default:
          resultTimeDate["msg"] = "now";
      }
      return resultTimeDate;
    } else if (difference.inMinutes < 60) {
      resultTimeDate["time"] = difference.inMinutes;
      resultTimeDate["type"] = TimeType.isMinutes;

      switch (language) {
        case "pt":
          resultTimeDate["msg"] = "${difference.inMinutes} ${difference.inMinutes <= 1 ? 'minuto' : 'minutos'} atrás";
          break;
        case "es":
          resultTimeDate["msg"] = "${difference.inMinutes} ${difference.inMinutes <= 1 ? 'minuto' : 'minutos'} antes";
          break;
        default:
          resultTimeDate["msg"] = "${difference.inMinutes} ${difference.inMinutes <= 1 ? 'minute' : 'minutes'} ago";
      }
      return resultTimeDate;
    } else if (difference.inHours < 24) {
      resultTimeDate["time"] = difference.inHours;
      resultTimeDate["type"] = TimeType.isHours;

      switch (language) {
        case "pt":
          resultTimeDate["msg"] = "${difference.inHours} ${difference.inHours <= 1 ? 'hora' : 'horas'} atrás";
          break;
        case "es":
          resultTimeDate["msg"] = "${difference.inHours} ${difference.inHours <= 1 ? 'hora' : 'horas'} antes";
          break;
        default:
          resultTimeDate["msg"] = "${difference.inHours} ${difference.inHours <= 1 ? 'hour' : 'hours'} ago";
      }
      return resultTimeDate;
    } else if (difference.inDays < 30) {
      resultTimeDate["time"] = difference.inDays;
      resultTimeDate["type"] = TimeType.isDays;

      switch (language) {
        case "pt":
          resultTimeDate["msg"] = "${difference.inDays} ${difference.inDays <= 1 ? 'dia' : 'dias'} atrás";
          break;
        case "es":
          resultTimeDate["msg"] = "${difference.inDays} ${difference.inDays <= 1 ? 'dia' : 'dias'} antes";
          break;
        default:
          resultTimeDate["msg"] = "${difference.inDays} ${difference.inDays <= 1 ? 'day' : 'days'} ago";
      }
      return resultTimeDate;
    } else {
      resultTimeDate["time"] = difference.inDays / 365;
      resultTimeDate["type"] = TimeType.isYears;

      if (date.year == DateTime.now().year) {
        switch (language) {
          case "pt":
            String formatMonth = DateFormat("MMMM", "pt").format(date);
            resultTimeDate["msg"] = "${date.day} de ${formatMonth.toLowerCase()}";
            break;
          case "es":
            String formatMonth = DateFormat("MMMM", "es").format(date);
            resultTimeDate["msg"] = "${date.day} de ${formatMonth.toLowerCase()}";
            break;
          default:
            String formatMonth = DateFormat("MMMM", "en").format(date);
            resultTimeDate["msg"] = "${formatMonth.toLowerCase()} ${date.day}";
        }
        return resultTimeDate;
      } else {
        switch (language) {
          case "pt":
            String formatMonth = DateFormat("MMMM", "pt").format(date);
            String formatYear = DateFormat("yyyy", "pt").format(date);

            resultTimeDate["msg"] = "${date.day} de ${formatMonth.toLowerCase()} de $formatYear";
            break;
          case "es":
            String formatMonth = DateFormat("MMMM", "es").format(date);
            String formatYear = DateFormat("yyyy", "es").format(date);

            resultTimeDate["msg"] = "${date.day} de ${formatMonth.toLowerCase()} de $formatYear";
            break;
          default:
            String formatMonth = DateFormat("MMMM", "en").format(date);
            String formatYear = DateFormat("yyyy", "en").format(date);

            resultTimeDate["msg"] = "${formatMonth.toLowerCase()} ${date.day}, $formatYear";
        }
        return resultTimeDate;
      }
    }
  }
}