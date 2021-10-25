import 'package:app_posto_el/src/pages/login/widgets/login_input_button_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginPageWidiget extends StatefulWidget {
  const LoginPageWidiget({Key? key}) : super(key: key);

  @override
  State<LoginPageWidiget> createState() => _LoginPageWidigetState();
}

class _LoginPageWidigetState extends State<LoginPageWidiget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppTheme.colors.backgroundPrimary,
        title: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Posto', style: AppTheme.textStyles.titleLogin),
                Text(
                  ' Plus',
                  style: AppTheme.textStyles.titleLogin.copyWith(
                    color: Color(0xFF525252),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: AppTheme.colors.backgroundPrimary,
      body: LoginInputButtonWidget(),
    );
  }
}
