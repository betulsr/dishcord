import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:dishcord/log_in/auth/auth_state.dart';
import 'package:dishcord/widgets/auth/auth_messages.dart';
import 'package:dishcord/widgets/auth/login_set.dart';
import 'package:dishcord/widgets/auth/signup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final String title;

  LoginPage({Key key, this.title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    final vm = Provider.of<LoginViewModel>(context, listen: false);
    vm.resetState();
  }

  void _handleCreateAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage(title: widget.title)),
    );
  }

  Widget _authScreen(BuildContext context, LoginViewModel viewModel) {
    if (viewModel.state.authStatus == AuthStatus.error) {
      Future.delayed(Duration.zero, () async {
        AuthDialog.show(context, viewModel.state.authError);
      });
    }

    return Container(
      color: Colors.blue.shade200,
      child: Padding(
        padding: EdgeInsets.only(left:29.0, top:0.0, right:29.0, bottom:00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'DISHCORD',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SizedBox(height: 39),
            Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 10),
            TextField(
              key: const ValueKey("email"),
              textInputAction: TextInputAction.next,
              obscureText: false,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.grey.shade100),
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              onChanged: (value) => viewModel.email = value,
            ),
            SizedBox(height: 10),
            TextField(
              key: const ValueKey("password"),
              obscureText: true,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.grey.shade100),
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (value) => viewModel.password = value,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                key: const ValueKey("signIn"),
                onPressed: () => viewModel.loginUser(),
                child: Text(
                  'Log in'.toUpperCase(),
                  style: TextStyle(color: Colors.grey.shade100),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  "Don\'t have an account? ",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey.shade100),
                ),
                TextButton(
                  key: const ValueKey("goCreate"),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 0, horizontal: 2)),
                  ),
                  onPressed: () => _handleCreateAccount(context),
                  child: Text(
                    "Create one here.",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) =>
              _authScreen(context, viewModel)),
    );
  }
}
