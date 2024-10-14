import 'package:ecommerce/features/user/chat/model/message.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/features/user/chat/manager/chat_cubit.dart';
import '../../core/service/socket_service.dart';
import '../../model/message_req.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final SocketService _socketService = SocketService();
  late final ChatCubit chatCubit;
  final List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    _socketService.initSocket();
    chatCubit = ChatCubit(_socketService);
    chatCubit.fetchMessages(); // Fetch messages on screen init
  }

  @override
  void dispose() {
    _socketService.dispose();
    chatCubit.messageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
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
                  title: Text(messages[index].message),
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
                    controller: chatCubit.messageController,
                    decoration: const InputDecoration(
                        hintText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    chatCubit.postMessage(
                      message: MessageReq(
                        message: chatCubit.messageController.text,
                        id: "1", // Adjust ID as necessary
                      ),
                    );
                    chatCubit.messageController.clear();
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
