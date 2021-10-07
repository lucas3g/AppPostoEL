import 'package:app_posto_el/src/pages/dashboard/combustiveis/combustiveis_page_widget.dart';
import 'package:app_posto_el/src/pages/dashboard/vendas/vendas_widget.dart';
import 'package:flutter/material.dart';

var pages = [
  VendasWidget(),
  CombustiveisPageWidget(),
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
