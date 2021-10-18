import 'package:app_posto_el/src/pages/login/controller/login_controller.dart';
import 'package:app_posto_el/src/theme/app_theme.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class ELInputWidget extends StatelessWidget {
  final FocusNode focusNode;
  final LoginController controllerLogin;
  final TextInputType keyboardType;
  final String hintText;
  final bool mascaraCnpj;
  final String type;
  final bool obscureText;
  final Widget? sufixIcon;
  final List<TextInputFormatter>? inputFormaters;
  final Function(String?) onFieldSubmitted;
  ELInputWidget({
    Key? key,
    required this.focusNode,
    required this.controllerLogin,
    required this.keyboardType,
    required this.hintText,
    required this.mascaraCnpj,
    required this.type,
    required this.obscureText,
    required this.onFieldSubmitted,
    this.sufixIcon,
    this.inputFormaters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormaters,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (value) {
        if (type == 'CNPJ') {
          controllerLogin.onChanged(cnpj: value);
        } else if (type == 'LOGIN') {
          controllerLogin.onChanged(login: value);
        } else {
          controllerLogin.onChanged(senha: value);
        }
      },
      focusNode: type != 'CNPJ' ? focusNode : FocusNode(),
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: AppTheme.colors.primaryColor,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        isDense: true,
        fillColor: Colors.grey[300],
        filled: true,
        suffixIcon: sufixIcon,
        hintText: hintText,
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
    );
  }
}
