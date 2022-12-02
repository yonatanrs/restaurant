import 'package:flutter/material.dart';

import '../../../misc/errorprovider/error_provider.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/widget_helper.dart';
import 'base_load_data_result_implementer.dart';

typedef OnIsLoadingLoadDataResultWidget = Widget Function();
typedef OnSuccessLoadDataResultWidget<T> = Widget Function(T);
typedef OnFailedLoadDataResultWidget = Widget Function(ErrorProvider, dynamic, Widget);
typedef OnNoLoadingLoadDataResultWidget = Widget Function();

class LoadDataResultImplementer<T> extends BaseLoadDataResultImplementer<T> {
  final OnIsLoadingLoadDataResultWidget? onIsLoadingLoadDataResultWidget;
  final OnSuccessLoadDataResultWidget<T>? onSuccessLoadDataResultWidget;
  final OnFailedLoadDataResultWidget? onFailedLoadDataResultWidget;
  final OnNoLoadingLoadDataResultWidget? onNoLoadingLoadDataResultWidget;

  const LoadDataResultImplementer({
    Key? key,
    required LoadDataResult<T> loadDataResult,
    required ErrorProvider errorProvider,
    this.onIsLoadingLoadDataResultWidget,
    this.onSuccessLoadDataResultWidget,
    this.onFailedLoadDataResultWidget,
    this.onNoLoadingLoadDataResultWidget,
  }): super(
    key: key,
    loadDataResult: loadDataResult,
    errorProvider: errorProvider
  );

  @override
  Widget build(BuildContext context) {
    if (loadDataResult is IsLoadingLoadDataResult) {
      if (onIsLoadingLoadDataResultWidget != null) {
        return onIsLoadingLoadDataResultWidget!();
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    } else if (loadDataResult is SuccessLoadDataResult) {
      if (onSuccessLoadDataResultWidget != null) {
        return onSuccessLoadDataResultWidget!((loadDataResult as SuccessLoadDataResult).value);
      } else {
        return Container();
      }
    } else if (loadDataResult is FailedLoadDataResult) {
      dynamic e = (loadDataResult as FailedLoadDataResult).e;
      Widget defaultErrorPromptIndicator = WidgetHelper.buildFailedPromptIndicatorFromErrorProvider(context: context, errorProvider: errorProvider, e: e);
      if (onFailedLoadDataResultWidget != null) {
        return onFailedLoadDataResultWidget!(errorProvider, e, defaultErrorPromptIndicator);
      } else {
        return Center(child: defaultErrorPromptIndicator);
      }
    } else {
      if (onNoLoadingLoadDataResultWidget != null) {
        return onNoLoadingLoadDataResultWidget!();
      } else {
        return Container();
      }
    }
  }
}