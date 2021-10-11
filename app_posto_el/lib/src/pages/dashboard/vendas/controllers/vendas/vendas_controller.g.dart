// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendas_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VendasController on _VendasControllerBase, Store {
  final _$vendasAtom = Atom(name: '_VendasControllerBase.vendas');

  @override
  ObservableList<VendasModel> get vendas {
    _$vendasAtom.reportRead();
    return super.vendas;
  }

  @override
  set vendas(ObservableList<VendasModel> value) {
    _$vendasAtom.reportWrite(value, super.vendas, () {
      super.vendas = value;
    });
  }

  final _$statusAtom = Atom(name: '_VendasControllerBase.status');

  @override
  VendasStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(VendasStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$getVendasAsyncAction = AsyncAction('_VendasControllerBase.getVendas');

  @override
  Future<void> getVendas() {
    return _$getVendasAsyncAction.run(() => super.getVendas());
  }

  final _$_VendasControllerBaseActionController =
      ActionController(name: '_VendasControllerBase');

  @override
  String somaVendas({required int local}) {
    final _$actionInfo = _$_VendasControllerBaseActionController.startAction(
        name: '_VendasControllerBase.somaVendas');
    try {
      return super.somaVendas(local: local);
    } finally {
      _$_VendasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String projecaoVenda({required int local}) {
    final _$actionInfo = _$_VendasControllerBaseActionController.startAction(
        name: '_VendasControllerBase.projecaoVenda');
    try {
      return super.projecaoVenda(local: local);
    } finally {
      _$_VendasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
vendas: ${vendas},
status: ${status}
    ''';
  }
}
