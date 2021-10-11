import 'dart:convert';

class VendasModel {
  final int ID;
  final double VLR_TOTAL;
  final DateTime? DATA;

  VendasModel({
    this.ID = 0,
    this.VLR_TOTAL = 0.00,
    this.DATA,
  });

  VendasModel copyWith({
    int? ID,
    double? VLR_TOTAL,
    DateTime? data,
  }) {
    return VendasModel(
      ID: ID ?? this.ID,
      VLR_TOTAL: VLR_TOTAL ?? this.VLR_TOTAL,
      DATA: data ?? this.DATA,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'VLR_TOTAL': VLR_TOTAL,
      'DATA': DATA,
    };
  }

  factory VendasModel.fromMap(Map<String, dynamic> map) {
    return VendasModel(
      ID: map['ID'] ?? 0,
      VLR_TOTAL: map['VLR_TOTAL'] ?? 0.00,
      DATA: DateTime.parse(map['DATA'] ?? DateTime.now().toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory VendasModel.fromJson(String source) =>
      VendasModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'VendasModel(ID: $ID, VLR_TOTAL: $VLR_TOTAL, data: $DATA)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VendasModel &&
        other.ID == ID &&
        other.VLR_TOTAL == VLR_TOTAL &&
        other.DATA == DATA;
  }

  @override
  int get hashCode => ID.hashCode ^ VLR_TOTAL.hashCode ^ DATA.hashCode;
}
