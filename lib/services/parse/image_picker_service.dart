import 'dart:io';

import 'package:avatar_back4app/services/parse/parse_auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class ImagePickerService {
  // returns a PickedFile object pointing to the image that was picked
  Future<PickedFile> _pickImage({@required ImageSource source}) async {
    return ImagePicker().getImage(source: source);
  }

  Future<bool> uploadParseImage(BuildContext context, User user) async {
    final selectedImage = await _pickImage(source: ImageSource.gallery);
    ParseFileBase parseFile = ParseFile(File(selectedImage.path));
    final auth = Provider.of<ParseAuthService>(context, listen: false);
    ParseUser parseUser = await auth.getParseUser(user);
    parseUser.set("image", parseFile);
    final response = await parseUser.save();
    return response.success;
  }

  Future<ParseFileBase> getParseImage(BuildContext context, User user) async {
    final auth = Provider.of<ParseAuthService>(context, listen: false);
    ParseUser parseUser = await auth.getParseUser(user);
    return parseUser.get<ParseFileBase>("image").download();
  }
}
