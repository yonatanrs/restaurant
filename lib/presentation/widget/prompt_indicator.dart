import 'package:flutter/material.dart';
import 'package:restaurant/misc/ext/string_ext.dart';

class PromptIndicator extends StatelessWidget {
  final Image? image;
  final Widget? Function(BuildContext, Image?)? imageBuilder;
  final String? promptTitleText;
  final String? promptText;
  final String? buttonText;
  final VoidCallback? onPressed;

  const PromptIndicator({
    Key? key,
    this.image,
    this.imageBuilder,
    this.promptTitleText,
    this.promptText,
    this.buttonText,
    this.onPressed
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget defaultImage = FittedBox(child: image);
    List<Widget> columnWidget = <Widget>[
      SizedBox(
        width: double.infinity,
        child: imageBuilder != null ? (imageBuilder!(context, image) ?? defaultImage) : defaultImage
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              promptTitleText ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center
            ),
            const SizedBox(height: 4.0),
            Text(promptText ?? "", style: const TextStyle(color: Colors.black), textAlign: TextAlign.center)
          ]
        ),
      ),
    ];
    if (onPressed != null) {
      columnWidget.addAll(
        <Widget>[
          const SizedBox(height: 10),
          SizedBox(
            width: 50,
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(buttonText.toEmptyStringNonNull),
            )
          ),
        ]
      );
    }
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: columnWidget,
      )
    );
  }
}