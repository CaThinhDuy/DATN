import 'package:flutter/material.dart';
import 'package:flutter_application_1/server/UserService.dart';
import 'package:flutter_application_1/utils/standard_UI.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  final String token;
  final int UserID;
  const NotificationScreen(
      {super.key, required this.UserID, required this.token});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationScreen> {
  List<Map<String, dynamic>> _notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotification();
  }

  Future<void> fetchNotification() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedNotification =
          await UserService.getNotification(widget.token, widget.UserID);

      if (fetchedNotification != null) {
        setState(() {
          _notifications = fetchedNotification;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không thể tải dữ liệu thông báo.')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể tải dữ liệu thông báo: $e')),
      );
    }
  }

  String formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('dd/MM/yy').format(dateTime);
    } catch (e) {
      return '01/01/1900';
    }
  }

  Future<void> deleteNotification(int index, int notificationId) async {
    setState(() {
      isLoading = true;
    });

    final success =
        await UserService.deleteNotification(widget.token, notificationId);

    setState(() {
      isLoading = false;
    });

    if (success) {
      setState(() {
        _notifications.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thông báo đã được xóa.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể xóa thông báo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: UI.backgroundApp,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
              ? const Center(
                  child: Text(
                    'Không có thông báo nào.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10,
                        20), // điều chỉnh độ rộng của danh sách thông báo
                    child: ListView.builder(
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final notification = _notifications[index];
                        return GestureDetector(
                          onLongPress: () {
                            showMenu(
                              context: context,
                              position: RelativeRect.fill,
                              items: [
                                const PopupMenuItem<int>(
                                  value: 0,
                                  child: Text('Xóa'),
                                ),
                              ],
                            ).then((value) {
                              if (value == 0) {
                                deleteNotification(index, notification['id']);
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(notification['title'] ?? 'No Title'),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification['message'] != null &&
                                            notification['message'].length > 30
                                        ? '${notification['message']}'
                                        : notification['message'] ??
                                            'No Message',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(notification['createdAt'] != null
                                      ? formatDate(notification['createdAt'])
                                      : '01/01/1900'),
                                ],
                              ),
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
