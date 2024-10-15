import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/features/user/chat/core/service/socket_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initSocket() {
    // Establish a connection
    socket = IO.io(SocketConstants.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
    });

    // Listen for the 'chat message' event
    socket.on('chat message', (data) {
      safePrint('New message: $data');
      // You can update your UI or message list here
    });

    socket.onConnect((_) {
      safePrint('Connected to the chat server');
    });

    socket.onDisconnect((_) {
      safePrint('Disconnected from the chat server');
    });
  }

  void dispose() {
    socket.dispose();
  }
}
