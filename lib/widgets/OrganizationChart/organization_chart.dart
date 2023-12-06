import 'package:app/models/user.dart';
import 'package:app/utils/classes/tree_node.dart';
import 'package:flutter/material.dart';

class OrganizationChart extends StatelessWidget {
  final TreeNode<UserModel> rootNode;

  OrganizationChart({Key? key, required this.rootNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  _buildNodeView(rootNode);
  }

  Widget _buildNodeView(TreeNode<UserModel> node) {
    return Column(
      children: [
        _buildNodeCard(node.object),
        if (node.children.isNotEmpty) ...[
          SizedBox(height: 10),
          Row(
            children: node.children.map(_buildNodeView).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildNodeCard(UserModel user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 20,
            ),
            Text(user.person.name!), // Assuming Person has a 'name' field
            Text(user.mainRole?.description ?? '', style: TextStyle(fontStyle: FontStyle.italic)), // Placeholder if no role
          ],
        ),
      ),
    );
  }
}
