import 'package:flutter/material.dart';

import 'errorprovider/error_provider.dart';
import '../presentation/widget/prompt_indicator.dart';

class _WidgetHelperImpl {
  Widget buildPromptIndicator({
    required BuildContext context,
    Image? image,
    String? promptTitleText,
    String? promptText,
    String? buttonText,
    VoidCallback? onPressed
  }) {
    return PromptIndicator(
      image: image,
      imageBuilder: (context, image) {
        if (image == null) {
          return const Icon(Icons.error, size: 70);
        }
        return null;
      },
      promptTitleText: promptTitleText,
      promptText: promptText,
      buttonText: buttonText ?? "OK",
      onPressed: onPressed
    );
  }

  Widget buildFailedPromptIndicator({
    required BuildContext context,
    Image? image,
    String? promptTitleText,
    String? promptText,
    String? buttonText,
    VoidCallback? onPressed
  }) {
    return buildPromptIndicator(
      context: context,
      image: image,
      promptTitleText: promptTitleText,
      promptText: promptText,
      buttonText: buttonText,
      onPressed: onPressed
    );
  }

  Widget buildFailedPromptIndicatorFromErrorProvider({
    required BuildContext context,
    required ErrorProvider errorProvider,
    required dynamic e,
    String? buttonText,
    VoidCallback? onPressed
  }) {
    ErrorProviderResult? errorProviderResult = errorProvider.onGetErrorProviderResult(e);
    return buildPromptIndicator(
      context: context,
      image: errorProviderResult != null ? (errorProviderResult.imageAssetUrl.isEmpty ? null : Image.asset(errorProviderResult.imageAssetUrl)) : null,
      promptTitleText: errorProviderResult?.title,
      promptText: errorProviderResult?.message,
      buttonText: buttonText,
      onPressed: onPressed
    );
  }
}

// ignore: non_constant_identifier_names
var WidgetHelper = _WidgetHelperImpl();