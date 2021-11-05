import 'dart:convert';

class ModelLocais {
  final int id;
  final String descricao;
  ModelLocais({
    required this.id,
    required this.descricao,
  });

  ModelLocais copyWith({
    int? id,
    String? descricao,
  }) {
    return ModelLocais(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
    };
  }

  factory ModelLocais.fromMap(Map<String, dynamic> map) {
    return ModelLocais(
      id: map['id'] ?? 1,
      descricao: map['descricao'] ?? 'Empresa Teste',
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelLocais.fromJson(String source) =>
      ModelLocais.fromMap(json.decode(source));

  @override
  String toString() => 'ModelLocais(id: $id, descricao: $descricao)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModelLocais &&
        other.id == id &&
        other.descricao == descricao;
  }

  @override
  int get hashCode => id.hashCode ^ descricao.hashCode;
}
