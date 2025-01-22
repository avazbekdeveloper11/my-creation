part of 'package:sovchilar_mobile/src/presentation/pages/user/chat/chat_page.dart';

mixin ChatMixin on State<ChatPage> {
  late final FirebaseFirestore _firestore;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final ScrollController _scrollController;
  // late final String roomId;
  bool _isTyping = false;
  ProfileModel? profile;

  @override
  void initState() {
    super.initState();
    final String cachedData = localSource.getKey(AppKeys.profileCache);
    if (cachedData.isNotEmpty) {
      final ProfileModel cache = ProfileModel.fromJson(jsonDecode(cachedData) as Map<String, dynamic>);
      profile = cache;
    }
    // roomId = _generateReceiverId(widget.userId, localSource.userId);
    _firestore = FirebaseFirestore.instance;
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _scrollController = ScrollController();

    _controller.addListener(() {
      final isCurrentlyTyping = _controller.text.isNotEmpty;
      if (isCurrentlyTyping != _isTyping) {
        _isTyping = isCurrentlyTyping;
        _updateTypingStatus(isCurrentlyTyping);
      }
    });

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _updateTypingStatus(false);
      }
      if (_focusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (MediaQuery.of(context).viewInsets.bottom > 0) {
            _scrollToBottom();
          }
        });
      }
    });
  }

  void _updateTypingStatus(bool isTyping) async {
    final chatDoc = _firestore.collection(widget.chatId).doc('is_typing');

    await chatDoc.set(
      {
        'isTyping_${localSource.userId}': isTyping,
        'typingBy': localSource.userId,
      },
      SetOptions(merge: true),
    );
  }
  //
  // String _generateReceiverId(String userId1, String userId2) {
  //   final sortedIds = [userId1, userId2]..sort();
  //   return '${sortedIds[0]}_${sortedIds[1]}';
  // }

  void _markAsRead(String messageId) async {
    await _firestore.collection(widget.chatId).doc(messageId).update({
      'isRead': true,
    });
  }

  void _sendMessage() async {
    if (_controller.text.trim().isNotEmpty) {
      final String msg = _controller.text.trim();
      _controller.clear();
      final messageRef = _firestore.collection(widget.chatId).doc();

      await messageRef.set({
        'senderId': localSource.profileId,
        'receiverId': widget.profileId,
        'message': msg,
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false,
        'roomId': widget.chatId,
        'isDelete': false,
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _updateTypingStatus(false);
    _controller.dispose();
    super.dispose();
  }
}
