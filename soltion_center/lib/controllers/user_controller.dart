
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/connection_controller.dart';
import 'package:soltion_center/models/user_model.dart';
import 'package:soltion_center/services/auth_service.dart';
import 'package:soltion_center/units/constant_units.dart';
import 'package:soltion_center/view/widgets/dialog/logout_dialog.dart';

class UserController with ChangeNotifier {
  final themeBox = Hive.box('theme');
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  UserModel? currentUser;

  String message = 'error';
  bool _isLogin = true;
  bool _isFilled = false;
  bool _isLoading = false;
  bool _passwordView = true;

  bool get getPasswordView => _passwordView;

  bool get getIsLogin => _isLogin;

  bool get getIsLoading => _isLoading;

  bool get getIsFilled => _isFilled;


  setPasswordView() {
    _passwordView = !_passwordView;
    notifyListeners();
  }

  set setIsLoading(bool condition) {
    _isLoading = condition;
  }

  set setIsFilled(bool condition) {
    _isFilled = condition;
    notifyListeners();
  }

  String get getThemeMode =>
      themeBox.get('currentTheme', defaultValue: 'system');

  set setThemeMode(String newThemeMode) {
    if (getThemeMode != newThemeMode) {
      themeBox.put('currentTheme', newThemeMode);
      notifyListeners();
    }
  }

  void isNotBlank() {
    if (!_isLogin) {
      if (usernameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        _isFilled = false;
        notifyListeners();
      } else {
        _isFilled = true;
        notifyListeners();
      }
    } else {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        _isFilled = false;
        notifyListeners();
      } else {
        _isFilled = true;
        notifyListeners();
      }
    }
  }

  setIsLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  void currentMessage(String currentMessage) {
    message = currentMessage;
    notifyListeners();
  }

  bool isAdmin() {
    getUserInfo();
    //print('${currentUser!.admin}');
    if (currentUser != null) {
      if (currentUser!.admin!) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<UserModel> getUserInfo() async {
    var user =
    await _authService.getUserInfo(_authService.getCurrentUser()!.uid);
    _updateUser(user!);
    return user;
  }

  void _updateUser(UserModel user) {
    currentUser = user;
    notifyListeners();
  }

  void signIn(BuildContext context) async {
    setIsLoading = true;
    notifyListeners();
    await _authService
        .signIn(emailController.text, passwordController.text, context)
        .whenComplete(
          () {
        showSnackbar(context, message);

      },
    ).then((value) async {
      if (value == true) {
        await _authService
            .getUserInfo(_authService.getCurrentUser()!.uid)
            .then((user) {
          _updateUser(user!);
          usernameController.clear();
          emailController.clear();
          passwordController.clear();
          setIsFilled = false;
          _authSuccess(context);
          setIsLoading = false;
        });
      }else {
        setIsLoading = false;
      }
    });
  }

  Future<void> signOut(BuildContext context) async {
    await _authService.signOut(context).whenComplete(
          () {
        showSnackbar(context, message);
      },
    ).then((value) => value
        ? Navigator.of(context).pushReplacementNamed(
        '/SignIn')
        : null);
    currentUser = null;
    notifyListeners();
  }

  void _authSuccess(BuildContext context) {
    Navigator.of(context)
        .pushReplacementNamed('/Home');
  }

  void register(BuildContext context) async {
    UserModel user = UserModel(
      username: usernameController.text.trim(),
      email: emailController.text,
      password: passwordController.text,
      admin: false,
    );
    setIsLoading = true;
    notifyListeners();
    await AuthService().signUp(user, context).whenComplete(
          () {
        showSnackbar(context, message);
      },
    ).then((value) {
      if (value) {
        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        _isLogin = true;
        _updateUser(user);
        setIsFilled = false;
        _authSuccess(context);
        setIsLoading = false;
      }
    });
  }

  void logoutDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: context.read<ConnectionController>().getIsConnected == false
          ? Colors.transparent
          : Theme.of(context).shadowColor.withOpacity(0.7),
      context: context,
      builder: (context) => const LogoutDialog(),
    );
  }
}
