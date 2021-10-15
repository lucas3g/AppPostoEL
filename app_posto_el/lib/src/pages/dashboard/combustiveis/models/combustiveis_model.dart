import 'dart:convert';

class CombustiveisModel {
  final double VOLUME;
  final int CAPACIDADE;
  final int TANQUE;
  final int CCUSTO;
  final String DESCRICAO;
  CombustiveisModel({
    this.VOLUME = 0.00,
    this.CAPACIDADE = 0,
    this.TANQUE = 0,
    this.CCUSTO = 0,
    this.DESCRICAO = '',
  });

  CombustiveisModel copyWith({
    double? VOLUME,
    int? CAPACIDADE,
    int? TANQUE,
    int? CCUSTO,
    String? DESCRICAO,
  }) {
    return CombustiveisModel(
      VOLUME: VOLUME ?? this.VOLUME,
      CAPACIDADE: CAPACIDADE ?? this.CAPACIDADE,
      TANQUE: TANQUE ?? this.TANQUE,
      CCUSTO: CCUSTO ?? this.CCUSTO,
      DESCRICAO: DESCRICAO ?? this.DESCRICAO,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'VOLUME': VOLUME,
      'CAPACIDADE': CAPACIDADE,
      'TANQUE': TANQUE,
      'CCUSTO': CCUSTO,
      'DESCRICAO': DESCRICAO,
    };
  }

  factory CombustiveisModel.fromMap(Map<String, dynamic> map) {
    return CombustiveisModel(
      VOLUME: map['VOLUME'] ?? 0.00,
      CAPACIDADE: map['CAPACIDADE'] ?? 0,
      TANQUE: map['TANQUE'] ?? 0,
      CCUSTO: map['CCUSTO'] ?? 0,
      DESCRICAO: map['DESCRICAO'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CombustiveisModel.fromJson(String source) =>
      CombustiveisModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CombustiveisModel(VOLUME: $VOLUME, CAPACIDADE: $CAPACIDADE, TANQUE: $TANQUE, CCUSTO: $CCUSTO, DESCRICAO: $DESCRICAO)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CombustiveisModel &&
        other.VOLUME == VOLUME &&
        other.CAPACIDADE == CAPACIDADE &&
        other.TANQUE == TANQUE &&
        other.CCUSTO == CCUSTO &&
        other.DESCRICAO == DESCRICAO;
  }

  @override
  int get hashCode {
    return VOLUME.hashCode ^
        CAPACIDADE.hashCode ^
        TANQUE.hashCode ^
        CCUSTO.hashCode ^
        DESCRICAO.hashCode;
  }
}
