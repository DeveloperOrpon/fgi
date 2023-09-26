import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';

final dashBoardDrawerOption = [
  {
    'index': 0,
    "title": "Dashboard",
    'icon': Icons.dashboard,
  },
  {
    'index': 1,
    "title": "Order History",
    'icon': Icons.list_alt,
  },
  {
    'index': 2,
    "title": "Products",
    'icon': Icons.category,
  },
  {
    'index': 3,
    "title": "Settings",
    'icon': Icons.settings_rounded,
  },
  {
    'index': 4,
    "title": "Log out",
    'icon': FontAwesomeIcons.signOut,
  }
];
var format = NumberFormat.simpleCurrency(locale: 'bn');
 String currencySymbol=NumberFormat.simpleCurrency(locale: 'bn').currencySymbol;
/// dialog time durations
const Duration SNACKBAR_DURATION=Duration(seconds: 3);
const SnackPosition SNACKBAR_POSITION= SnackPosition.BOTTOM;

