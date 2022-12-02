import '../constant.dart';

extension StringExt on String? {
  bool get isEmptyString => this == null ? true : this!.trim().isEmpty;
  String get toEmptyStringNonNull => !isEmptyString ? this! : "";
  String get toStringNonNull => !isEmptyString ? this! : Constant.textEmpty;
  String toStringNonNullWithCustomText({String? text}) => !isEmptyString ? this! : (!text.isEmptyString ? text! : Constant.textEmpty);
}