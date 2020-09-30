import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  // returns a PickedFile object pointing to the image that was picked
  Future<PickedFile> pickImage({@required ImageSource source}) async {
    return ImagePicker().getImage(source: source);
  }
}
