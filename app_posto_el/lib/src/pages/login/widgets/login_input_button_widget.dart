import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class LoginInputButtonWidget extends StatefulWidget {
  LoginInputButtonWidget({Key key}) : super(key: key);

  @override
  State<LoginInputButtonWidget> createState() => _LoginInputButtonWidgetState();
}

class _LoginInputButtonWidgetState extends State<LoginInputButtonWidget> {
  var controller = MaskedTextController(mask: '00.000.000/0000-00');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 45,
          decoration: BoxDecoration(
            color: Color(0xFF666666).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            cursorColor: Color(0xFF96242d),
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
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 45,
          decoration: BoxDecoration(
            color: Color(0xFF666666).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            obscureText: true,
            cursorColor: Color(0xFF96242d),
            decoration:
                InputDecoration(hintText: 'Senha', border: InputBorder.none),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffcf1f36)), //Color(0xFF1E319D)
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
                child: Text('Entrar'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
