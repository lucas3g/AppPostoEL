import 'package:app_posto_el/src/pages/dashboard/combustiveis/combustiveis_page_widget.dart';
import 'package:app_posto_el/src/pages/dashboard/saldo_cr/saldo_cr_page.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/vendas_widget.dart';
import 'package:flutter/material.dart';

var pages = [
  const VendasWidget(),
  const CombustiveisPageWidget(),
  SaldoCRPage(),
];

class BodyWidget extends SingleChildScrollView {
  final int currentIndex;
  BodyWidget({Key? key, required this.currentIndex})
      : super(
          key: key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: pages[currentIndex],
              ),
            ],
          ),
        );
}
