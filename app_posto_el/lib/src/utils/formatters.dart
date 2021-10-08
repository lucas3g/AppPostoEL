import 'package:intl/intl.dart';

class Formatters {}

extension MoneyDouble on double {
  String reais() {
    final format = NumberFormat.simpleCurrency(locale: 'pt_br');
    return format.format(this);
  }
}

extension DateTimeString on DateTime {
  String diaMes() {
    final format = DateFormat('d MMMM', 'pt_br');
    return format.format(this);
  }
}

extension DataString on DateTime {
  String AnoMesDia() {
    final format = DateFormat('yyyy-MM-dd');
    return format.format(this);
  }
}

extension DiaString on DateTime {
  String Dia() {
    final format = DateFormat('dd');
    return format.format(this);
  }
}