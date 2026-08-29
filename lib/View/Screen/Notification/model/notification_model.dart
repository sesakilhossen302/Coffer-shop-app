class NotificationModel {
  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    this.isRead = false,
  });
}
