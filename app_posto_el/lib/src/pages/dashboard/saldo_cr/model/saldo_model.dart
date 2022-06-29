import 'dart:convert';

class SaldoModel {
  int? codCliente;
  String? nomeCliente;
  int? local;
  double? saldoAtual;
  SaldoModel({
    this.codCliente = 0,
    this.nomeCliente = '',
    this.local = 0,
    this.saldoAtual = 0.0,
  });

  SaldoModel copyWith({
    int? codCliente,
    String? nomeCliente,
    int? local,
    double? saldoAtual,
  }) {
    return SaldoModel(
      codCliente: codCliente ?? this.codCliente,
      nomeCliente: nomeCliente ?? this.nomeCliente,
      local: local ?? this.local,
      saldoAtual: saldoAtual ?? this.saldoAtual,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codCliente': codCliente,
      'nomeCliente': nomeCliente,
      'local': local,
      'saldoAtual': saldoAtual,
    };
  }

  factory SaldoModel.fromMap(Map<String, dynamic> map) {
    return SaldoModel(
      codCliente: map['COD_CLIENTE'] ?? 0,
      nomeCliente: map['NOME_CLIENTE'] ?? '',
      local: map['LOCAL'] ?? 0,
      saldoAtual: double.tryParse(map['SALDO_ATUAL'].toString()) ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaldoModel.fromJson(String source) =>
      SaldoModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SaldoModel(codCliente: $codCliente, nomeCliente: $nomeCliente, local: $local saldoAtual: $saldoAtual)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaldoModel &&
        other.codCliente == codCliente &&
        other.nomeCliente == nomeCliente &&
        other.local == local &&
        other.saldoAtual == saldoAtual;
  }

  @override
  int get hashCode =>
      codCliente.hashCode ^
      nomeCliente.hashCode ^
      local.hashCode ^
      saldoAtual.hashCode;
}
