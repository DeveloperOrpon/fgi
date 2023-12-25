import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';

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
    'icon': FontAwesomeIcons.elementor,
  },
  {
    'index': 3,
    "title": "Categories",
    'icon': Icons.category,
  },
  {
    'index': 5,
    "title": "Profile",
    'icon': FontAwesomeIcons.user,
  },
  {
    'index': 5,
    "title": 'WishList Product',
    'icon': FontAwesomeIcons.heart,
  } , {
    'index': 4,
    "title": "Log out",
    'icon': FontAwesomeIcons.signOut,
  }
];
var format = NumberFormat.simpleCurrency(locale: 'en');
 String currencySymbol=NumberFormat.simpleCurrency(locale: 'en').currencySymbol;
/// dialog time durations
const Duration SNACKBAR_DURATION=Duration(seconds: 3);
const SnackPosition SNACKBAR_POSITION= SnackPosition.BOTTOM;

///app variable
const String appName='FGI Y2J';
const String appMainLogo='assets/images/image1.png';


