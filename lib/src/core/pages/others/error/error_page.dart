import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.state,
  });

  final GoRouterState state;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Center(
          child: Text(
            'Not found ${state.name}',
            textAlign: TextAlign.center,
          ),
        ),
      );
}
