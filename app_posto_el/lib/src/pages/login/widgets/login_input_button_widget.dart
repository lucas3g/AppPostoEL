import 'dart:ffi';

import 'package:app_posto_el/src/components/el_input_widget.dart';
import 'package:app_posto_el/src/pages/login/controller/login_controller.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:app_posto_el/src/utils/formatters.dart';
import 'package:app_posto_el/src/utils/meu_toast.dart';
import 'package:app_posto_el/src/utils/types_toast.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class LoginInputButtonWidget extends StatefulWidget {
  LoginInputButtonWidget({Key? key}) : super(key: key);

  @override
  State<LoginInputButtonWidget> createState() => _LoginInputButtonWidgetState();
}

class _LoginInputButtonWidgetState extends State<LoginInputButtonWidget>
    with TickerProviderStateMixin {
  final controllerLogin = LoginController();
  late Map<String, String> logado;
  var visiblePassword = false;

  FocusNode login = FocusNode();
  FocusNode senha = FocusNode();

  late AnimationController _animation;
  late Duration _smallDuration;

  @override
  void initState() {
    autorun((_) async {
      if (controllerLogin.status == LoginStatus.success) {
        //Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (controllerLogin.status == LoginStatus.error) {
        MeuToast.toast(
            title: 'Ops... :(',
            message: 'Não Foi Possivel Fazer Login.Verifique seus Dados.',
            type: TypeToast.error,
            context: context);
      } else if (controllerLogin.status == LoginStatus.semInternet) {
        MeuToast.toast(
            title: 'Ops... :(',
            message: 'Parece que você está sem Internet',
            type: TypeToast.noNet,
            context: context);
      } else if (controllerLogin.status == LoginStatus.invalidCNPJ) {
        MeuToast.toast(
            title: 'Ops... :(',
            message: 'Você digitou um CNPJ inválido.',
            type: TypeToast.dadosInv,
            context: context);
      }
    });
    super.initState();
    _smallDuration = Duration(milliseconds: (2000 * 0.2).round());
    _animation =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
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
              Spacer(),
              Text(
                'Entre com sua conta',
                style: AppTheme.textStyles.title.copyWith(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ELInputWidget(
                onFieldSubmitted: (value) {
                  login.requestFocus();
                },
                controllerLogin: controllerLogin,
                keyboardType: TextInputType.number,
                hintText: 'CNPJ',
                mascaraCnpj: true,
                type: 'CNPJ',
                obscureText: false,
                focusNode: login,
                inputFormaters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfOuCnpjFormatter()
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ELInputWidget(
                inputFormaters: [UpperCaseTextFormatter()],
                onFieldSubmitted: (value) {
                  senha.requestFocus();
                },
                focusNode: login,
                controllerLogin: controllerLogin,
                keyboardType: TextInputType.text,
                hintText: 'Login',
                mascaraCnpj: false,
                type: 'LOGIN',
                obscureText: false,
              ),
              SizedBox(
                height: 15,
              ),
              ELInputWidget(
                inputFormaters: [UpperCaseTextFormatter()],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  controllerLogin.login();
                },
                focusNode: senha,
                controllerLogin: controllerLogin,
                keyboardType: TextInputType.text,
                hintText: 'Senha',
                mascaraCnpj: false,
                type: 'SENHA',
                obscureText: !visiblePassword,
                sufixIcon: GestureDetector(
                  child: Icon(
                    visiblePassword ? Icons.visibility : Icons.visibility_off,
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
              ),
              SizedBox(
                height: 15,
              ),
              AnimatedContainer(
                duration: _smallDuration,
                width: controllerLogin.status == LoginStatus.loading
                    ? _animation.value * 40
                    : double.maxFinite,
                child: GestureDetector(
                  onTap: () {
                    _animation.forward();
                    FocusScope.of(context).requestFocus(FocusNode());
                    controllerLogin.login();
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffcf1f36)),
                      borderRadius: BorderRadius.circular(20),
                      color: controllerLogin.status == LoginStatus.success
                          ? Colors.white
                          : Color(0xffcf1f36),
                    ),
                    child: AnimatedSize(
                      duration: _smallDuration,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controllerLogin.status == LoginStatus.success
                              ? Icon(
                                  Icons.ac_unit,
                                  color: controllerLogin.status ==
                                          LoginStatus.success
                                      ? Color(0xffcf1f36)
                                      : Colors.white,
                                )
                              : Container(),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            controllerLogin.status == LoginStatus.success
                                ? 'Sucesso :)'
                                : controllerLogin.status == LoginStatus.empty
                                    ? 'Entrar'
                                    : 'Acessando...',
                            style: TextStyle(
                                color: controllerLogin.status ==
                                        LoginStatus.success
                                    ? Color(0xffcf1f36)
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
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
              Spacer(),
              Text(
                'EL Sistemas - 2021 - 54 3364 1588',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[600]),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
