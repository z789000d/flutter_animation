import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/data/poker_data.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:indexed/indexed.dart';

import '../controller/poker_controller.dart';

class Poker extends StatelessWidget {
  Poker(
      {super.key,
      required this.tag,
      required this.pokerData,
      required this.controller,
      required this.clickCallback});

  String tag;
  PokerData pokerData;
  PokerController controller;
  Callback clickCallback;

  @override
  Widget build(BuildContext context) {
    controller.pokerData = pokerData;
    return Obx(
      () => AnimatedPositioned(
        duration: const Duration(seconds: 0),
        left: controller.isMove
            ? controller.positionOffset.value.dx
            : controller.positionOffset.value.dx,
        top: controller.isMove
            ? controller.positionOffset.value.dy
            : controller.positionOffset.value.dy,
        child: Transform(
          transform: Matrix4.rotationY(controller.rotationYOutSide.value),
          alignment: Alignment.center,
          child: Transform(
            transform: Matrix4.rotationY(controller.rotationY.value),
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: controller.rotationAngle.value,
              child: GestureDetector(
                  onTap: () {
                    if (controller.pokerIsBack.value == true) {
                      controller.startRotateY(() {
                        clickCallback();
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          10)), // Elliptical bottom-right corner
                    ),
                    width: 150,
                    height: 150,
                    child: (controller.pokerIsBack.value)
                        ? Stack(
                            children: [
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(
                                        10)), // Elliptical bottom-right corner
                                  ),
                                  width: 100,
                                  height: 150,
                                ),
                              ),
                              SvgPicture.asset(
                                pokerData.imageUrlBack,
                                // Path to your SVG asset
                                width: 150,
                                height: 150,
                                fit: BoxFit.contain,
                                colorFilter: ColorFilter.mode(
                                  Colors
                                      .black, // Make the SVG itself transparent
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          )
                        : SvgPicture.asset(
                            pokerData.imageUrl,
                            // Path to your SVG asset
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
