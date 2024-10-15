import 'package:ecommerce/core/components/app_text_form_field.dart';
import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:ecommerce/core/helpers/shared_pref_keys.dart';
import 'package:ecommerce/core/theming/app_colors.dart';
import 'package:ecommerce/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/features/user/chat/manager/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  @override
  void initState() {
    super.initState();
    _socketService.initSocket();
    chatCubit = ChatCubit(_socketService);
    chatCubit.fetchMessages();
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
      backgroundColor: AppColors.primary.withOpacity(0.1),
      body: Column(
        children: [
          DefaultAppBar(
            text: SharedPref.getString(key: MySharedKeys.userName).toString(),
            cartIcon: false,
            backArrow: true,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatCubit.messages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8.sp),
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    color: SharedPref.getString(key: MySharedKeys.userId)
                                .toString() ==
                            chatCubit.messages[index].userId
                        ? AppColors.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chatCubit.messages[index].message),
                      Text(
                        chatCubit.messages[index].createdAt.split(" ").first,
                        style: TextStyles.font14grayRegular,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              children: [
                Expanded(
                  child: AppTextFormField(
                    controller: chatCubit.messageController,
                    hintText: 'Enter message',
                    keyboardType: TextInputType.multiline,
                    isFilled: true,
                    backgroundColor: AppColors.primaryLight,
                    maxLines: 100,
                    contentPadding: EdgeInsets.all(10.sp),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                IconButton(
                    icon: const Icon(CupertinoIcons.paperplane),
                    onPressed: () {
                      if (chatCubit.messageController.text.isNotEmpty) {
                        chatCubit.postMessage(
                          message: MessageReq(
                            message: chatCubit.messageController.text,
                            id: SharedPref.getString(key: MySharedKeys.userId)
                                .toString(),
                          ),
                        );
                        chatCubit.messageController.clear();
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
