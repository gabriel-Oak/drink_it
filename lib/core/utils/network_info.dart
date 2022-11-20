// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfoContract {
  Future<bool> get isConnected;
}

class NetworkInfo extends NetworkInfoContract {
  final DataConnectionChecker connectionChecker;

  NetworkInfo(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
