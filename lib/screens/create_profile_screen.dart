import 'package:test_app/utils/utils.dart';
import '/responsive/mobile_screen_layout.dart';
import '/responsive/responsive_layout.dart';
import '/responsive/web_screen_layout.dart';
import '/resources/auth_methods.dart';
import '/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:typed_data';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _deptarmentcontroller = TextEditingController();
  final TextEditingController _phonenumbercontroller = TextEditingController();
  String? dropdownValue;
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _phonenumbercontroller.dispose();
    _emailcontroller.dispose();
    _deptarmentcontroller.dispose();
  }
  void saveprofile() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().save(
        name: _namecontroller.text,
        email: _emailcontroller.text,
        department: _deptarmentcontroller.text,
        gender: dropdownValue!,
        phonenumber: _phonenumbercontroller.text,
        file: _image!);
    if (context.mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
       showSnackBar(context, res);
      }
    }
  }

  
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: Column(children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Image.asset("assets/4.png", color: secondaryColor),
                            const SizedBox(
                              height: 30,
                            ),
                            Stack(
                              children: [
                                _image != null
                                    ? CircleAvatar(
                                        radius: 64,
                                        backgroundImage: MemoryImage(_image!),
                                      )
                                    : const CircleAvatar(
                                        radius: 64,
                                        backgroundColor: boxColor,
                                        child: Text(
                                          "Upload Image",
                                          style:
                                              TextStyle(color: secondaryColor),
                                        ),
                                      ),
                                Positioned(
                                    bottom: 0,
                                    left: 80,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: boxColor),
                                      child: IconButton(
                                        onPressed: selectImage,
                                        icon: const Icon(Icons.add_a_photo),
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 40),
                                child: Form(
                                    child: Column(children: <Widget>[
                                  TextFormField(
                                    controller: _namecontroller,
                                    decoration:
                                        const InputDecoration(hintText: 'Name'),
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  TextFormField(
                                      controller: _emailcontroller,
                                      decoration: const InputDecoration(
                                          hintText: 'Email'),
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next),
                                  TextFormField(
                                      controller: _deptarmentcontroller,
                                      decoration: const InputDecoration(
                                          hintText: 'Department'),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next),
                                  DropdownButtonFormField<String>(
                                    hint: const Text('Gender'),
                                    value: dropdownValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>['Male', 'Female', 'Other']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  TextFormField(
                                    controller: _phonenumbercontroller,
                                    decoration: const InputDecoration(
                                        hintText: 'Phone Number'),
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap:saveprofile,
                                    child: Container(
                                        width: 150, //change this for web
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 1),
                                        decoration: const ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(1))),
                                          color: blueColor,
                                        ),
                                        child: !_isLoading
                                            ? const Text(
                                                'Save Profile',
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 17),
                                              )
                                            : const CircularProgressIndicator(
                                                color: primaryColor,
                                              )),
                                  ),
                                ])))
                          ]))
                    ])))));
  }
}
