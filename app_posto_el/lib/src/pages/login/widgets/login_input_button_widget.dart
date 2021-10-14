import 'package:app_posto_el/src/pages/login/controller/login_controller.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
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
  late Map<String, String> logado;
  var visiblePassword = false;
  var controller = MaskedTextController(mask: '00.000.000/0000-00');
  FocusNode login = FocusNode();
  FocusNode senha = FocusNode();

  @override
  void initState() {
    autorun((_) {
      if (controllerLogin.status == LoginStatus.success) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (controllerLogin.status == LoginStatus.error) {
        BotToast.showText(
          text: 'Não Foi Possivel Fazer Login.\nVerifique seus Dados.',
          contentColor: Color(0xffcf1f36),
        );
      } else if (controllerLogin.status == LoginStatus.semInternet) {
        BotToast.showText(
          text: 'Celular sem Internet. Verifique sua Conexão.',
          contentColor: Color(0xFFFF7F26),
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
              TextFormField(
                onFieldSubmitted: (value) {
                  login.requestFocus();
                },
                onChanged: (value) {
                  controllerLogin.onChanged(cnpj: value);
                },
                controller: controller,
                keyboardType: TextInputType.number,
                cursorColor: AppTheme.colors.primaryColor,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.grey[300],
                  filled: true,
                  hintText: 'CNPJ',
                  alignLabelWithHint: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: AppTheme.colors.secondaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onFieldSubmitted: (value) {
                  senha.requestFocus();
                },
                focusNode: login,
                textCapitalization: TextCapitalization.characters,
                initialValue: controllerLogin.user.login,
                onChanged: (value) {
                  controllerLogin.onChanged(login: value);
                },
                cursorColor: AppTheme.colors.primaryColor,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.grey[300],
                  filled: true,
                  hintText: 'Login',
                  alignLabelWithHint: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: AppTheme.colors.secondaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  controllerLogin.login();
                },
                focusNode: senha,
                textCapitalization: TextCapitalization.characters,
                initialValue: controllerLogin.user.senha,
                onChanged: (value) {
                  controllerLogin.onChanged(senha: value);
                },
                obscureText: !visiblePassword,
                cursorColor: AppTheme.colors.primaryColor,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Senha',
                  suffixIcon: GestureDetector(
                    child: Icon(
                      visiblePassword
                          ? Icons.remove_red_eye
                          : Icons.visibility_off,
                      size: 25,
                      color: visiblePassword
                          ? AppTheme.colors.secondaryColor
                          : Color(0xFF666666),
                    ),
                    onTap: () {
                      visiblePassword = !visiblePassword;
                      setState(() {});
                    },
                  ),
                  fillColor: Colors.grey[300],
                  filled: true,
                  alignLabelWithHint: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: AppTheme.colors.secondaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Visibility(
                visible: controllerLogin.status == LoginStatus.empty ||
                    controllerLogin.status == LoginStatus.error ||
                    controllerLogin.status == LoginStatus.semInternet,
                replacement: Container(
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffcf1f36),
                    ),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fixedSize: Size.fromHeight(45),
                      primary: Color(0xffcf1f36),
                    ), //Color(0xFF1E319D)
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      controllerLogin.login();
                      //Navigator.pushNamed(context, '/dashboard');
                    },
                    child: Text('Entrar'),
                  ),
                ),
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
