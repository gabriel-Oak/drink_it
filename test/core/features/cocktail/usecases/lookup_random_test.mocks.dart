// Mocks generated by Mockito 5.4.4 from annotations
// in drink_it/test/core/features/cocktail/usecases/lookup_random_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_external_datasource.dart'
    as _i6;
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_local_datasource.dart'
    as _i4;
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart'
    as _i3;
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart'
    as _i2;
import 'package:drink_it/core/utils/network_info.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeShallowCocktail_0 extends _i1.SmartFake
    implements _i2.ShallowCocktail {
  _FakeShallowCocktail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCocktailV2_1 extends _i1.SmartFake implements _i3.CocktailV2 {
  _FakeCocktailV2_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CocktailV2LocalDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCocktailV2LocalDatasource extends _i1.Mock
    implements _i4.CocktailV2LocalDatasource {
  MockCocktailV2LocalDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.ShallowCocktail> lookupRandom() => (super.noSuchMethod(
        Invocation.method(
          #lookupRandom,
          [],
        ),
        returnValue:
            _i5.Future<_i2.ShallowCocktail>.value(_FakeShallowCocktail_0(
          this,
          Invocation.method(
            #lookupRandom,
            [],
          ),
        )),
      ) as _i5.Future<_i2.ShallowCocktail>);

  @override
  _i5.Future<int> save(List<_i3.CocktailV2>? cocktails) => (super.noSuchMethod(
        Invocation.method(
          #save,
          [cocktails],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);

  @override
  _i5.Future<List<_i2.ShallowCocktail>> getCocktails({
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
        returnValue: _i5.Future<List<_i2.ShallowCocktail>>.value(
            <_i2.ShallowCocktail>[]),
      ) as _i5.Future<List<_i2.ShallowCocktail>>);

  @override
  _i5.Future<_i3.CocktailV2> getDetails(String? cocktailId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetails,
          [cocktailId],
        ),
        returnValue: _i5.Future<_i3.CocktailV2>.value(_FakeCocktailV2_1(
          this,
          Invocation.method(
            #getDetails,
            [cocktailId],
          ),
        )),
      ) as _i5.Future<_i3.CocktailV2>);
}

/// A class which mocks [CocktailV2ExternalDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCocktailV2ExternalDatasource extends _i1.Mock
    implements _i6.CocktailV2ExternalDatasource {
  MockCocktailV2ExternalDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i2.ShallowCocktail>> getCocktails({
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
        returnValue: _i5.Future<List<_i2.ShallowCocktail>>.value(
            <_i2.ShallowCocktail>[]),
      ) as _i5.Future<List<_i2.ShallowCocktail>>);

  @override
  _i5.Future<_i2.ShallowCocktail> lookupRandom() => (super.noSuchMethod(
        Invocation.method(
          #lookupRandom,
          [],
        ),
        returnValue:
            _i5.Future<_i2.ShallowCocktail>.value(_FakeShallowCocktail_0(
          this,
          Invocation.method(
            #lookupRandom,
            [],
          ),
        )),
      ) as _i5.Future<_i2.ShallowCocktail>);

  @override
  _i5.Future<_i3.CocktailV2> getDetails(String? cocktailId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetails,
          [cocktailId],
        ),
        returnValue: _i5.Future<_i3.CocktailV2>.value(_FakeCocktailV2_1(
          this,
          Invocation.method(
            #getDetails,
            [cocktailId],
          ),
        )),
      ) as _i5.Future<_i3.CocktailV2>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i7.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}
