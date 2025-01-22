import 'dart:convert';

import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/data/models/chat/visibilty_model.dart';
import 'package:sovchilar_mobile/src/data/models/profile/profile_model.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/chat/chat_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/inputs/custom_big_text_field.dart';
import 'package:sovchilar_mobile/src/presentation/pages/user/chat/widget/message_bubble.dart';

import '../../../../injector_container.dart';
import 'widget/name_and_typing_widget.dart';

part 'mixin/chat_mixin.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.userId,
    required this.profileId,
    required this.name,
    required this.status,
    required this.roomId,
    required this.profilePictureType,
    required this.createdDateTime,
    required this.chatId,
    required this.chatEndHour,
  });

  final String userId;
  final String profileId;
  final String name;
  final String status;
  final String roomId;
  final String profilePictureType;
  final String createdDateTime;
  final String chatId;
  final int chatEndHour;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with ChatMixin {
  bool isShowImage = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      buildWhen: (p, c) =>
          p.imageApiStatus != c.imageApiStatus ||
          p.apiStatus != c.apiStatus ||
          p.user != c.user ||
          p.likeApiStatus != c.likeApiStatus,
      listenWhen: (p, c) => p.user != c.user || p.likeApiStatus != c.likeApiStatus,
      listener: (context, state) {
        if (state.imageApiStatus.isSuccess) {
          setState(() => profile = state.user);
        }
        if (state.likeApiStatus.isSuccess) {
          context.pop(true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: NameAndTypingWidget(
              name: widget.name,
              firestore: _firestore,
              receiverId: widget.profileId,
              roomId: widget.chatId,
              profileId: widget.profileId,
            ),
            actions: [
              // ReverseTimerWidget(
              //   chatCreatedTime: widget.createdDateTime,
              //   totalHours: widget.status == 'NOT_OPEN_YET' ? 0 : widget.chatEndHour,
              // ),
              8.horizontalSpace,
              widget.status != 'CLOSED'
                  ? state.likeApiStatus.isLoading || state.apiStatus.isLoading
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 11.w),
                          child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator.adaptive()),
                        )
                      : PopupMenuButton<int>(
                          icon: Icon(Icons.more_vert_rounded),
                          onSelected: (value) {},
                          itemBuilder: (context) => [
                            if (widget.status != 'CLOSED')
                              PopupMenuItem(
                                value: 1,
                                onTap: () {
                                  context
                                      .read<ChatBloc>()
                                      // ..add(
                                      //   ShowMyImage(
                                      //     VisibilityModel(
                                      //       id: localSource.profileId,
                                      //       profilePictureType: widget.profilePictureType,
                                      //       sharedWithUsers: (profile?.sharedWithUsers ?? [])
                                      //           .where((user) => user != widget.userId)
                                      //           .toList(),
                                      //     ),
                                      //   ),
                                      // )
                                      .add(DislikeChatEvent(widget.profileId));
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.stopChat,
                                      width: 24,
                                      height: 24,
                                    ),
                                    8.horizontalSpace,
                                    Text('end_chat'.tr()),
                                  ],
                                ),
                              ),
                            // PopupMenuItem(
                            //   value: 1,
                            //   onTap: !(profile?.sharedWithUsers?.contains(widget.userId) ?? false)
                            //       ? state.apiStatus.isLoading
                            //           ? () {}
                            //           : () {
                            //               context.read<ChatBloc>().add(
                            //                     ShowMyImage(
                            //                       VisibilityModel(
                            //                         id: localSource.profileId,
                            //                         profilePictureType: widget.profilePictureType,
                            //                         sharedWithUsers: {...(profile?.sharedWithUsers ?? []), widget.userId}
                            //                             .map((e) => e.toString())
                            //                             .toList(),
                            //                       ),
                            //                     ),
                            //                   );
                            //             }
                            //       : state.apiStatus.isLoading
                            //           ? () {}
                            //           : () {
                            //               context.read<ChatBloc>().add(
                            //                     ShowMyImage(
                            //                       VisibilityModel(
                            //                         id: localSource.profileId,
                            //                         profilePictureType: widget.profilePictureType,
                            //                         sharedWithUsers: (profile?.sharedWithUsers ?? [])
                            //                             .where((user) => user != widget.userId)
                            //                             .toList(),
                            //                       ),
                            //                     ),
                            //                   );
                            //             },
                            //   child: Row(
                            //     children: [
                            //       Icon(Icons.image),
                            //       8.horizontalSpace,
                            //       Text(
                            //         !(profile?.sharedWithUsers?.contains(widget.userId) ?? false)
                            //             ? 'show_image'.tr()
                            //             : 'hide_image'.tr(),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // PopupMenuItem(
                            //   value: 2,
                            //   onTap: () async {
                            //     final querySnapshot = await _firestore.collection(roomId).get();
                            //
                            //     for (var doc in querySnapshot.docs) {
                            //       await doc.reference.update({
                            //         'isDelete': true,
                            //       });
                            //     }
                            //   },
                            //   child: Row(
                            //     children: [
                            //       SvgPicture.asset(
                            //         AppIcons.broom,
                            //         width: 24,
                            //         height: 23,
                            //       ),
                            //       8.horizontalSpace,
                            //       Text("Tarixni tozalash"),
                            //     ],
                            //   ),
                            // ),
                            //report todo
                            // PopupMenuItem(
                            //   value: 3,
                            //   child: Row(
                            //     children: [
                            //       SvgPicture.asset(
                            //         AppIcons.report,
                            //         width: 24,
                            //         height: 23,
                            //         colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                            //       ),
                            //       8.horizontalSpace,
                            //       Text(
                            //         'report'.tr(),
                            //         style: TextStyle(color: Colors.red),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        )
                  : SizedBox(),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                widget.status != 'CLOSED'
                    ? InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (ctx) => BlocProvider(
                            create: (_) => sl<ChatBloc>(),
                            child: Builder(
                              builder: (ctx) => AlertDialog(
                                title: Text(
                                  !(profile?.sharedWithUsers?.contains(widget.userId) ?? false)
                                      ? 'want_to_show_photo'.tr().replaceFirst('###', widget.name)
                                      : 'want_to_hide_photo'.tr().replaceFirst('###', widget.name),
                                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                                ),
                                actions: <Widget>[
                                  OverflowBar(
                                    alignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        style: OutlinedButton.styleFrom(
                                          fixedSize: Size(110.w, 40.h),
                                          backgroundColor: AppColor.mainColor,
                                        ),
                                        child: Text(
                                          'no'.tr(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () => Navigator.of(context).pop(false),
                                      ),
                                      ElevatedButton(
                                        style: OutlinedButton.styleFrom(
                                          fixedSize: Size(110.w, 40.h),
                                          backgroundColor: Colors.white,
                                          side: BorderSide(color: AppColor.mainColor),
                                        ),
                                        onPressed: !(profile?.sharedWithUsers?.contains(widget.userId) ?? false)
                                            ? state.apiStatus.isLoading
                                                ? () {}
                                                : () {
                                                    Navigator.of(context).pop(false);
                                                    context.read<ChatBloc>().add(
                                                          ShowMyImage(
                                                            VisibilityModel(
                                                              id: localSource.profileId,
                                                              profilePictureType: widget.profilePictureType,
                                                              sharedWithUsers: {
                                                                ...(profile?.sharedWithUsers ?? []),
                                                                widget.userId,
                                                              }.map((e) => e.toString()).toList(),
                                                            ),
                                                          ),
                                                        );
                                                  }
                                            : () {
                                                Navigator.of(context).pop(false);
                                                context.read<ChatBloc>().add(
                                                      ShowMyImage(
                                                        VisibilityModel(
                                                          id: localSource.profileId,
                                                          profilePictureType: widget.profilePictureType,
                                                          sharedWithUsers: (profile?.sharedWithUsers ?? [])
                                                              .where((user) => user != widget.userId)
                                                              .toList(),
                                                        ),
                                                      ),
                                                    );
                                              },
                                        child: Text(
                                          'yes'.tr(),
                                          style: TextStyle(color: AppColor.mainColor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        child: Container(
                          width: 1.sw,
                          alignment: Alignment.center,
                          padding: AppUtils.kPaddingHor16Ver12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: state.imageApiStatus.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : Text(
                                  !(profile?.sharedWithUsers?.contains(widget.userId) ?? false)
                                      ? 'show_image'.tr()
                                      : 'hide_image'.tr(),
                                ),
                        ),
                      )
                    : SizedBox(),
                Expanded(
                  child: FirestoreQueryBuilder(
                    query: _firestore.collection(widget.chatId).orderBy('timestamp'),
                    builder: (context, FirestoreQueryBuilderSnapshot snapshot, _) {
                      if (snapshot.isFetching) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColor.mainColor,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      final messages = snapshot.docs;

                      if (messages.isEmpty) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/images/not_found_chat.png'),
                              width: 180.w,
                              height: 180.w,
                            ),
                            AppUtils.kGap12,
                            Text('message_not_found'.tr()),
                          ],
                        );
                      }

                      if (snapshot.hasMore || messages.isNotEmpty) {
                        _scrollToBottom();
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (ctx, index) {
                          if (snapshot.hasMore && index + 1 == messages.length) {
                            snapshot.fetchMore();
                          }

                          final messageData = messages[index].data();
                          final messageId = messages[index].id;
                          final message = messageData['message'] ?? '';
                          final senderId = messageData['senderId'] ?? '';
                          final isRead = messageData['isRead'] ?? false;
                          final timestamp = messageData['timestamp']?.toDate();

                          if (senderId != localSource.profileId && !isRead) {
                            _markAsRead(messageId);
                          }

                          bool isSender = senderId == localSource.profileId;

                          String formattedDate = timestamp != null ? DateFormat('dd MMM yyyy').format(timestamp) : '';
                          String formattedTime = timestamp != null ? DateFormat('HH:mm').format(timestamp) : '';

                          String? previousFormattedDate;
                          if (index > 0) {
                            final previousTimestamp = messages[index - 1].data()['timestamp']?.toDate();
                            previousFormattedDate =
                                previousTimestamp != null ? DateFormat('dd MMM yyyy').format(previousTimestamp) : null;
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 4.h),
                            child: MessageBubble(
                              message: message,
                              isSender: isSender,
                              isRead: isRead,
                              formattedTime: formattedTime,
                              index: index,
                              messageId: messageId,
                              firestore: _firestore,
                              roomId: widget.chatId,
                              formattedDate: formattedDate,
                              previousFormattedDate: previousFormattedDate,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: widget.status != 'CLOSED'
                      ? Padding(
                          padding: AppUtils.kPaddingHorizontal12.copyWith(bottom: 8.h),
                          child: CustomBigTextField(
                            readOnly: widget.status == 'CLOSED',
                            enabled: widget.status != 'CLOSED',
                            controller: _controller,
                            focusNode: _focusNode,
                            hintText: 'type_message'.tr(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: _sendMessage,
                            ),
                            inputAction: TextInputAction.newline,
                            onChanged: (v) {
                              if (v?.trim().isEmpty ?? false) {
                                _controller.text = '';
                              }
                            },
                          ),
                        )
                      : SizedBox(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
