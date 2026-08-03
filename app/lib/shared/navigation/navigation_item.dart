import 'package:flutter/material.dart';

abstract class NavigationItem {
  String get id;

  String get title;

  IconData get icon;

  Widget get page;
}