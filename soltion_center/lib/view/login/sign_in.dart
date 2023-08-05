import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:flutter/material.dart';
import 'package:soltion_center/controllers/user_controller.dart';
import 'package:soltion_center/units/logo.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userController = Provider.of<UserController>(context, listen: true);
    final lang = Provider.of<LocalizationController>(context, listen: true)
        .getLanguage();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<LocalizationController>(context, listen: false)
                  .getLanguageDialog(context);
            },
            icon: Icon(
              Icons.language_outlined,
              color: theme.colorScheme.primary,
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomPaint(
              size: Size(175, (175 * 1).toDouble()),
              painter: AppLogo(),
            ),
            Text(
              lang.appTitle!,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      lang.login!,
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: lang.email,
                          hintText: lang.enterYourEmail,
                        ),
                        validator: (value) {
                          String pattern =
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.edu(\.[a-zA-Z]{2,})?$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value!)) {
                            return lang.validSchoolEmail;
                          } else {
                            return null;
                          }
                        },
                        controller: userController.emailController),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        obscureText: userController.getPasswordView,
                        decoration: InputDecoration(
                          labelText: lang.password,
                          hintText: lang.enterYourPassword,
                          suffix: IconButton(
                            icon: Icon(userController.getPasswordView == true
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              userController.setPasswordView();
                            },
                          ),
                        ),
                        validator: (value) {
                          String pattern =
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value!)) {
                            return lang.passwordRules;
                          } else {
                            return null;
                          }
                        },
                        controller: userController.passwordController),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RawMaterialButton(
                        fillColor: theme.colorScheme.surfaceTint,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed: () {
                          userController.setIsFilled =
                              _formKey.currentState!.validate();
                          if (_formKey.currentState!.validate() &&
                              userController.getIsLoading == false) {
                            userController.signIn(context);
                          }
                        },
                        child: userController.getIsLoading
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0,
                                  vertical: 8,
                                ),
                                child: LinearProgressIndicator(
                                  color: theme.colorScheme.onPrimary,
                                ),
                              )
                            : Text(
                                lang.login!,
                                style: TextStyle(
                                    color: theme.colorScheme.onPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/SignUp');
                      },
                      child: Text(
                        lang.createNewAccount!,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
