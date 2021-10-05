// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_locais.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerLocais on _ControllerLocaisBase, Store {
  final _$locaisAtom = Atom(name: '_ControllerLocaisBase.locais');

  @override
  ModelLocais get locais {
    _$locaisAtom.reportRead();
    return super.locais;
  }

  @override
  set locais(ModelLocais value) {
    _$locaisAtom.reportWrite(value, super.locais, () {
      super.locais = value;
    });
  }

  final _$getLocaisAsyncAction = AsyncAction('_ControllerLocaisBase.getLocais');

  @override
  Future<void> getLocais() {
    return _$getLocaisAsyncAction.run(() => super.getLocais());
  }

  final _$_ControllerLocaisBaseActionController =
      ActionController(name: '_ControllerLocaisBase');

  @override
  void onChanged({int? id, String? descricao}) {
    final _$actionInfo = _$_ControllerLocaisBaseActionController.startAction(
        name: '_ControllerLocaisBase.onChanged');
    try {
      return super.onChanged(id: id, descricao: descricao);
    } finally {
      _$_ControllerLocaisBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locais: ${locais}
    ''';
  }
}
