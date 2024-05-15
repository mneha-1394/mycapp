import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/responsive/mobile_screen_layout.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../resources/firebase_methods.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class AddConcernScreen extends StatefulWidget {
  const AddConcernScreen({super.key});

  @override
  State<AddConcernScreen> createState() => _AddConcernScreenState();
}

class _AddConcernScreenState extends State<AddConcernScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  Uint8List? _file;
  bool image = false;
  bool isLoading = false;
  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _tagController.text,
        username,
        _file!,
        uid,
        profImage
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        if (context.mounted) {
          showSnackBar(
            context,
            'Posted!',
          );
        }
        clearImage();
      } else {
        if (context.mounted) {
          showSnackBar(context, res);
        }
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            )));
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: 
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                !image
                    ? Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.grey),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => _selectImage(context),
                                icon: const Icon(Icons.upload)),
                            const Text(
                              "Image/Video",
                              style: TextStyle(),
                            )
                          ],
                        ))
                    : SizedBox(
                        height: 200,
                        width: 400,
                        child: Image(
                          image: MemoryImage(_file!),
                          fit: BoxFit.cover,
                        )),
                const SizedBox(height: 30),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: "Description",
                  ),
                  maxLines: 2,
                  textInputAction: TextInputAction.newline,
                ),
                TextField(
                  controller: _tagController,
                  decoration: const InputDecoration(
                    hintText: "Tag Concerned Authority",
                  ),
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () => postImage(userProvider.getUser!.uid,
                      userProvider.getUser!.name, userProvider.getUser!.photoUrl),
                  child: Container(
                      width: 150, //change this for web
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 1),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(1))),
                        color: blueColor,
                      ),
                      child: !isLoading
                          ? const Text(
                              'Upload Concern',
                              style:
                                  TextStyle(color: primaryColor, fontSize: 17),
                            )
                          : const CircularProgressIndicator(
                              color: primaryColor,
                            )),
                ),
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
              ],
            )),
      ),
    );
  }
}
