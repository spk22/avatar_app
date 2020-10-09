import 'package:avatar_back4app/services/parse/image_picker_service.dart';
import 'package:avatar_back4app/services/parse/parse_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class Avatar extends StatelessWidget {
  final bool hasImage;
  final User user;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback onPressed;

  const Avatar({
    Key key,
    @required this.user,
    @required this.radius,
    this.borderColor,
    this.borderWidth,
    this.onPressed,
    this.hasImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _borderDecoration(),
      child: InkWell(
        onTap: onPressed,
        child: buildImage(context, user, radius, hasImage),
      ),
    );
  }

  Decoration _borderDecoration() {
    if (borderColor != null && borderWidth != null) {
      return BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      );
    }
    return null;
  }

  Widget buildImage(
      BuildContext context, User user, double radius, bool hasImage) {
    final picker = Provider.of<ImagePickerService>(context, listen: false);
    if (hasImage) {
      return FutureBuilder<ParseFileBase>(
        future: picker.getParseImage(context, user),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot<ParseFileBase> snapshot) {
          if (snapshot.hasData) {
            // return Image.file((snapshot.data as ParseFile).file);
            return CircleAvatar(
              radius: radius,
              backgroundColor: Colors.black12,
              backgroundImage: (hasImage)
                  ? FileImage((snapshot.data as ParseFile).file)
                  : null,
              child: (!hasImage) ? Icon(Icons.camera_alt, size: radius) : null,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.black12,
        backgroundImage: null,
        child: Icon(Icons.camera_alt, size: radius),
      );
    }
  }
}
