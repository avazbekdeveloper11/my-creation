import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'dart:async';

import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';

class NameAndTypingWidget extends StatelessWidget {
  const NameAndTypingWidget({
    super.key,
    required this.firestore,
    required this.name,
    required this.receiverId,
    required this.roomId,
    required this.profileId,
  });

  final FirebaseFirestore firestore;
  final String name;
  final String receiverId;
  final String roomId;
  final String profileId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.userDetailScreen, extra: UserModel(id: profileId));
          },
          child: Text(
            name,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FirestoreQueryBuilder(
          query: FirebaseFirestore.instance
              .collection(roomId)
              .where(FieldPath.fromString('typingBy'), isEqualTo: receiverId)
              .limit(1),
          builder: (context, snapshot, _) {
            if (snapshot.isFetching) {
              return SizedBox.shrink();
            }

            if (snapshot.hasError) {
              return Text(
                'Error loading status',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.red,
                ),
              );
            }

            if (snapshot.docs.isEmpty) {
              return SizedBox.shrink();
            }

            final data = snapshot.docs.first.data();
            final isTyping = data['isTyping'] ?? false;
            final typingBy = data['typingBy'] ?? '';
            if (isTyping && typingBy != localSource.userId) {
              return TypingIndicator(); // Display typing animation
            }

            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with SingleTickerProviderStateMixin {
  late Timer _timer;
  List<double> _opacities = [0.3, 0.3, 0.3];
  int _currentDot = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        _opacities[_currentDot] = 1.0; // Highlight current dot
        _opacities = _opacities
            .asMap()
            .map((i, opacity) => MapEntry(i, i == _currentDot ? 1.0 : 0.3)) // Reset others
            .values
            .toList();
        _currentDot = (_currentDot + 1) % _opacities.length; // Loop through dots
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'typing'.tr(),
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.blue,
          ),
        ),
        ...List.generate(
          3,
          (index) {
            return AnimatedOpacity(
              opacity: _opacities[index],
              duration: const Duration(milliseconds: 300),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 3),
                width: 3.w,
                height: 3.w,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
