import 'package:flutter/material.dart';

class LoadMoreListener extends StatelessWidget {
  const LoadMoreListener({super.key, required this.child, required this.onScrollToEnd});

  final VoidCallback onScrollToEnd;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >= 0 &&
            notification.depth == 0 &&
            notification.metrics.maxScrollExtent <= notification.metrics.pixels) {
          onScrollToEnd();
        }
        return false;
      },
      child: child,
    );
  }
}
