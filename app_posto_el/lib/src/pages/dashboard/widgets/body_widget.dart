import 'package:app_posto_el/src/pages/dashboard/combustiveis/combustiveis_page_widget.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/vendas_widget.dart';
import 'package:flutter/material.dart';

var pages = [
  VendasWidget(),
  CombustiveisPageWidget(),
];

class BodyWidget extends SingleChildScrollView {
  final int currentIndex;
  final double size;
  BodyWidget({Key? key, required this.currentIndex, required this.size})
      : super(
          key: key,
          child: Column(
            children: [
              pages[currentIndex],
            ],
          ),
        );
}
