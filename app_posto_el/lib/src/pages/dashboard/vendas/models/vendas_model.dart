import 'dart:convert';

class VendasModel {
  final int local;
  final double vlrTotal;
  final double qtdTotal;
  final DateTime? data;

  VendasModel({
    this.local = 0,
    this.vlrTotal = 0.00,
    this.qtdTotal = 0.00,
    this.data,
  });

  VendasModel copyWith({
    int? local,
    double? vlrTotal,
    double? qtdTotal,
    DateTime? data,
  }) {
    return VendasModel(
      local: local ?? this.local,
      vlrTotal: vlrTotal ?? this.vlrTotal,
      qtdTotal: qtdTotal ?? this.qtdTotal,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'local': local,
      'vlrTotal': vlrTotal,
      'qtdTotal': qtdTotal,
      'data': data,
    };
  }

  factory VendasModel.fromMap(Map<String, dynamic> map) {
    return VendasModel(
      local: map['local'] ?? 0,
      vlrTotal: double.tryParse(map['vlrTotal'].toString()) ?? 0.00,
      qtdTotal: double.tryParse(map['qtdTotal'].toString()) ?? 0.00,
      data: DateTime.parse(map['data'] ?? DateTime.now().toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory VendasModel.fromJson(String source) =>
      VendasModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'VendasModel(local: $local, vlrTotal: $vlrTotal, qtdTotal: $qtdTotal, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VendasModel &&
        other.local == local &&
        other.vlrTotal == vlrTotal &&
        other.qtdTotal == qtdTotal &&
        other.data == data;
  }

  @override
  int get hashCode =>
      local.hashCode ^ vlrTotal.hashCode ^ qtdTotal.hashCode ^ data.hashCode;
}
