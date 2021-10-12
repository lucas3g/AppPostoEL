import 'dart:convert';

class CombustiveisModel {
  final double VOLUME;
  final int CAPACIDADE;
  final int TANQUE;
  final int CCUSTO;
  CombustiveisModel({
    this.VOLUME = 0.00,
    this.CAPACIDADE = 0,
    this.TANQUE = 0,
    this.CCUSTO = 0,
  });

  CombustiveisModel copyWith({
    double? VOLUME,
    int? CAPACIDADE,
    int? TANQUE,
    int? CCUSTO,
  }) {
    return CombustiveisModel(
      VOLUME: VOLUME ?? this.VOLUME,
      CAPACIDADE: CAPACIDADE ?? this.CAPACIDADE,
      TANQUE: TANQUE ?? this.TANQUE,
      CCUSTO: CCUSTO ?? this.CCUSTO,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'VOLUME': VOLUME,
      'CAPACIDADE': CAPACIDADE,
      'TANQUE': TANQUE,
      'CCUSTO': CCUSTO,
    };
  }

  factory CombustiveisModel.fromMap(Map<String, dynamic> map) {
    return CombustiveisModel(
      VOLUME: map['VOLUME'] ?? 0.00,
      CAPACIDADE: map['CAPACIDADE'] ?? 0,
      TANQUE: map['TANQUE'] ?? 0,
      CCUSTO: map['CCUSTO'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CombustiveisModel.fromJson(String source) =>
      CombustiveisModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CombustiveisModel(VOLUME: $VOLUME, CAPACIDADE: $CAPACIDADE, TANQUE: $TANQUE, CCUSTO: $CCUSTO)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CombustiveisModel &&
        other.VOLUME == VOLUME &&
        other.CAPACIDADE == CAPACIDADE &&
        other.TANQUE == TANQUE &&
        other.CCUSTO == CCUSTO;
  }

  @override
  int get hashCode {
    return VOLUME.hashCode ^
        CAPACIDADE.hashCode ^
        TANQUE.hashCode ^
        CCUSTO.hashCode;
  }
}
