import 'package:app/models/user.dart';
import 'package:app/services/user_service.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/filter.dart';
import 'package:app/utils/general_utils.dart';
import 'package:app/widgets/reusable/DataList/data_list.dart';
import 'package:app/widgets/reusable/DataList/radio_filter_list.dart';
import 'package:app/widgets/reusable/user_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MembersScreen extends StatefulWidget {
  MembersScreen({Key? key}) : super(key: key);

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  late Future<List<UserModel>> _usersFuture;
  List<UIFilter<UserModel>> selectedFilters = [];

  @override
  void initState() {
    super.initState();
    _usersFuture = getUsers();
  }

  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = await UserService.getAllUsers();
    await Future.wait(users.map((e) => UserService.loadUserProfilePicture(e)));
    return users;
  }

  void onSelectedFilterChanged(UIFilter<UserModel> filter) {
    setState(() {
      // Check if the selected filter is 'Cualquiera'
      if (filter.description == 'Cualquiera') {
        // Remove the filter from the same group, if it exists
        selectedFilters.removeWhere((f) => f.groupName == filter.groupName);
      } else {
        // Find the index of a filter from the same group as the new filter
        int existingFilterIndex =
            selectedFilters.indexWhere((f) => f.groupName == filter.groupName);

        if (existingFilterIndex != -1) {
          // Replace the existing filter from the same group
          selectedFilters[existingFilterIndex] = filter;
        } else {
          // Add the new filter to the list
          selectedFilters.add(filter);
        }
      }
    });

    // Additional logic to re-apply filters to your data list can go here
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
            child: Text('Lista de Jovenes',
                style: GoogleFonts.openSans(
                    color:
                        Colors.black, // Change this color to your desired color
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          )),
      body: FutureBuilder<List<UserModel>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return DataList<UserModel>(
                selectedFilters: selectedFilters,
                filters: [
                  RadioFilterList<UserModel>(
                    onSelectedFilterChanged: onSelectedFilterChanged,
                    groupName: 'Genero',
                    title: 'Genero',
                    filters: [
                      UIFilter<UserModel>(
                        groupName: 'Genero',
                        description: 'Hombre',
                        testFunction: (item) => item.person.gender == 1,
                      ),
                      UIFilter<UserModel>(
                        groupName: 'Genero',
                        description: 'Mujer',
                        testFunction: (item) => item.person.gender == 0,
                      )
                    ],
                    // Other properties and callbacks if needed
                  )
                ],
                items: snapshot.data!,
                itemBuilder: (context, user) {
                  return ListTile(
                    title: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: UserProfileAvatar(user: user),
                        ),
                        Text(user.person.getFullName())
                      ],
                    ),
                    // Add other user details here
                  );
                },
                itemFilter: (user, query) {
                  return GeneralUtils.fuzzySearch(user.person.name!, query);
                });
          } else {
            return Center(child: Text("No users found"));
          }
        },
      ),
    );
  }
}
