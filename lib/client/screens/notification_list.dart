import 'package:flutter/material.dart';
import 'package:flutter_application_1/server/UserService.dart';
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
          SnackBar(content: Text('Không thể tải dữ liệu thông báo.')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo ',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10,
                    20), // điều chỉnh độ rộng của danh sách thông báo
                child: ListView.builder(
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final notification = _notifications[index];
                    return Container(
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
                                  : notification['message'] ?? 'No Message',
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(notification['createdAt'] != null
                                ? formatDate(notification['createdAt'])
                                : '01/01/1900'),
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
