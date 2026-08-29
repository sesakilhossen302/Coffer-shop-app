import 'package:get/get.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[
    NotificationModel(
      id: '1',
      title: "Today's Special",
      subtitle: 'Enjoy 20% off our Caramel Latte — available...',
      timeAgo: '1h',
      isRead: false,
    ),
    NotificationModel(
      id: '2',
      title: "Today's Special",
      subtitle: 'Enjoy 20% off our Caramel Latte — available...',
      timeAgo: '1h',
      isRead: false,
    ),
    NotificationModel(
      id: '3',
      title: "Today's Special",
      subtitle: 'Enjoy 20% off our Caramel Latte — available...',
      timeAgo: '1h',
      isRead: true,
    ),
    NotificationModel(
      id: '4',
      title: "Today's Special",
      subtitle: 'Enjoy 20% off our Caramel Latte — available...',
      timeAgo: '1h',
      isRead: true,
    ),
    NotificationModel(
      id: '5',
      title: "Today's Special",
      subtitle: 'Enjoy 20% off our Caramel Latte — available...',
      timeAgo: '1h',
      isRead: true,
    ),
  ].obs;

  void markAllAsRead() {
    for (var item in notifications) {
      item.isRead = true;
    }
    notifications.refresh();
  }

  void toggleReadState(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications[index].isRead = !notifications[index].isRead;
      notifications.refresh();
    }
  }

  void clearAll() {
    notifications.clear();
  }
}
