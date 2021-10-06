import 'dart:convert';

class VendasModel {
  final double vendasHoje;
  final double vendasMes;
  final double projecaoVendas;

  VendasModel({
    this.vendasHoje = 0.00,
    this.vendasMes = 0.00,
    this.projecaoVendas = 0.00,
  });

  VendasModel copyWith({
    double? vendasHoje,
    double? vendasMes,
    double? projecaoVendas,
  }) {
    return VendasModel(
      vendasHoje: vendasHoje ?? this.vendasHoje,
      vendasMes: vendasMes ?? this.vendasMes,
      projecaoVendas: projecaoVendas ?? this.projecaoVendas,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vendasHoje': vendasHoje,
      'vendasMes': vendasMes,
      'projecaoVendas': projecaoVendas,
    };
  }

  factory VendasModel.fromMap(Map<String, dynamic> map) {
    return VendasModel(
      vendasHoje: map['vendasHoje'] ?? 0.00,
      vendasMes: map['vendasMes'] ?? 0.00,
      projecaoVendas: map['projecaoVendas'] ?? 0.00,
    );
  }

  String toJson() => json.encode(toMap());

  factory VendasModel.fromJson(String source) =>
      VendasModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'VendasModel(vendasHoje: $vendasHoje, vendasMes: $vendasMes, projecaoVendas: $projecaoVendas)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VendasModel &&
        other.vendasHoje == vendasHoje &&
        other.vendasMes == vendasMes &&
        other.projecaoVendas == projecaoVendas;
  }

  @override
  int get hashCode =>
      vendasHoje.hashCode ^ vendasMes.hashCode ^ projecaoVendas.hashCode;
}
