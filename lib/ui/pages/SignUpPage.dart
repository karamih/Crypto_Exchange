import 'package:exchange/ui/pages/homePage.dart';
import 'package:exchange/ui/pages/mainWrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../ui_helpers/themeSwitcher.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Color color = Theme.of(context).unselectedWidgetColor;
    Color btnColor = Theme.of(context).primaryColor;

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exchange 2Byte', style: textTheme.titleLarge),
        centerTitle: true,
        actions: const [ThemeSwitcher()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Lottie.asset('assets/images/waveloop.json',
                  fit: BoxFit.fill, width: width, height: 0.15 * height),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'SignUp',
                style: GoogleFonts.notoSansArabic(fontSize: 30, color: color),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      style: TextStyle(color: color),
                      controller: username,
                      decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(color: color),
                          prefixIcon: Icon(
                            Icons.person,
                            color: color,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter an Username';
                        } else if (value.length < 5) {
                          return 'Username must be more than 5 character.';
                        } else if (value.length > 12) {
                          return 'Maximum Username length is 12';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    TextFormField(
                      style: TextStyle(color: color),
                      controller: email,
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: color),
                          prefixIcon: Icon(
                            Icons.email,
                            color: color,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'email can not be empty';
                        } else if (!value.endsWith('@gmail.com')) {
                          return 'Enter a valid Email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    TextFormField(
                      style: TextStyle(color: color),
                      controller: password,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: color),
                          prefixIcon: Icon(
                            Icons.lock_open,
                            color: color,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: color,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password can not be empty';
                        } else if (value.length < 5) {
                          return 'At least size of password should be 5';
                        } else if (value.length > 12) {
                          return 'Maximum password length is 12';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    TextFormField(
                      style: TextStyle(color: color),
                      controller: confirmPassword,
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: color),
                          prefixIcon: Icon(
                            Icons.lock_open,
                            color: color,
                          ),
                          suffixIcon: Icon(Icons.visibility, color: color),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password can not be empty';
                        } else if (value != password.text) {
                          return 'Confirm Password must match with Password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Center(
              child: Text(
                'You are agree with our terms and policy',
                style: GoogleFonts.notoSansArabic(fontSize: 12, color: color),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SignUpBtn(color, btnColor),
            )
          ],
        ),
      ),
    );
  }

  Widget SignUpBtn(Color textColor, Color btnColor) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainWrapper()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: btnColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: Text('SignUp',
            style: GoogleFonts.notoSansArabic(fontSize: 15, color: textColor)),
      ),
    );
  }
}
