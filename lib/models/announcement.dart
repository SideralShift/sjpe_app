import 'package:app/models/user.dart';

class Announcement {
  UserModel? user;
  String body;
  String? title;
  DateTime? createdAt;

  Announcement({this.user, required this.body, this.title, this.createdAt});
}
