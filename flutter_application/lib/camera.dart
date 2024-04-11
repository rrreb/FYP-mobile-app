import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePhotoPage extends StatefulWidget {
  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  File? _imageFile;

  Future<void> _takePhoto(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      }
    });
  }

  void _retakePhoto() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                width: 300,
                height: 300,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _takePhoto(ImageSource.camera),
              child: Text('Take Photo'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _takePhoto(ImageSource.gallery),
              child: Text('Select from Album'),
            ),
            if (_imageFile != null) SizedBox(height: 20),
            if (_imageFile != null)
              ElevatedButton(
                onPressed: _retakePhoto,
                child: Text('Retake Photo'),
              ),
          ],
        ),
      ),
    );
  }
}
