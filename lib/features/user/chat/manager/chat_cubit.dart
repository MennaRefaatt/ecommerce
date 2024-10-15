import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/features/user/chat/core/service/socket_constants.dart';
import 'package:ecommerce/features/user/chat/core/service/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../model/message.dart';
import '../model/message_req.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SocketService _socketService;

  ChatCubit(this._socketService) : super(ChatInitial()) {
    _socketService.socket.on('chat message', (data) {
      final newMessage = MessageModel.fromJson(data);
      messages.add(newMessage);
      emit(ChatMessagesLoaded(List.from(messages)));
    });
  }
  List<MessageModel> messages = [];
  TextEditingController messageController = TextEditingController();

  Future<void> fetchMessages() async {
    emit(ChatLoading());

    try {
      final response = await Dio()
          .get(SocketConstants.chatBaseUrl + SocketConstants.chatMessageEndpoint);
      safePrint(response);

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        messages = responseData
            .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
            .toList();
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
        SocketConstants.chatBaseUrl + SocketConstants.chatMessageEndpoint,
        options: Options(headers: {"Content-Type": "application/json"}),
        data: message.toJson(),
      );

      if (response.statusCode == 201) {
        safePrint(response);
        emit(ChatMessageSent());
        await fetchMessages();
      } else {
        emit(ChatError('Failed to send message'));
      }
    } catch (e) {
      emit(ChatError('Error sending message: $e'));
    }
  }
}
