import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationScreen> {
  final List<Map<String, String>> _notifications = [
    {
      'title': 'Thông báo 1',
      'detail': 'Nội dung chi tiết của thông báo 1 với rất nhiều văn bản...',
      'date_post': '20/12/2024'
    },
    {
      'title': 'Thông báo 2',
      'detail': 'Nội dung chi tiết của thông báo 2 với rất nhiều văn bản...',
      'date_post': '20/12/2024'
    },
    {
      'title': 'Thông báo 3',
      'detail': 'Nội dung chi tiết của thông báo 3 với rất nhiều văn bản...',
      'date_post': '21/12/2024'
    },
    {
      'title': 'Thông báo 4',
      'detail': 'Nội dung chi tiết của thông báo 4 với rất nhiều văn bản...',
      'date_post': '20/12/2024'
    },
    {
      'title': 'Thông báo 5',
      'detail': 'Nội dung chi tiết của thông báo 5 với rất nhiều văn bản...',
      'date_post': '21/12/2024'
    },
    {
      'title': 'Thông báo 6',
      'detail': 'Nội dung chi tiết của thông báo 6 với rất nhiều văn bản...',
      'date_post': '20/12/2024'
    },
    {
      'title': 'Thông báo 7',
      'detail': 'Nội dung chi tiết của thông báo 7 với rất nhiều văn bản...',
      'date_post': '21/12/2024'
    },
    {
      'title': 'Thông báo 1',
      'detail': 'Nội dung chi tiết của thông báo 1 với rất nhiều văn bản...',
      'date_post': '20/12/2024'
    },
    {
      'title': 'Thông báo 2',
      'detail': 'Nội dung chi tiết của thông báo 2 với rất nhiều văn bản...',
      'date_post': '20/12/2024'
    },
    {
      'title': 'Thông báo 3',
      'detail': 'Nội dung chi tiết của thông báo 3 với rất nhiều văn bản...',
      'date_post': '21/12/2024'
    },
    {
      'title': 'Thông báo 4',
      'detail': 'Nội dung chi tiết của thông báo 4 với rất nhiều văn bản...',
      'date_post': '20/12/2024'
    },
    {
      'title': 'Thông báo 5',
      'detail': 'Nội dung chi tiết của thông báo 5 với rất nhiều văn bản...',
      'date_post': '21/12/2024'
    },
    {
      'title': 'Thông báo 6',
      'detail': 'Nội dung chi tiết của thông báo 6 với rất nhiều văn bản...',
      'date_post': '20/12/2024'
    },
    {
      'title': 'Thông báo 7',
      'detail': 'Nội dung chi tiết của thông báo 7 với rất nhiều văn bản...',
      'date_post': '21/12/2024'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo ',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              10, 20, 10, 20), // điều chỉnh độ rộng của danh sách thông báo
          child: ListView.builder(
            itemCount: _notifications.length,
            itemBuilder: (context, index) {
              final notification = _notifications[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(notification['title']!),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification['detail']!.length > 30
                            ? '${notification['detail']!.substring(0, 50)}...'
                            : notification['detail']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(notification['date_post']!.length > 0
                          ? '${notification['date_post']}'
                          : '1/1/1900')
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
