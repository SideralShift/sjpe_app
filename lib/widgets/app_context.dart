import 'package:app/models/person.dart';
import 'package:app/models/user.dart';
import 'package:app/services/user_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppContext extends ChangeNotifier {
  UserModel loggedUser = UserModel(person: Person(id: 1, name: ''), roles: []);
  NetworkImage? profilePictureImage;

  getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    //String userId = prefs.get("userId") as String;
    String userId = 'sJSqd8AwOpdU5EqiB4EFQG0Xse03';
    loggedUser = await UserService.getUserByIdSJPE(userId) ?? loggedUser;
    String url = await FirebaseStorage.instance
        .ref()
        .child(loggedUser.profilePictureUrl!)
        .getDownloadURL();
    profilePictureImage = NetworkImage(url);
    notifyListeners();
  }
}
