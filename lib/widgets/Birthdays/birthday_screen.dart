import 'package:app/utils/app_colors.dart';
import 'package:app/widgets/Birthdays/birthday_list.dart';
import 'package:flutter/material.dart';
import 'package:app/models/user.dart';
import 'package:app/services/user_service.dart';
import 'package:google_fonts/google_fonts.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({Key? key}) : super(key: key);

  @override
  BirthdayScreenState createState() => BirthdayScreenState();
}

class BirthdayScreenState extends State<BirthdayScreen> {
  late Future<List<UserModel>> usersFuture;
  DateTime currentDate = DateTime.now(); // Obtener la fecha y hora actual

  @override
  void initState() {
    super.initState();
    usersFuture = _getUsersBirthdays();
  }

  Future<List<UserModel>> _getUsersBirthdays() async {
    List<UserModel> fetchedUsers = await UserService.getUsersBirthdays();
    List<Future<void>> pictureLoadingJobs = fetchedUsers.map((user){
      return UserService.loadUserProfilePicture(user).catchError((e){ print(user.profilePictureUrl);});
    }).toList();

    await Future.wait(pictureLoadingJobs);

    return fetchedUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppStyles.mainBackgroundColor,
          foregroundColor: Colors.black,
          title: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text('Cumpleaños',
                style: GoogleFonts.openSans(
                    color:
                        Colors.black, // Change this color to your desired color
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          )),
      body: FutureBuilder<List<UserModel>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No se encontraron usuarios.');
          } else {
            List<UserModel> users = snapshot.data!; //final list User
            Map<int, List<UserModel>> groupedBirthdays = UserService.groupUsersBirthdays(users);

            return BirthdaysListWidget(groupedBirthdays: groupedBirthdays);
          }
        },
      ),
    );
  }
}
