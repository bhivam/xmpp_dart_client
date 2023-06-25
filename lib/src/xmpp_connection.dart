import 'dart:io';

enum ConnectionStatus { tcpConnected, xmppConnected, disconnected }

class XmppConnection {
  String host;
  String port;
  ConnectionStatus connectionStatus;
  late Socket _socket;

  XmppConnection(this.host, [this.port = '5222'])
      : connectionStatus = ConnectionStatus.disconnected;

  Future<bool> connect() async {
    /* 
      option to create a socket wrapper which will do the TCP connection as 
      specified by XMPP docs or to just do the XMPP connection and TCP 
      connection in one place

      will do latter for now so we can have quick solution.
    */
    List<InternetAddress> addrs = await InternetAddress.lookup(host);
    for (InternetAddress addr in addrs) {
      try {
        print("trying connection to $host at ${addr.address}:$port");
        _socket = await Socket.connect(addr, int.parse(port),
            timeout: const Duration(seconds: 5));
      } on Exception catch (e) {
        continue;
      }

      connectionStatus = ConnectionStatus.tcpConnected;
      return true;
    }

    return false;
  }

  Future<void> close() async {
    await _socket.close();
  }
}
