import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:meta/meta.dart';
import '../model/message.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Future<List<String>> fetchMessages() async {
    try {
      final response = await Dio().get('http://192.168.1.11:3000/api/messages');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;

        List<String> messages = jsonResponse.cast<String>();

        return messages;
      } else {
        emit(ChatError('Failed to load messages'));
        return [];
      }
    } catch (e) {
      emit(ChatError('Error fetching messages: $e'));
      return [];
    }
  }

  Future<void> postMessage(String message) async {
    try {
      final response = await Dio().post(
        'http://192.168.1.11:3000/api/messages',
        options: Options(headers: {"Content-Type": "application/json"}),
        data: jsonEncode({"message": message}),
      );

      if (response.statusCode == 201) {
        safePrint(response);
      } else {
        emit(ChatError('Failed to send message'));
      }
    } catch (e) {
      emit(ChatError('Error sending message: $e'));
    }
  }
}
