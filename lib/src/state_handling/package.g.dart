// GENERATED CODE - DO NOT MODIFY BY HAND

part of judo.components.state_handling;

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoadingState on _LoadingState, Store {
  final _$isLoadingAtom = Atom(name: '_LoadingState.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$onPressedAsyncAction = AsyncAction('_LoadingState.onPressed');

  @override
  Future<void> onPressed(FutureFunction onPressed) {
    return _$onPressedAsyncAction.run(() => super.onPressed(onPressed));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
