import 'package:ecom_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../constants/activate_constant.dart';
import '../providers/auth_provider.dart';
import '../widgets/gradient_button.dart';
import '../widgets/message_dialog.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool actionLoading = false;

  bool _visibility = true;
  void _visiblePassword() {
    setState(() {
      _visibility = !_visibility;
      // print(_visibility);
    });
  }

  bool isValidEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          actionLoading = true;
        });
        await Provider.of<Auth>(context, listen: false).register({
          "name": _nameController.text,
          "email": _emailController.text,
          "phone": _phoneController.text,
          "password": _passwordController.text,
        });
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _passwordController.clear();
        Fluttertoast.showToast(
          msg: "Success. You can login now",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );

        // Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
        setState(() {
          actionLoading = false;
        });
      } catch (error) {
        setState(() {
          actionLoading = false;
        });
        MessageDialog.show(
            context, error.toString(), "Sign Up Fails", "Try Again");
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SvgPicture.asset('assets/svg/shopping.svg'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: activeColors.primary.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.arrow_back,
                        color: activeColors.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Name",
                        prefixIcon: const Icon(
                          Icons.person_outlined,
                          // color: activeColors.primary,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Name is Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Email",
                        prefixIcon: const Icon(
                          Icons.alternate_email_outlined,
                          // color: activeColors.primary,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Email is Required";
                        } else if (!isValidEmail(val)) {
                          return "Please enter valid email address";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Phone",
                        prefixIcon: const Icon(
                          Icons.phone_outlined,
                          // color: activeColors.primary,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Phone is Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _visibility,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 3.0,
                            ),
                          ),
                          hintText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => _visiblePassword(),
                            icon: _visibility
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          )),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Password is Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GradientButton(
                      buttonText: actionLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: activeColors.whiteColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Submitting...",
                                  style: activeTextStyle.gradientBtnText,
                                ),
                              ],
                            )
                          : Text(
                              "Register",
                              style: activeTextStyle.gradientBtnText,
                            ),
                      btnWidth: size.width,
                      btnHeight: 50,
                      press: onSubmit,
                      btnTextStyle: activeTextStyle.gradientBtnText,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
