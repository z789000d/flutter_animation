import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/page/home_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:indexed/indexed.dart';

import '../controller/home_controller.dart';
import '../controller/poker_controller.dart';
import '../controller/start_controller.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final StartController controller = Get.put(StartController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Container(
                width: Get.width,
                height: 200,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(seconds: 0),
                      left: controller.positionOffset1.value.dx,
                      top: controller.positionOffset1.value.dy,
                      child: Container(
                        child: Text(
                          "記",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(seconds: 0),
                      left: controller.positionOffset2.value.dx,
                      top: controller.positionOffset2.value.dy,
                      child: Container(
                        child: Text(
                          "憶",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(seconds: 0),
                      left: controller.positionOffset3.value.dx,
                      top: controller.positionOffset3.value.dy,
                      child: Container(
                        child: Text(
                          "大",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(seconds: 0),
                      left: controller.positionOffset4.value.dx,
                      top: controller.positionOffset4.value.dy,
                      child: Container(
                        child: Text(
                          "挑",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(seconds: 0),
                      left: controller.positionOffset5.value.dx,
                      top: controller.positionOffset5.value.dy,
                      child: Container(
                        child: Text(
                          "戰",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const HomePage());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    "開始遊戲",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
