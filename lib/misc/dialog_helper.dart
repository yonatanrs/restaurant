import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _DialogHelper {
  void customDialog(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Coming Soon!'),
            content: const Text('This feature will be coming soon!'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Coming Soon!'),
            content: const Text('This feature will be coming soon!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }
}

// ignore: non_constant_identifier_names
final DialogHelper = _DialogHelper();