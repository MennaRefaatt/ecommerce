import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/features/user/chat/core/service/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../model/message.dart';
import '../model/message_req.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SocketService _socketService;

  ChatCubit(this._socketService) : super(ChatInitial()) {
    // Initialize Socket.IO listener for new messages
    _socketService.socket.on('chat message', (data) {
      // Parse the incoming message
      final newMessage = MessageModel.fromJson(data);
      messages.add(newMessage);
      // Emit state to update UI
      emit(ChatMessagesLoaded(List.from(messages)));
    });
  }

  List<MessageModel> messages = [];
  TextEditingController messageController = TextEditingController();

  Future<void> fetchMessages() async {
    emit(ChatLoading()); // Emit loading state before fetching

    try {
      final response = await Dio().get('http://192.168.1.11:3000/api/messages');
      safePrint(response);

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        messages = responseData.map((e) => MessageModel.fromJson(e as Map<String, dynamic>)).toList();
        emit(ChatMessagesLoaded(messages));
      } else {
        emit(ChatError('Failed to load messages'));
      }
    } catch (e) {
      safePrint('Error fetching messages: $e');
      emit(ChatError('Error fetching messages: $e'));
    }
  }

  Future<void> postMessage({required MessageReq message}) async {
    try {
      final response = await Dio().post(
        'http://192.168.1.11:3000/api/messages',
        options: Options(headers: {"Content-Type": "application/json"}),
        data: message.toJson(),
      );

      if (response.statusCode == 201) {
        safePrint(response);
        // Optionally fetch messages again after sending a new message
        emit(ChatMessageSent());
        await fetchMessages(); // Refresh messages after sending
      } else {
        emit(ChatError('Failed to send message'));
      }
    } catch (e) {
      emit(ChatError('Error sending message: $e'));
    }
  }
}
