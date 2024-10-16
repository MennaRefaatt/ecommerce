import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/features/user/chat/core/service/socket_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initSocket() {
    socket = IO.io(SocketConstants.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'reconnection': true, // Enable reconnection
      'reconnectionAttempts': 5, // Try to reconnect 5 times
    });

    // Listen for the 'chat message' event
    socket.on('chat message', (data) {
      safePrint('New message: $data');
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
