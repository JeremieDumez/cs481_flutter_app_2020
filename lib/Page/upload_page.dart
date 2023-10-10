import 'dart:io';
import 'package:app/globals.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/Networking/APIRequest.dart';
import 'package:flutter_gen/gen_l10n/localization.dart';

class UploadPage extends StatefulWidget {
  UploadPage();
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File _image;
  final picker = ImagePicker();
  final bytes = null;
  String sentence;

  void uploadImage(BuildContext context) async {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).accentColor,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: FileImage(_image))),
                    )),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).accentColor,
                      child: Text(AppLocalizations.of(context).uploadGallery),
                      onPressed: () {
                        postImage(_image, accessToken).then((resp) {
                          print(resp);
                          if (resp == true)
                            setState(() {
                              _image = null;
                              sentence =
                                  AppLocalizations.of(context).imageSuccess;
                            });
                          Navigator.of(context).pop();
                        });
                      },
                    )),
              ]));
        }).then((value) {
      final snackBar = SnackBar(
        content: Text(AppLocalizations.of(context).snackbarUpload),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null)
        _image = File(pickedFile.path);
      else
        print('No image selected.');
    });
  }
  //

  @override
  Widget build(BuildContext context) {
    sentence = AppLocalizations.of(context).noImageSelected;
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Padding(
              padding: EdgeInsets.all(8),
              child: Text(sentence, textAlign: TextAlign.center)),
          Padding(
              padding: EdgeInsets.all(8),
              child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).accentColor,
                  child: Text(AppLocalizations.of(context).pickImage),
                  onPressed: () {
                    getImage().then((value) {
                      if (_image != null) {
                        uploadImage(context);
                      }
                    });
                  })),
        ]));
  }
}
