// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combustiveis_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CombustiveisController on _CombustiveisControllerBase, Store {
  final _$tanquesAtom = Atom(name: '_CombustiveisControllerBase.tanques');

  @override
  ObservableList<CombustiveisModel> get tanques {
    _$tanquesAtom.reportRead();
    return super.tanques;
  }

  @override
  set tanques(ObservableList<CombustiveisModel> value) {
    _$tanquesAtom.reportWrite(value, super.tanques, () {
      super.tanques = value;
    });
  }

  final _$statusAtom = Atom(name: '_CombustiveisControllerBase.status');

  @override
  CombustiveisStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(CombustiveisStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$getTanquesAsyncAction =
      AsyncAction('_CombustiveisControllerBase.getTanques');

  @override
  Future<void> getTanques() {
    return _$getTanquesAsyncAction.run(() => super.getTanques());
  }

  @override
  String toString() {
    return '''
tanques: ${tanques},
status: ${status}
    ''';
  }
}
