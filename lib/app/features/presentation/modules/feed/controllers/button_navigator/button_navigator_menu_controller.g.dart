// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_navigator_menu_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ButtonNavigatorMenuController
    on ButtonNavigatorMenuControllerBase, Store {
  late final _$currentIndexAtom = Atom(
    name: 'ButtonNavigatorMenuControllerBase.currentIndex',
    context: context,
  );

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$ButtonNavigatorMenuControllerBaseActionController =
      ActionController(
        name: 'ButtonNavigatorMenuControllerBase',
        context: context,
      );

  @override
  void onItemTapped(int index) {
    final _$actionInfo = _$ButtonNavigatorMenuControllerBaseActionController
        .startAction(name: 'ButtonNavigatorMenuControllerBase.onItemTapped');
    try {
      return super.onItemTapped(index);
    } finally {
      _$ButtonNavigatorMenuControllerBaseActionController.endAction(
        _$actionInfo,
      );
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex}
    ''';
  }
}
