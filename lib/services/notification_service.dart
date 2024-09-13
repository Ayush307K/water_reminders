import 'package:firebase_database/firebase_database.dart';

class NotificationService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child('notifications');

  Future<List<String>> getNotifications() async {
    DataSnapshot snapshot = (await _dbRef.once()) as DataSnapshot;
    List<String> notifications = [];
    if (snapshot.value != null) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      notifications = data.values.cast<String>().toList();
    }
    return notifications;
  }
}
