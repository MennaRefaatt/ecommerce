import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:uuid/uuid.dart';
import 'package:ecommerce/features/user/chat/core/service/socket_constants.dart';
import 'package:ecommerce/features/user/chat/core/service/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../model/message.dart';
import '../model/message_req.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SocketService _socketService;
  List<MessageModel> messages = [];
  TextEditingController messageController = TextEditingController();
  ChatCubit(this._socketService) : super(ChatInitial()) {
    _socketService.socket.on('chat message', (data) {
      final newMessage = MessageModel.fromJson(data);
      messages.add(newMessage);
      emit(ChatMessagesLoaded(List.from(messages)));
    });
  }

  Future<void> fetchMessages() async {
    emit(ChatLoading());
    try {
      final response = await Dio().get(
          SocketConstants.chatBaseUrl + SocketConstants.chatMessageEndpoint);

      safePrint('response: $response');
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        messages = responseData
            .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
            .toList();
        safePrint('messages: $messages');
        emit(ChatMessagesLoaded(messages));
      } else {
        emit(ChatError('Failed to load messages'));
        safePrint('messages: $messages');
      }
    } catch (e) {
      emit(ChatError('Error fetching messages: $e'));
      safePrint('messages: $messages');
    }
  }

  Future<void> sendMessage({required MessageReq message}) async {
    var uuid = const Uuid();
    final newMessage = MessageModel(
      userId: message.id,
      message: message.message,
      createdAt: DateTime.now().toIso8601String(),
      id: uuid.v4(),
    );

    try {
      final response = await Dio().post(
        SocketConstants.chatBaseUrl + SocketConstants.chatMessageEndpoint,
        data: message.toJson(),
      );

      if (response.statusCode == 201) {
        _socketService.socket.emit('chat message', newMessage.toJson());
        messages.add(newMessage);
        safePrint('messages: $messages');
        emit(ChatMessagesLoaded(List.from(messages)));
      } else {
        emit(ChatError('Failed to send message'));
        safePrint('messages: $messages');
      }
    } catch (e) {
      emit(ChatError('Error sending message: $e'));
      safePrint('messages: $messages');
    }
  }
}
