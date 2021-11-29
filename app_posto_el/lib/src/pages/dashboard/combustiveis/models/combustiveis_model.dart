import 'dart:convert';

class CombustiveisModel {
  final double volume;
  final int capacidade;
  final int tanque;
  final int ccusto;
  final String descricao;
  final String descResumida;
  CombustiveisModel({
    this.volume = 0.00,
    this.capacidade = 0,
    this.tanque = 0,
    this.ccusto = 0,
    this.descricao = '',
    this.descResumida = '',
  });

  CombustiveisModel copyWith({
    double? volume,
    int? capacidade,
    int? tanque,
    int? ccusto,
    String? descricao,
    String? descResumida,
  }) {
    return CombustiveisModel(
      volume: volume ?? this.volume,
      capacidade: capacidade ?? this.capacidade,
      tanque: tanque ?? this.tanque,
      ccusto: ccusto ?? this.ccusto,
      descricao: descricao ?? this.descricao,
      descResumida: descResumida ?? this.descResumida,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'volume': volume,
      'capacidade': capacidade,
      'tanque': tanque,
      'ccusto': ccusto,
      'descricao': descricao,
      'descResumida': descResumida,
    };
  }

  factory CombustiveisModel.fromMap(Map<String, dynamic> map) {
    return CombustiveisModel(
      volume: double.tryParse(map['volume'].toString()) ?? 0.0,
      capacidade: map['capacidade'] ?? 0,
      tanque: map['tanque'] ?? 0,
      ccusto: map['ccusto'] ?? 0,
      descricao: map['descricao'] ?? '',
      descResumida: map['descResumida'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CombustiveisModel.fromJson(String source) =>
      CombustiveisModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CombustiveisModel(volume: $volume, capacidade: $capacidade, tanque: $tanque, ccusto: $ccusto, descricao: $descricao, descResumida: $descResumida)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CombustiveisModel &&
        other.volume == volume &&
        other.capacidade == capacidade &&
        other.tanque == tanque &&
        other.ccusto == ccusto &&
        other.descricao == descricao &&
        other.descResumida == descResumida;
  }

  @override
  int get hashCode {
    return volume.hashCode ^
        capacidade.hashCode ^
        tanque.hashCode ^
        ccusto.hashCode ^
        descricao.hashCode ^
        descResumida.hashCode;
  }
}
