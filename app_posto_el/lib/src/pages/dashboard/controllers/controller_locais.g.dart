// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_locais.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerLocais on _ControllerLocaisBase, Store {
  final _$locaisAtom = Atom(name: '_ControllerLocaisBase.locais');

  @override
  ObservableList<ModelLocais> get locais {
    _$locaisAtom.reportRead();
    return super.locais;
  }

  @override
  set locais(ObservableList<ModelLocais> value) {
    _$locaisAtom.reportWrite(value, super.locais, () {
      super.locais = value;
    });
  }

  final _$dropdownValueAtom = Atom(name: '_ControllerLocaisBase.dropdownValue');

  @override
  int get dropdownValue {
    _$dropdownValueAtom.reportRead();
    return super.dropdownValue;
  }

  @override
  set dropdownValue(int value) {
    _$dropdownValueAtom.reportWrite(value, super.dropdownValue, () {
      super.dropdownValue = value;
    });
  }

  final _$statusAtom = Atom(name: '_ControllerLocaisBase.status');

  @override
  LocaisStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(LocaisStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$getLocaisAsyncAction = AsyncAction('_ControllerLocaisBase.getLocais');

  @override
  Future<void> getLocais() {
    return _$getLocaisAsyncAction.run(() => super.getLocais());
  }

  @override
  String toString() {
    return '''
locais: ${locais},
dropdownValue: ${dropdownValue},
status: ${status}
    ''';
  }
}
