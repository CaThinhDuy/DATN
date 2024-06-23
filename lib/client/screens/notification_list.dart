import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationPage> {
  final List<Map<String, String>> _notifications = [
    {
      'title': 'Thông báo 1',
      'detail': 'Nội dung chi tiết của thông báo 1 với rất nhiều văn bản...'
    },
    {
      'title': 'Thông báo 2',
      'detail': 'Nội dung chi tiết của thông báo 2 với rất nhiều văn bản...'
    },
    // Thêm các thông báo khác vào đây
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // điều chỉnh độ rộng của danh sách thông báo
      child: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return ListTile(
            title: Text(notification['title']!),
            subtitle: Text(
              notification['detail']!.length > 30
                  ? '${notification['detail']!.substring(0, 30)}...'
                  : notification['detail']!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
    );
  }
}