import 'package:ecom_app/screens/home.dart';
import 'package:ecom_app/screens/register.dart';
import 'package:ecom_app/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../constants/activate_constant.dart';
import '../providers/auth_provider.dart';
import 'package:snack/snack.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _visibility = true;
  bool actionLoading = false;

  void _visiblePassword() {
    setState(() {
      _visibility = !_visibility;
      // print(_visibility);
    });
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          actionLoading = true;
        });

        Provider.of<Auth>(context, listen: false).login({
          "email": _emailController.text,
          "password": _passwordController.text
        });

        _emailController.clear();
        _passwordController.clear();
        setState(() {
          actionLoading = false;
        });
        const SnackBar(
                backgroundColor: Color.fromARGB(255, 24, 166, 29),
                duration: Duration(milliseconds: 1000),
                content: Text("Login Success!"))
            .show(context);
        // showTopSnackBar(
        //   context,
        //   const CustomSnackBar.success(
        //     message: "Login Success!",
        //   ),
        // );
        //     Fluttertoast.showToast(
        //   msg: "Login Success!",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        // );

        // Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } catch (error) {
        setState(() {
          actionLoading = false;
        });
         const SnackBar(
                backgroundColor: Color.fromARGB(255, 166, 24, 34),
                duration: Duration(milliseconds: 1000),
                content: Text('Something went wrong. Please check your credentials and try again'))
            .show(context);
//         showTopSnackBar(
//     context,
//     const CustomSnackBar.error(
//       message:
//           "Something went wrong. Please check your credentials and try again",
//     ),
// );
        // MessageDialog.show(
        //     context, "Login Failed", "Invalid Credentials", "Try Again");
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
              SizedBox(
                width: size.width,
                height: size.height / 3,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SvgPicture.asset('assets/svg/add_to_cart.svg')),
              ),
              const SizedBox(height: 20),
              const Text(
                "Login",
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
                              "Login",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: activeTextStyle.registerText,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                            },
                            child: const Text(" Register"))
                      ],
                    )
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
