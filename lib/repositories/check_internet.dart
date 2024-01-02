import 'dart:async';
import 'dart:io';

class ConnectionStatusSingleton {
  static final ConnectionStatusSingleton _singleton =
      ConnectionStatusSingleton._internal();

  ConnectionStatusSingleton._internal();

  static ConnectionStatusSingleton getInstance() => _singleton;

  bool hasConnection = false;

  StreamController<bool> connectionChangeController =
      StreamController<bool>.broadcast();

  Stream<bool> get connectionChange => connectionChangeController.stream;

  void dispose() {
    connectionChangeController.close();
  }

  // Khởi tạo và theo dõi trạng thái kết nối
  void init() {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}
