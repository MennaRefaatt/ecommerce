
import 'package:flutter/material.dart';
import 'package:ecommerce/features/user/chat/manager/chat_cubit.dart';
import '../../../../../core/helpers/safe_print.dart';
import '../../core/service/socket_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = [];
  final SocketService _socketService = SocketService();
  final ChatCubit chatCubit=ChatCubit();
  @override
  void initState() {
    super.initState();
    // Fetch initial messages from the API
    _fetchMessages();

    // Initialize Socket.IO for real-time updates
    _socketService.initSocket();
    _socketService.socket.on('chat message', (data) {
      setState(() {
        messages.add(data);
      });
    });
  }

  void _fetchMessages() async {
    try {
      List<String> fetchedMessages = await chatCubit.fetchMessages();
      setState(() {
        messages = fetchedMessages;
      });
    } catch (e) {
      safePrint('Error fetching messages: $e');
    }
  }

  void _sendMessage(String message) async {
    try {
      await chatCubit.postMessage(message);
      // Update local message list after sending
      setState(() {
        messages.add(message);
      });
    } catch (e) {
      safePrint('Error sending message: $e');
    }
  }

  @override
  void dispose() {
    _socketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(hintText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(messageController.text);
                    messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   List<MessageModel> messages = [];
//   final TextEditingController messageController = TextEditingController();
//
//   late final ChatCubit chatCubit;
//
//   @override
//   void initState() {
//     super.initState();
//     final socketService = SocketService();
//     socketService.initSocket();
//     chatCubit = ChatCubit(socketService);
//     _fetchMessages();
//   }
//
//   void _fetchMessages() async {
//     final fetchedMessages = await chatCubit.fetchMessages();
//     setState(() {
//       messages = fetchedMessages;
//     });
//   }
//
//   void _sendMessage(String message) async {
//     await chatCubit.postMessage(message);
//     setState(() {
//       messages.add(MessageModel(id: '', message: message, createdAt: DateTime.now()));
//     });
//   }
//
//   @override
//   void dispose() {
//     chatCubit.socketService.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chat')),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<ChatCubit, ChatState>(
//               bloc: chatCubit,
//               builder: (context, state) {
//                 if (state is ChatLoading) {
//                 } else if (state is ChatSuccess) {
//                   messages.add(state.messages as MessageModel);
//                 }
//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(messages[index].message),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: const InputDecoration(hintText: 'Enter message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () {
//                     _sendMessage(messageController.text);
//                     messageController.clear();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
