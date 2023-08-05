import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/user_controller.dart';
import 'package:soltion_center/units/logo.dart';
import '../../controllers/localization_controller.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocalizationController>(context, listen: true)
        .getLanguage();
    final userController = Provider.of<UserController>(context, listen: true);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
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
          child: Column(
            children: <Widget>[
              CustomPaint(
                size: Size(175, (175 * 1).toDouble()),
                painter: AppLogo(),
              ),
              Text(
                lang.appTitle!,
                style: const TextStyle(fontSize: 30),
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
                        lang.register!,
                        style: const TextStyle(fontSize: 30),
                      ),
                      TextFormField(
                        controller: userController.usernameController,
                        decoration:
                            InputDecoration(
                                labelText: lang.nameSurname,
                                hintText: lang.enterYourNameAndSurname,
                            ),
                        validator: (value) {
                          String pattern = r'^[a-zA-Z_ ]*$';
                          RegExp regex = RegExp(pattern);
                          if (value!.isEmpty) {
                            return lang.enterYourNameAndSurname;
                          } else if (!regex.hasMatch(value)) {
                            return lang.onlyLettersAndNoSpaces;
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: userController.emailController,
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
                      ),
                      TextFormField(
                        controller: userController.passwordController,
                        obscureText: userController.getPasswordView,
                        decoration: InputDecoration(
                            labelText: lang.password,
                             hintText: lang.enterYourPassword,
                          suffix:  IconButton(icon: Icon(userController.getPasswordView == true
                              ? Icons.visibility : Icons.visibility_off),onPressed: (){
                            userController.setPasswordView();
                          },),
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
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RawMaterialButton(
                          fillColor: theme.colorScheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: () {
                            userController.setIsFilled = _formKey.currentState!.validate();
                            if (_formKey.currentState!.validate() && userController.getIsLoading == false) {
                                userController.register(context);
                            }
                          },
                          child: userController.getIsLoading
                              ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 8,),
                                child: LinearProgressIndicator(color: theme.colorScheme.onPrimary,),
                              )
                              : Text(
                            lang.accept!,
                            style: theme.textTheme.bodyText1?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/SignIn');
                        },
                        child: Text(
                          lang.alreadyHaveAnAccount!,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
