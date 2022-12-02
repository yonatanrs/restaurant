import 'package:flutter/material.dart';

import '../../../misc/errorprovider/error_provider.dart';
import '../../../misc/load_data_result.dart';
import 'base_load_data_result_implementer.dart';

typedef OnImplementLoadDataResultDirectly<T> = Widget Function(LoadDataResult<T>, ErrorProvider);

class LoadDataResultImplementerDirectly<T> extends BaseLoadDataResultImplementer<T> {
  final OnImplementLoadDataResultDirectly<T>? onImplementLoadDataResultDirectly;

  const LoadDataResultImplementerDirectly({
    Key? key,
    required LoadDataResult<T> loadDataResult,
    required ErrorProvider errorProvider,
    this.onImplementLoadDataResultDirectly
  }): super(
    key: key,
    loadDataResult: loadDataResult,
    errorProvider: errorProvider
  );

  @override
  Widget build(BuildContext context) {
    if (onImplementLoadDataResultDirectly != null) {
      return onImplementLoadDataResultDirectly!(loadDataResult, errorProvider);
    } else {
      return Container();
    }
  }
}