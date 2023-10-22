import 'package:caisseapp/widget/button_widget.dart';
import 'package:caisseapp/widget/text_field_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final FocusNode _emailFocusNode;
  late final TextEditingController _emailController;
  late final FocusNode _passwordFocusNode;
  late final TextEditingController _passwordController;
  bool _passwordSecure = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordController = TextEditingController();
    _passwordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  Future<void> _login() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xfff7f9f8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 282.47,
                  height: 364.8,
                  child: Image.asset(
                    "assets/login.png",
                    width: 282.47,
                    height: 364.8,
                  ),
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFieldWidget(
                          focusNode: _emailFocusNode,
                          textEditingController: _emailController,
                          isEnabled: true,
                          leftIcon: "assets/icons/mail.png",
                          label: "",
                          onEditingComplete: () {},
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your email";
                            } else if (!value.contains("@")) {
                              return "enter a correct email please";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFieldWidget(
                          focusNode: _passwordFocusNode,
                          textEditingController: _passwordController,
                          isEnabled: true,
                          securePassword: _passwordSecure,
                          hasLeftIcon: false,
                          rightIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _passwordSecure = !_passwordSecure;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "assets/icons/eye.png",
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                          leftIcon: "",
                          label: "",
                          onEditingComplete: () {},
                          validator: () {},
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              ButtonWidget(
                  widthPortion: 0.4,
                  color: const Color(0xff8FBC8F),
                  image: 'assets/icons/Done.png',
                  text: "Se connecter",
                  textColor: Colors.black,
                  onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
