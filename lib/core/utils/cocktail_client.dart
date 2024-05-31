import 'package:dio/dio.dart';

final cocktailClient =
    Dio(BaseOptions(baseUrl: 'https://www.thecocktaildb.com/api/json/v1/1'));

final graphQLClient =
    Dio(BaseOptions(baseUrl: 'https://www.thecocktaildb.com/api/json/v1/1'));
