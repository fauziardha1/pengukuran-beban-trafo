import 'dart:io';

Future<bool> internetConnection() async {
  bool status = false;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      status = true;
    }
  } on SocketException catch (_) {
    print('not connected');
    status = false;
  }

  return status;
}
