import 'package:xmpp_dart_client/xmpp_dart_client.dart';

Future<void> main() async {
  XmppConnection connection = XmppConnection("jabber.org");

  print("starting connection");
  connection.connect();
}
