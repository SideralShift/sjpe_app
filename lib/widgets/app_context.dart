import 'package:app/models/person.dart';
import 'package:app/models/user.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/services/user_service.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppContext extends ChangeNotifier {
  UserModel loggedUser = UserModel(person: Person(id: 1, name: ''), roles: []);

  getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String userId = prefs.get("userId") as String;
    loggedUser = await UserService.getUserByIdSJPE(userId) ?? loggedUser;
    loggedUser.profilePictureImage = await StorageService.getImage(path: (loggedUser.profilePictureUrl)!);
    notifyListeners();
  }

  cleanUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('idToken');
    prefs.remove('userId');
  }
}
