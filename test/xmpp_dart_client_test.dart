import 'package:xmpp_dart_client/xmpp_dart_client.dart';
import 'package:test/test.dart';

void main() {
  group('TCP connection testing', () {
    XmppConnection connection = XmppConnection("jabber.org");

    setUp(() async {
      await connection.connect();
    });

    tearDown(() {
      connection.close();
    });

    test('TCP connects when expected', () {
      expect(
          connection.connectionStatus == ConnectionStatus.tcpConnected, isTrue);
    });
  });
}
