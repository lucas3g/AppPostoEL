// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saldo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SaldoController on _SaldoControllerBase, Store {
  final _$saldoAtom = Atom(name: '_SaldoControllerBase.saldo');

  @override
  ObservableList<SaldoModel> get saldo {
    _$saldoAtom.reportRead();
    return super.saldo;
  }

  @override
  set saldo(ObservableList<SaldoModel> value) {
    _$saldoAtom.reportWrite(value, super.saldo, () {
      super.saldo = value;
    });
  }

  final _$statusAtom = Atom(name: '_SaldoControllerBase.status');

  @override
  SaldoStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(SaldoStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$getSaldoAsyncAction = AsyncAction('_SaldoControllerBase.getSaldo');

  @override
  Future<void> getSaldo() {
    return _$getSaldoAsyncAction.run(() => super.getSaldo());
  }

  final _$filtroAsyncAction = AsyncAction('_SaldoControllerBase.filtro');

  @override
  Future<ObservableList<SaldoModel>> filtro({required int local}) {
    return _$filtroAsyncAction.run(() => super.filtro(local: local));
  }

  final _$onSearchChangedAsyncAction =
      AsyncAction('_SaldoControllerBase.onSearchChanged');

  @override
  Future<ObservableList<SaldoModel>> onSearchChanged(
      {required String value, required int local}) {
    return _$onSearchChangedAsyncAction
        .run(() => super.onSearchChanged(value: value, local: local));
  }

  @override
  String toString() {
    return '''
saldo: ${saldo},
status: ${status}
    ''';
  }
}
