import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final bool isRead;
  final String formattedTime;
  final int index;
  final String messageId;
  final FirebaseFirestore firestore;
  final String roomId;
  final String formattedDate;
  final String? previousFormattedDate;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isSender,
    required this.isRead,
    required this.formattedTime,
    required this.index,
    required this.messageId,
    required this.firestore,
    required this.roomId,
    required this.formattedDate,
    this.previousFormattedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index == 0 || formattedDate != previousFormattedDate && formattedTime.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child:
              //InkWell(
              // onTap: () async {
              // await firestore.collection('chat_room').doc(roomId).collection('messages').doc(messageId).delete();
              // },
              //child:
              Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: isSender ? Colors.green.shade100 : Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Text(
                  message,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 11.h,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppUtils.kGap4,
                      if (isSender)
                        Icon(
                          formattedTime.isNotEmpty ? Icons.check : Icons.access_time,
                          size: 12.sp,
                          color: isRead ? Colors.green : Colors.grey,
                        ),
                      SizedBox(width: 5),
                      Text(
                        formattedTime.isNotEmpty ? formattedTime : DateFormat('HH:mm').format(DateTime.now()),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // ),
      ],
    );
  }
}
