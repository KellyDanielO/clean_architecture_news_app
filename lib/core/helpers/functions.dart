import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> isOnline() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else if (connectivityResult == ConnectivityResult.ethernet) {
    return true;
  } else if (connectivityResult == ConnectivityResult.vpn) {
    return true;
  } else if (connectivityResult == ConnectivityResult.bluetooth) {
    return true;
  } else if (connectivityResult == ConnectivityResult.other) {
    return true;
  } else {
    return false;
  }
}

Future<void> launchUrlNow(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}
