import 'package:app_posto_el/src/components/el_input_widget.dart';
import 'package:app_posto_el/src/pages/login/controller/login_controller.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:app_posto_el/src/utils/meu_toast.dart';
import 'package:app_posto_el/src/utils/types_toast.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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

  FocusNode login = FocusNode();
  FocusNode senha = FocusNode();

  @override
  void initState() {
    autorun((_) {
      if (controllerLogin.status == LoginStatus.success) {
        Navigator.pushReplacementNamed(context, '/dashboard');
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
              // TextFormField(
              //   onFieldSubmitted: (value) {
              //     senha.requestFocus();
              //   },
              //   focusNode: login,
              //   textCapitalization: TextCapitalization.characters,
              //   initialValue: controllerLogin.user.login,
              //   onChanged: (value) {
              //     controllerLogin.onChanged(login: value);
              //   },
              //   cursorColor: AppTheme.colors.primaryColor,
              //   textAlignVertical: TextAlignVertical.top,
              //   decoration: InputDecoration(
              //     isDense: true,
              //     fillColor: Colors.grey[300],
              //     filled: true,
              //     hintText: 'Login',
              //     alignLabelWithHint: true,
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(20)),
              //       borderSide: BorderSide(
              //         color: AppTheme.colors.secondaryColor,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         borderSide: BorderSide.none),
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              ELInputWidget(
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
              // TextFormField(
              //   onFieldSubmitted: (_) {
              //     FocusScope.of(context).requestFocus(FocusNode());
              //     controllerLogin.login();
              //   },
              //   focusNode: senha,
              //   textCapitalization: TextCapitalization.characters,
              //   initialValue: controllerLogin.user.senha,
              //   onChanged: (value) {
              //     controllerLogin.onChanged(senha: value);
              //   },
              //   obscureText: !visiblePassword,
              //   cursorColor: AppTheme.colors.primaryColor,
              //   decoration: InputDecoration(
              //     isDense: true,
              //     hintText: 'Senha',
              //     suffixIcon: GestureDetector(
              //       child: Icon(
              //         visiblePassword ? Icons.visibility : Icons.visibility_off,
              //         size: 25,
              //         color: visiblePassword
              //             ? AppTheme.colors.secondaryColor
              //             : Color(0xFF666666),
              //       ),
              //       onTap: () {
              //         visiblePassword = !visiblePassword;
              //         setState(() {});
              //       },
              //     ),
              //     fillColor: Colors.grey[300],
              //     filled: true,
              //     alignLabelWithHint: true,
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(20)),
              //       borderSide: BorderSide(
              //         color: AppTheme.colors.secondaryColor,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         borderSide: BorderSide.none),
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              Visibility(
                visible: controllerLogin.status == LoginStatus.empty ||
                    controllerLogin.status == LoginStatus.error ||
                    controllerLogin.status == LoginStatus.semInternet ||
                    controllerLogin.status == LoginStatus.invalidCNPJ,
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
                    child: Text(
                      'Entrar',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
