import 'dart:convert';

class VolumesModel {
  final int ID;
  final double QTD_TOTAL;
  final DateTime? DATA;

  VolumesModel({
    this.ID = 0,
    this.QTD_TOTAL = 0.00,
    this.DATA,
  });

  VolumesModel copyWith({
    int? ID,
    double? QTD_TOTAL,
    DateTime? data,
  }) {
    return VolumesModel(
      ID: ID ?? this.ID,
      QTD_TOTAL: QTD_TOTAL ?? this.QTD_TOTAL,
      DATA: data ?? this.DATA,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'QTD_TOTAL': QTD_TOTAL,
      'DATA': DATA,
    };
  }

  factory VolumesModel.fromMap(Map<String, dynamic> map) {
    return VolumesModel(
      ID: map['ID'] ?? 0,
      QTD_TOTAL: map['QTD_TOTAL'] ?? 0.00,
      DATA: DateTime.parse(map['DATA'] ?? DateTime.now().toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory VolumesModel.fromJson(String source) =>
      VolumesModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'VolumesModel(ID: $ID, QTD_TOTAL: $QTD_TOTAL, data: $DATA)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VolumesModel &&
        other.ID == ID &&
        other.QTD_TOTAL == QTD_TOTAL &&
        other.DATA == DATA;
  }

  @override
  int get hashCode => ID.hashCode ^ QTD_TOTAL.hashCode ^ DATA.hashCode;
}
