import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:ecommerce/core/components/app_text_form_field.dart';
import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:ecommerce/core/helpers/shared_pref_keys.dart';
import 'package:ecommerce/core/theming/app_colors.dart';
import 'package:ecommerce/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/features/user/chat/manager/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/components/app_bar.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _socketService.initSocket();
    chatCubit = ChatCubit(_socketService);
    chatCubit.fetchMessages();
    chatCubit.stream.listen((state) {
      if (state is ChatMessagesLoaded) {
        _scrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    _socketService.dispose();
    chatCubit.messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary.withOpacity(0.1),
      body: Column(
        children: [
          DefaultAppBar(
            text: SharedPref.getString(key: MySharedKeys.userName).toString(),
            cartIcon: false,
            backArrow: true,
          ),
          Expanded(
            child: StreamBuilder(
              stream: chatCubit.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data is ChatMessagesLoaded) {
                  final chatState = snapshot.data as ChatMessagesLoaded;
                  final messages = chatState.messages;
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isCurrentUser =
                          SharedPref.getString(key: MySharedKeys.userId)
                                  .toString() ==
                              message.userId;

                      DateTime messageTime =
                          DateTime.parse(message.createdAt);
                      String formattedTime =
                          DateFormat.jm().format(messageTime);

                      return Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.all(8.sp),
                          padding: EdgeInsets.all(10.sp),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          decoration: BoxDecoration(
                            color: isCurrentUser
                                ? AppColors.primary
                                : AppColors.primaryLight,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              topRight: Radius.circular(12.r),
                              bottomLeft: isCurrentUser
                                  ? Radius.circular(12.r)
                                  : Radius.zero,
                              bottomRight: isCurrentUser
                                  ? Radius.zero
                                  : Radius.circular(12.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.message,
                                style: TextStyle(
                                  color: isCurrentUser
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(height: 5.sp),
                              Text(
                                formattedTime,
                                style: TextStyles.font14grayRegular.copyWith(
                                  color: isCurrentUser
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                if (snapshot.data is ChatLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ));
                }
                return const Center(child: Text("No Messages"));
              },
            ),
          ),
          BlurryContainer(
            blur: 8,
            elevation: 6,
            color: AppColors.primary.withOpacity(0.1),
            padding: EdgeInsets.all(8.sp),
            child: Row(
              children: [
                Flexible(
                  child: AppTextFormField(
                    borderColor: Colors.transparent,
                    controller: chatCubit.messageController,
                    hintText: 'Enter message',
                    keyboardType: TextInputType.multiline,
                    isFilled: true,
                    backgroundColor: AppColors.primaryLight,
                    maxLines: 100,
                    contentPadding: EdgeInsets.all(10.sp),
                    borderRadius: BorderRadius.circular(30.r),
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        _scrollToBottom();
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.paperplane),
                  onPressed: () {
                    DateTime now = DateTime.now(); // Get current time
                    String formattedTime = DateFormat('yyyy-MM-ddTHH:mm:ss')
                        .format(now); // Format the date as ISO string
                    String trimmedMessage =
                        chatCubit.messageController.text.trim();
                    if (chatCubit.messageController.text.isNotEmpty &&
                        trimmedMessage.isNotEmpty) {
                      chatCubit.sendMessage(
                        message: MessageReq(
                          message: trimmedMessage,
                          id: SharedPref.getString(key: MySharedKeys.userId)
                              .toString(),
                          createdAt:
                              formattedTime, // Include the current timestamp
                        ),
                      );
                      chatCubit.messageController.clear();
                      _scrollToBottom();
                    }
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
