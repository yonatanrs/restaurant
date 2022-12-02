import 'package:flutter/material.dart';

import '../../../misc/errorprovider/error_provider.dart';
import '../../../misc/load_data_result.dart';

abstract class BaseLoadDataResultImplementer<T> extends StatelessWidget {
  final LoadDataResult<T> loadDataResult;
  final ErrorProvider errorProvider;

  const BaseLoadDataResultImplementer({
    Key? key,
    required this.loadDataResult,
    required this.errorProvider,
  }): super(key: key);
}