import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PickedFile _image;
  final _picker = ImagePicker();
  Image imagesSave;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Styles.colorWhite,
      appBar: buildAppBar(context),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return Container(
              child: ListView(
                children: [
                  verticalSpaceLarge,
                  verticalSpaceLarge,
                  verticalSpaceLarge,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 0, bottom: 10),
                          child: imageprofile(snapshot)),
                    ],
                  ),
                  ProfileContainer(
                      icon: Icons.person,
                      title: 'Username',
                      subTitle: AppCache.getUser().username.toString()),
                  ProfileContainer(
                      icon: Icons.email,
                      title: 'Email',
                      subTitle: AppCache.getUser().email),
                  // ProfileContainer(
                  //     icon: Icons.phone,
                  //     title: 'Phone',
                  //     subTitle: !snapshot.hasData
                  //         ? user.phoneNumber
                  //         : null ?? '0'),
                  verticalSpaceLarge,
                  verticalSpaceLarge,
                  verticalSpaceLarge,
                ],
              ),
            );
          }),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Styles.colorWhite,
      iconTheme: IconThemeData(color: Styles.colorBlack),
      elevation: 0,
      title: CustomText(
        'Profiles',
        color: Styles.colorBlack,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
    );
  }

  Widget imageprofile(AsyncSnapshot snapshot) {
    final user = FirebaseAuth.instance.currentUser;

    return Center(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => bottomsheet()));
            },
            child: CircleAvatar(
                radius: 50,
                backgroundImage: snapshot.hasData
                    ? NetworkImage(user.photoURL)
                    : AssetImage('images/user.jpg')),
          ),
        ],
      ),
    );
  }

  void takephoto(ImageSource source) async {
    final imageFile = await _picker.getImage(source: source);
    setState(() {
      _image = imageFile;
    });
  }

  Widget bottomsheet() {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      height: 150,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                H2text(
                  text: 'Profile photo',
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Styles.appBackground1,
                    radius: 25,
                    child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          takephoto(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        color: Colors.white),
                  ),
                  H2text(text: 'camera')
                ],
              ),
              Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 25,
                    child: IconButton(
                        icon: Icon(Icons.image),
                        onPressed: () {
                          Navigator.pop(context);
                          takephoto(ImageSource.gallery);
                        },
                        color: Colors.white),
                  ),
                  H2text(text: 'gallery')
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class H2text extends StatelessWidget {
  String text;
  H2text({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  final icon;
  final String title;
  final String subTitle;

  const ProfileContainer({
    Key key,
    this.icon,
    this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        leading: Icon(
          icon,
          color: Styles.colorGrey.withOpacity(0.7),
        ),
        title: CustomText(
          '$title',
          fontSize: 12,
          color: Styles.colorBlack,
        ),
        subtitle:
            CustomText('$subTitle', fontSize: 16, color: Styles.appBackground1),
      ),
    );
  }
}
