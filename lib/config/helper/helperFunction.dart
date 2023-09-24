import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../style/app_colors.dart';

Future<bool> onWillPop(BuildContext context) async {
  bool? exitResult = await showDialog(
    context: context,
    builder: (context) => _buildExitDialog(context),
  );
  return exitResult ?? false;
}

BackdropFilter _buildExitDialog(BuildContext context) {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
    child: AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Text(
        'Please confirm',
        style: TextStyle(color: Colors.black),
      ),
      content: const Text(
        'Do you want to exit the app?',
        style: TextStyle(color: Colors.red),
      ),
      actions: <Widget>[

        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.redAccent,
          ),
          child: const Text(
            'Yes',
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text(
            'No',
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

printLog(String message){
  log(message,time: DateTime.now(),name: "!!--DeveloperOrpon!!--",zone:Zone.current );
}