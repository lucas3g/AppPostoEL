// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volumes_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VolumesController on _VolumesControllerBase, Store {
  final _$volumesAtom = Atom(name: '_VolumesControllerBase.volumes');

  @override
  ObservableList<VolumesModel> get volumes {
    _$volumesAtom.reportRead();
    return super.volumes;
  }

  @override
  set volumes(ObservableList<VolumesModel> value) {
    _$volumesAtom.reportWrite(value, super.volumes, () {
      super.volumes = value;
    });
  }

  final _$statusAtom = Atom(name: '_VolumesControllerBase.status');

  @override
  VolumesStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(VolumesStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$getLitrosAsyncAction =
      AsyncAction('_VolumesControllerBase.getLitros');

  @override
  Future<void> getLitros() {
    return _$getLitrosAsyncAction.run(() => super.getLitros());
  }

  final _$_VolumesControllerBaseActionController =
      ActionController(name: '_VolumesControllerBase');

  @override
  String somaLitros({required int local}) {
    final _$actionInfo = _$_VolumesControllerBaseActionController.startAction(
        name: '_VolumesControllerBase.somaLitros');
    try {
      return super.somaLitros(local: local);
    } finally {
      _$_VolumesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String projecaoLitros({required int local}) {
    final _$actionInfo = _$_VolumesControllerBaseActionController.startAction(
        name: '_VolumesControllerBase.projecaoLitros');
    try {
      return super.projecaoLitros(local: local);
    } finally {
      _$_VolumesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
volumes: ${volumes},
status: ${status}
    ''';
  }
}
