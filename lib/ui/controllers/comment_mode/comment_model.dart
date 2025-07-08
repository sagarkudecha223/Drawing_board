import 'package:flutter/material.dart';

class CommentModel {
  Offset position;
  final String initial;
  final List<String> comments;
  final GlobalKey globalKey;

  CommentModel(
      {required this.position,
      required this.initial,
      required this.comments,
      required this.globalKey});
}
