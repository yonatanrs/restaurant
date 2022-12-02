import 'picture_url_format_type.dart';

class _StringUtilImpl {
  String formatPictureUrl(String pictureUrl, PictureUrlFormatType pictureUrlFormatType) {
    if (Uri.tryParse(pictureUrl)?.hasAbsolutePath ?? false) {
      return pictureUrl;
    }
    late final String size;
    if (pictureUrlFormatType == PictureUrlFormatType.smallPictureResolution) {
      size = "small";
    } else if (pictureUrlFormatType == PictureUrlFormatType.mediumPictureResolution) {
      size = "medium";
    } else if (pictureUrlFormatType == PictureUrlFormatType.largePictureResolution) {
      size = "large";
    } else {
      size = "";
    }
    return (Uri.tryParse(pictureUrl)?.hasAbsolutePath ?? false) ? pictureUrl : "https://restaurant-api.dicoding.dev/images/$size/$pictureUrl";
  }
}

// ignore: non_constant_identifier_names
var StringUtil = _StringUtilImpl();