// Mocks generated by Mockito 5.3.2 from annotations
// in drink_it/test/core/features/cocktail/usecases/get_detail_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:drink_it/core/features/cocktail/datasources/cocktail_external_datasource.dart'
    as _i3;
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart'
    as _i6;
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart'
    as _i5;
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart'
    as _i2;
import 'package:drink_it/core/features/cocktail/models/ingredient_model.dart'
    as _i8;
import 'package:drink_it/core/utils/network_info.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCocktail_0 extends _i1.SmartFake implements _i2.Cocktail {
  _FakeCocktail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CocktailExternalDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCocktailExternalDatasource extends _i1.Mock
    implements _i3.CocktailExternalDatasource {
  MockCocktailExternalDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Cocktail> getDetails(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getDetails,
          [id],
        ),
        returnValue: _i4.Future<_i2.Cocktail>.value(_FakeCocktail_0(
          this,
          Invocation.method(
            #getDetails,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Cocktail>);
  @override
  _i4.Future<List<_i5.CocktailItem>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCocktails,
          [],
          {
            #ingredient: ingredient,
            #category: category,
            #alcoholic: alcoholic,
          },
        ),
        returnValue:
            _i4.Future<List<_i5.CocktailItem>>.value(<_i5.CocktailItem>[]),
      ) as _i4.Future<List<_i5.CocktailItem>>);
}

/// A class which mocks [CocktailLocalDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCocktailLocalDatasource extends _i1.Mock
    implements _i6.CocktailLocalDatasource {
  MockCocktailLocalDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Cocktail> getDetails(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getDetails,
          [id],
        ),
        returnValue: _i4.Future<_i2.Cocktail>.value(_FakeCocktail_0(
          this,
          Invocation.method(
            #getDetails,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Cocktail>);
  @override
  _i4.Future<int> save(_i2.Cocktail? cocktail) => (super.noSuchMethod(
        Invocation.method(
          #save,
          [cocktail],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<List<_i5.CocktailItem>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCocktails,
          [],
          {
            #ingredient: ingredient,
            #category: category,
            #alcoholic: alcoholic,
          },
        ),
        returnValue:
            _i4.Future<List<_i5.CocktailItem>>.value(<_i5.CocktailItem>[]),
      ) as _i4.Future<List<_i5.CocktailItem>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i7.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}

/// A class which mocks [Cocktail].
///
/// See the documentation for Mockito's code generation for more information.
class MockCocktail extends _i1.Mock implements _i2.Cocktail {
  MockCocktail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: '',
      ) as String);
  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: '',
      ) as String);
  @override
  String get thumb => (super.noSuchMethod(
        Invocation.getter(#thumb),
        returnValue: '',
      ) as String);
  @override
  String get tags => (super.noSuchMethod(
        Invocation.getter(#tags),
        returnValue: '',
      ) as String);
  @override
  String get category => (super.noSuchMethod(
        Invocation.getter(#category),
        returnValue: '',
      ) as String);
  @override
  String get alcoholic => (super.noSuchMethod(
        Invocation.getter(#alcoholic),
        returnValue: '',
      ) as String);
  @override
  String get glass => (super.noSuchMethod(
        Invocation.getter(#glass),
        returnValue: '',
      ) as String);
  @override
  List<_i8.Ingredient> get ingredients => (super.noSuchMethod(
        Invocation.getter(#ingredients),
        returnValue: <_i8.Ingredient>[],
      ) as List<_i8.Ingredient>);
  @override
  String get dateModified => (super.noSuchMethod(
        Invocation.getter(#dateModified),
        returnValue: '',
      ) as String);
  @override
  Map<String, dynamic> toMap() => (super.noSuchMethod(
        Invocation.method(
          #toMap,
          [],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);
}
