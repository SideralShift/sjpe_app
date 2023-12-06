
import 'package:app/models/person.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/classes/tree_node.dart';
import 'package:app/widgets/OrganizationChart/organization_chart.dart';
import 'package:flutter/material.dart';

class OrganizationChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example users
    UserModel user1 = UserModel(
      roles: [],
      id: "1",
      person: Person(name: "Alice Smith"),
      profilePictureUrl: "assets/alice.png", 
    );

    UserModel user2 = UserModel(
      roles: [],
      id: "1",
      person: Person(name: "Alice Smaus"),
      profilePictureUrl: "assets/alice.png", 
    );

    UserModel user3 = UserModel(
      roles: [],
      id: "1",
      person: Person(name: "Alice Smausus"),
      profilePictureUrl: "assets/alice.png", 
    );

    // Example TreeNode structure
    TreeNode<UserModel> rootNode = TreeNode<UserModel>(
      user1,
      [
        TreeNode<UserModel>(
          user2,
          [TreeNode<UserModel>(
          user3,
        ),TreeNode<UserModel>(
          user3,
        ),TreeNode<UserModel>(
          user3,
        ),TreeNode<UserModel>(
          user3,
        ),]
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Organization Chart'),
      ),
      body: InteractiveViewer(
      constrained: false,
      boundaryMargin: EdgeInsets.all(100), // Adjust the margin as needed
      minScale: 0.1, // Adjust the minimum scale if needed
      maxScale: 5.0, // Adjust the maximum scale if needed
      child: OrganizationChart(rootNode: rootNode),
    ),
    );
  }
}
