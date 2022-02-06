import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:moodbasemedia/activities/home.dart';
import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File? _image;

  /// Get from gallery
  _imgFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image as File;
    });
  }

  _imgFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image to Server"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        height: 300,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //content alignment to center
          children: <Widget>[
            Container(
                //show image here after choosing image
                child: _image == null
                    ? Container()
                    : //if uploadimage is null then show empty container
                    Container(
                        //elese show image here
                        child: SizedBox(
                        height: 150,
                        child: Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                        //load image from file
                      ))),
            Container(
                //show upload button after choosing image
                child: _image == null
                    ? Container()
                    : //if uploadimage is null then show empty container
                    Container(
                        //elese show uplaod button
                        child: RaisedButton.icon(
                        onPressed: () {
                          //uploadImage();
                          _imgFromGallery();
                          //start uploading image
                        },
                        icon: Icon(Icons.file_upload),
                        label: Text("UPLOAD IMAGE"),
                        color: Colors.deepOrangeAccent,
                        colorBrightness: Brightness.dark,
                        //set brghtness to dark, because deepOrangeAccent is darker coler
                        //so that its text color is light
                      ))),
            Container(
              child: RaisedButton.icon(
                onPressed: () {
                  _imgFromGallery(); // call choose image function
                },
                icon: Icon(Icons.folder_open),
                label: Text("CHOOSE IMAGE"),
                color: Colors.deepOrangeAccent,
                colorBrightness: Brightness.dark,
              ),
            )
          ],
        ),
      ),
    );
  }
}
