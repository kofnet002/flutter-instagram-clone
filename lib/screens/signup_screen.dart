// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously, deprecated_member_use, library_private_types_in_public_api, use_super_parameters

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/response_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

// to clear the controllers when done
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);

    setState(() {
      _isLoading = false;
    });

    if (res != 'Successfully registered') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              )));
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      // svg
                      SvgPicture.asset(
                        'assets/ic_instagram.svg',
                        color: primaryColor,
                        height: 64,
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      // circular widget to accept and show our selected file
                      SizedBox(
                        height: 130,
                        child: Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : const CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                        'https://www.mtsolar.us/wp-content/uploads/2020/04/avatar-placeholder.png'),
                                  ),
                            Positioned(
                                bottom: -10,
                                left: 80,
                                child: IconButton(
                                  onPressed: selectImage,
                                  icon: Icon(Icons.add_a_photo),
                                ))
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      // username input
                      TextFieldInput(
                          textEditingController: _usernameController,
                          hintText: 'Enter your usernanme',
                          textInputType: TextInputType.text),

                      // spacing between the fields
                      const SizedBox(
                        height: 24,
                      ),

                      // email input
                      TextFieldInput(
                          textEditingController: _emailController,
                          hintText: 'Enter your email',
                          textInputType: TextInputType.emailAddress),

                      // spacing between the fields
                      const SizedBox(
                        height: 24,
                      ),

                      // password input
                      TextFieldInput(
                        textEditingController: _passwordController,
                        hintText: 'Enter your password',
                        textInputType: TextInputType.visiblePassword,
                        isPass: true,
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      // bio input
                      TextFieldInput(
                        textEditingController: _bioController,
                        hintText: 'Enter your bio',
                        textInputType: TextInputType.text,
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      // login button
                      InkWell(
                        onTap: signUpUser,
                        child: Container(
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                )
                              : const Text('Sign up'),
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              )),
                              color: blueColor),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: const Text("Already have an account? "),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          GestureDetector(
                            onTap: navigateToLogin,
                            child: Container(
                              child: const Text(
                                "Login",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // bottomSheet: Wrap(
        //   children: [
        //     Container(
        //       color: mobileBackgroundColor,
        //       child: Column(children: [
        //         // transitioning to signup
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Container(
        //               child: const Text("Already have an account? "),
        //               padding: const EdgeInsets.symmetric(vertical: 8),
        //             ),
        //             GestureDetector(
        //               onTap: navigateToLogin,
        //               child: Container(
        //                 child: const Text(
        //                   "Login",
        //                   style: TextStyle(fontWeight: FontWeight.bold),
        //                 ),
        //                 padding: const EdgeInsets.symmetric(vertical: 8),
        //               ),
        //             ),
        //           ],
        //         )
        //       ]),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
