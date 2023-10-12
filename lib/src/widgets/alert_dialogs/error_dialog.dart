import 'package:flutter/material.dart';
import 'package:flutter_marvel/src/errors/app_errors.dart';

class ErrorDialog {
  static show(BuildContext context, {required AppError error}) {
    bool isOpened = false;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error Message'),
          content: StatefulBuilder(builder: (context, dialogState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SelectableText(error.message!),
                  ExpansionPanelList(
                    expansionCallback: (index, isExpanded) {
                      dialogState(() {
                        isOpened = isExpanded;
                      });
                    },
                    elevation: 0,
                    expandedHeaderPadding: EdgeInsets.zero,
                    children: [
                      ExpansionPanel(
                        isExpanded: isOpened,
                        canTapOnHeader: true,
                        headerBuilder: (context, isExpanded) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Stack Trace:',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          );
                        },
                        body: SelectableText(
                          error.stackTrace!,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
