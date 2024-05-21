import 'dart:io';

import 'package:first_app/core/widgets/appbar_tittle.dart';
import 'package:first_app/core/widgets/button_text.dart';
import 'package:first_app/core/gen/fonts.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:first_app/core/gen/assets.gen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_filed.dart';
import '../core/widgets/custom_underline.dart';

void main() {
  runApp(const UpdateProfile());
}

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: FaIcon(Icons.arrow_back),
            onPressed: () {
              exit(0);
            },
          ),
          title: Stack(
            children: [
              AppbarTittle('Update Profile'),
              Underline(right: 77),
            ],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color:
                              Color(0xFFFFC746), // Set your desired color here
                          shape: BoxShape.circle,
                        ),
                      ),
                      Image(
                        image: Assets.assets.images.profile.provider(),
                        height: 75,
                        width: 80, // Using the image provider
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(
                                0xFF24786D), // Set your desired color here
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('First Name'),
                        CustomTextField(hintText: ''),
                        SizedBox(height: 15),
                        CustomText('Last Name'),
                        CustomTextField(hintText: ''),
                        SizedBox(height: 15),
                        CustomText('Phone Number'),
                        CustomTextField(hintText: ''),
                        SizedBox(height: 15),
                        CustomText('Select Gender'),
                        TextField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC1CAD0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF24786D),
                              ),
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            SizedBox(width: 15),
                                            IconButton(
                                              icon: FaIcon(
                                                  FontAwesomeIcons.xmark),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            SizedBox(width: 125),
                                            Text(
                                              'Select Gender',
                                              style: TextStyle(
                                                fontFamily: FontFamily.caros,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF000E08),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        ListTile(
                                          leading: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFF2F8F7),
                                            ),
                                            child: Icon(
                                              Icons.male,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          title: Text(
                                            'Male',
                                            style: TextStyle(
                                              fontFamily: FontFamily.caros,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF000E08),
                                            ),
                                          ),
                                          onTap: () {
                                            // Handle tapping on photo
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFF2F8F7),
                                            ),
                                            child: Icon(
                                              Icons.female,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          title: Text(
                                            'Female',
                                            style: TextStyle(
                                              fontFamily: FontFamily.caros,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF000E08),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 15),
                        CustomText('Date of Birth'),
                        TextField(
                          decoration: InputDecoration(
                            suffixIcon: Container(
                                height: 25,
                                width: 25,
                                padding: EdgeInsets.all(9.0),
                                child: Image(
                                  image:
                                      Assets.assets.images.calendar.provider(),
                                )),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC1CAD0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF24786D),
                              ),
                            ),
                          ),
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomButton(buttonText: 'Update Profile', url: '/'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _selectDate(BuildContext context) async {
  await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
}
