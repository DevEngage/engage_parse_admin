// import 'package:engage_fitness_app/appTheme.dart';
import 'package:games_revealed/theme.dart';
import 'package:admin/providers/user_provider.dart';
import 'package:admin/screens/home_screen.dart';
import 'package:admin/widgets/confirm_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  LoginScreen() {
    // _checkForUser();
  }

  _checkForUser() async {
    print(await ParseUser.currentUser());
    if (await ParseUser.currentUser() != null) {
      await Get.offNamed('/home');
    }
  }

  Future<String> register(UserProvider user, email, password) async {
    final res = await user.signUp(email, password);
    if (!res.success) return res.error.message;
    return null;
  }

  Future<String> login(UserProvider user, email, password) async {
    final res = await user.login(email, password);
    if (!res.success) return res.error.message;
    return null;
  }

  skipLogin(context, UserProvider user) async {
    confirmWidget(context,
        title: 'Warning!',
        message:
            'Your data will not be saved to an account and will be invalid after 1 year.',
        onAgreed: () async {
      await user.anonLogin();
      await _checkForUser();
    });
  }

  Future<String> _recoverPassword(UserProvider user, String name) async {
    final res = await user.requestPasswordReset(name);
    if (!res.success) return res.error.message;
    return null;
  }

  /* 
  
    EngageLoginScreen(
                  logo: Image.asset(
                    'assets/icon/logo.png',
                    fit: BoxFit.fitWidth,
                  ),
                  logoIcon: Image.asset(
                    'assets/icon/logo-icon.png',
                    width: 133,
                  ),
                  startBackground: AssetImage('assets/images/rope-pullup.jpg'),
                  loginBackground:
                      AssetImage('assets/images/lunge-with-dumbbell.jpg'),
                  signupBackground:w
                      AssetImage('assets/images/lunge-with-dumbbell.jpg'),
                  facebook: true,
                  google: true,
                  twitter: false,
                ),
   */

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.figmaDarkPurple,
      body: FlutterLogin(
        theme: LoginTheme(
          primaryColor: AppTheme.colorOrange,
          // buttonStyle: TextStyle(backgroundColor: AppTheme.figmaDarkPurple),
        ),
        title: 'Games Revealed',
        // logo: 'assets/icon/logo-icon.png',
        onLogin: (LoginData data) async =>
            await login(user, data.name.trim(), data.password),
        onSignup: (LoginData data) async =>
            await register(user, data.name.trim(), data.password),
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        },
        onRecoverPassword: (String name) => _recoverPassword(user, name),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Container(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         FlatButton(
      //             onPressed: () => skipLogin(context, user),
      //             child: Text('Skip Login')),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
