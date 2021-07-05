import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:q8uc/ui/screens/profile/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Image image;

  pickImage(ImageSource source) async {
    final _image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) return;
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(_image.path);

    // if (_image != null) {
    //   setState(() {
    //     image = Image.file(_image);
    //   });
    //   ImageSharedPrefs.saveImageToPrefs(
    //       ImageSharedPrefs.base64String(_image.readAsBytesSync()));
    // } else {
    //   print('Error picking image!');
    // }
  }

  loadImageFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final imageKeyValue = prefs.getString(IMAGE_KEY);
    if (imageKeyValue != null) {
      final imageString = await ImageSharedPrefs.loadImageFromPrefs();
      setState(() {
        image = ImageSharedPrefs.imageFrom64BaseString(imageString);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadImageFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              ImageSharedPrefs.emptyPrefs();
              setState(() {
                image = null;
              });
            },
          ),
        ],
        title: Text('Image Shared Preferences'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: image == null ? Text('No image selected') : image,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new ListTile(
                        leading: new Icon(Icons.camera),
                        title: new Text('Camera'),
                        onTap: () {
                          pickImage(ImageSource.camera);
                          // this is how you dismiss the modal bottom sheet after making a choice
                          Navigator.pop(context);
                        },
                      ),
                      new ListTile(
                        leading: new Icon(Icons.image),
                        title: new Text('Gallery'),
                        onTap: () {
                          pickImage(ImageSource.gallery);
                          // dismiss the modal sheet
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
