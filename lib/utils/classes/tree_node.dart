import 'package:flutter/material.dart';

class TreeNode<T> {
  T object;
  final List<TreeNode<T>> children;
  GlobalKey globalKey;

  TreeNode(this.object, [this.children = const [], GlobalKey? key])
      : globalKey = key ?? GlobalKey();
}
