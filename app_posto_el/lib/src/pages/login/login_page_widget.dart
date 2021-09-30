import 'package:app_posto_el/src/pages/login/widgets/login_input_button_widget.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginPageWidiget extends StatefulWidget {
  const LoginPageWidiget({Key key}) : super(key: key);

  @override
  State<LoginPageWidiget> createState() => _LoginPageWidigetState();
}

class _LoginPageWidigetState extends State<LoginPageWidiget> {
  FocusNode _node;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: 'Button');
    _node.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_node.hasFocus != _focused) {
      setState(() {
        _focused = _node.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _node.removeListener(_handleFocusChange);
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            child: Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: 'E', style: AppTheme.textStyles.title),
                  TextSpan(text: 'L', style: AppTheme.textStyles.title),
                  TextSpan(
                      text: ' Sistemas',
                      style: AppTheme.textStyles.title
                          .copyWith(color: Color(0xFF525252))),
                ]),
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(300),
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: AppTheme.colors.backgroundPrimary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Entre com sua Conta',
                  style: AppTheme.textStyles.title
                      .copyWith(fontSize: 14, color: Colors.black)),
              SizedBox(
                height: 15,
              ),
              LoginInputButtonWidget(),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Não tem uma conta?',
                      style: AppTheme.textStyles.title
                          .copyWith(fontSize: 12, color: Color(0xFF525252))),
                  TextSpan(
                      text: ' Entre em Contato conosco.',
                      style: AppTheme.textStyles.title
                          .copyWith(fontSize: 12, color: Color(0xFF525252)))
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
