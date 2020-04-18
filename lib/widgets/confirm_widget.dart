import 'package:flutter/material.dart';

Future<void> confirmWidget(BuildContext context,
    {onAgreed,
    onCancled,
    title = '',
    message = '',
    confirmText = 'Confirm',
    warning = false}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              if (onCancled != null) onCancled();
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(confirmText,
                style: TextStyle(color: warning ? Colors.red : null)),
            onPressed: () {
              if (onAgreed != null) onAgreed();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
