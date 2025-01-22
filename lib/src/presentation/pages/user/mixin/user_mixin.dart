part of '../user_page.dart';

mixin UserMixin on State<UserPage> {
  late final TabController _tabController;
  // List<GlobalKey<FormState>> keys = [];

  void initController(TickerProvider tickerProvider) {
    _tabController = TabController(length: 2, vsync: tickerProvider);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
