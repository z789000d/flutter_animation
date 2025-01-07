import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:indexed/indexed.dart';

import '../controller/home_controller.dart';
import '../controller/poker_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Center(child: allCard())),
            // GestureDetector(
            //     onTap: () {
            //       controller.start();
            //     },
            //     child: Text('發牌')),
            // GestureDetector(
            //     onTap: () {
            //       controller.back();
            //     },
            //     child: Text('收牌')),
            // GestureDetector(
            //     onTap: () {
            //       controller.allToBack();
            //     },
            //     child: Text('回背')),
            // GestureDetector(
            //     onTap: () {
            //       controller.allToForward();
            //     },
            //     child: Text('全正')),
            // GestureDetector(
            //     onTap: () {
            //       controller.reset();
            //     },
            //     child: Text('洗牌')),
            Obx(
              () =>
                  GestureDetector(child: Text('得分: ${controller.score.value}')),
            ),
            GestureDetector(
                onTap: () {
                  controller.deal();
                },
                child: Text('開始')),
          ],
        ),
      ),
    );
  }

  Widget allCard() {
    final HomeController controller = Get.put(HomeController());
    return Obx(
      () => Stack(
        children: controller.pokerWidget.value,
      ),
    );
  }
}
