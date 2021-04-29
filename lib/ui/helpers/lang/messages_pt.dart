import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'pt';

  final messages = _notInlinedMessages(_notInlinedMessages);

  // TODO: Continuar a traducao. Possibilidade para novas linguagens

  static _notInlinedMessages(_) => <String, Function>{
        "titulo": MessageLookupByLibrary.simpleMessage("Mesa News"),
        "nao_ha_conexao_com_a_internet": MessageLookupByLibrary.simpleMessage("Não há conexão com a internet"),
        "verifique_conexao":
            MessageLookupByLibrary.simpleMessage("Verifique os dados móveis ou o Wi-Fi\ne tente novamente"),
        "atualizar": MessageLookupByLibrary.simpleMessage("Atualizar"),
      };
}
