import 'package:app_posto_el/src/pages/login/controller/login_controller.dart';
import 'package:app_posto_el/src/pages/login/controller/login_settings.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class LoginInputButtonWidget extends StatefulWidget {
  LoginInputButtonWidget({Key? key}) : super(key: key);

  @override
  State<LoginInputButtonWidget> createState() => _LoginInputButtonWidgetState();
}

class _LoginInputButtonWidgetState extends State<LoginInputButtonWidget> {
  final controllerLogin = LoginController();
  final LoginSettings settings = LoginSettings();
  late Map<String, String> logado;
  var visiblePassword = false;
  var controller = MaskedTextController(mask: '00.000.000/0000-00');

  @override
  void initState() {
    autorun((_) {
      if (controllerLogin.status == LoginStatus.success) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (controllerLogin.status == LoginStatus.error) {
        BotToast.showText(
          text: 'Não Foi Possivel Fazer Login.\n Verifique seus Dados.',
          contentColor: Color(0xffcf1f36),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        backgroundColor: AppTheme.colors.backgroundPrimary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Entre com sua conta',
                  style: AppTheme.textStyles.title
                      .copyWith(fontSize: 14, color: Colors.black)),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xFF666666).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  onChanged: (value) {
                    controllerLogin.onChanged(cnpj: value);
                  },
                  controller: controller,
                  keyboardType: TextInputType.number,
                  cursorColor: AppTheme.colors.primaryColor,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'CNPJ',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xFF666666).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  textCapitalization: TextCapitalization.characters,
                  initialValue: controllerLogin.user.login,
                  onChanged: (value) {
                    controllerLogin.onChanged(login: value);
                  },
                  cursorColor: AppTheme.colors.primaryColor,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Login',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xFF666666).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  textCapitalization: TextCapitalization.characters,
                  initialValue: controllerLogin.user.senha,
                  onChanged: (value) {
                    controllerLogin.onChanged(senha: value);
                  },
                  obscureText: !visiblePassword,
                  cursorColor: AppTheme.colors.primaryColor,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.remove_red_eye,
                        color: visiblePassword
                            ? AppTheme.colors.secondaryColor
                            : Color(0xFF666666),
                      ),
                      onTap: () {
                        visiblePassword = !visiblePassword;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  controllerLogin.status == LoginStatus.empty ||
                          controllerLogin.status == LoginStatus.error
                      ? Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromHeight(45),
                                primary: Color(0xffcf1f36)), //Color(0xFF1E319D)
                            onPressed: () {
                              controllerLogin.login();
                              //Navigator.pushNamed(context, '/dashboard');
                            },
                            child: Text('Entrar'),
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color(0xffcf1f36),
                            ),
                          ),
                        )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Não tem uma conta?',
                        style: AppTheme.textStyles.title
                            .copyWith(fontSize: 12, color: Color(0xFF525252))),
                    TextSpan(
                        text: ' Entre em contato conosco.',
                        style: AppTheme.textStyles.title
                            .copyWith(fontSize: 12, color: Color(0xFF525252)))
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
