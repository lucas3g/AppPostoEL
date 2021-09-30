import 'dart:convert';

class UserModel {
  final String? cnpj;
  final String? senha;
  UserModel({
    this.cnpj,
    this.senha,
  });

  UserModel copyWith({
    String? cnpj,
    String? senha,
  }) {
    return UserModel(
      cnpj: cnpj ?? this.cnpj,
      senha: senha ?? this.senha,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cnpj': cnpj,
      'senha': senha,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      cnpj: map['cnpj'],
      senha: map['senha'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(cnpj: $cnpj, senha: $senha)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.cnpj == cnpj && other.senha == senha;
  }

  @override
  int get hashCode => cnpj.hashCode ^ senha.hashCode;
}
