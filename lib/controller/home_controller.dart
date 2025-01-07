import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/controller/poker_controller.dart';
import 'package:flutter_animation/data/poker_data.dart';
import 'package:get/get.dart';
import 'package:indexed/indexed.dart';

import '../widget/poker.dart';

class HomeController extends GetxController {
  RxList<Poker> pokerWidget = <Poker>[].obs;
  RxList<PokerData> pokerData = <PokerData>[].obs;

  int startIndex = 0;
  var clickCardList = <PokerController>[];
  var clearCardIndex = 0;
  var allCardIndex = 16;
  var score = 0.obs;

  @override
  void onInit() {
    super.onInit();
    reset();
    score.value = 0;
  }

  void reset() {
    clearCardIndex = 0;

    pokerData.value = List.generate(
        allCardIndex,
        (index) => PokerData(
            imageUrlBack: 'assets/poker_back.svg',
            text: '撲克牌${index % 4}',
            imageUrl: 'assets/p${index % 4}.svg'));

    pokerData.shuffle();

    pokerWidget.value = List.generate(
        allCardIndex,
        (index) => Poker(
              tag: '$index',
              pokerData: pokerData[index],
              controller: Get.put(PokerController(), tag: '$index'),
              clickCallback: () {
                clickCard(Get.put(PokerController(), tag: '$index'));
              },
            ));
  }

  void deal() {
    allToBack();
    allBack();
    reset();
    start();
  }

  @override
  void onClose() {}

  void start() {
    var nowIndex = pokerWidget.value.length - startIndex - 1;

    if (nowIndex >= 0) {
      print(nowIndex);

      pokerWidget.value[nowIndex].controller.zIndex.value = 0;

      pokerWidget.value[nowIndex].controller.move(
          (startIndex % 4) * (150), (200 * (startIndex / 4).toInt()).toDouble(),
          () {
        startIndex++;
        start();
      });
    } else {
      print('歸零');
      startIndex = 0;
    }
  }

  void allBack() {
    for (var i = pokerWidget.value.length - 1; i >= 0; i--) {
      print('object $i');
      if (pokerWidget.value[i].controller.isMove == false) {
        return;
      }
      pokerWidget.value[i].controller.zIndex.value = (i);

      pokerWidget.value[i].controller
          .back(((i) % 4) * (150), (200 * (i / 4).toInt()).toDouble(), () {});
    }
  }

  void back() {
    if (startIndex < pokerWidget.value.length) {
      if (pokerWidget.value[startIndex].controller.isMove == false) {
        return;
      }
      pokerWidget.value[startIndex].controller.zIndex.value =
          (pokerWidget.value.length - startIndex - 1);

      pokerWidget.value[startIndex].controller.back(
          ((pokerWidget.value.length - startIndex - 1) % 4) * (150),
          (200 * ((pokerWidget.value.length - startIndex - 1) / 4).toInt())
              .toDouble(), () {
        startIndex++;
        back();
      });
    } else {
      print('歸零');
      startIndex = 0;
    }
  }

  void allToBack() {
    for (var i = 0; i < pokerWidget.value.length; i++) {
      if (!pokerWidget.value[i].controller.pokerIsBack.value) {
        pokerWidget.value[i].controller.startRotateY(() {});
      }
    }
  }

  void allToForward() {
    for (var i = 0; i < pokerWidget.value.length; i++) {
      if (pokerWidget.value[i].controller.pokerIsBack.value) {
        pokerWidget.value[i].controller.startRotateY(() {});
      }
    }
  }

  void clickCard(PokerController pokerController) {
    clickCardList.add(pokerController);
    if (clickCardList.length == 2) {
      if (clickCardList[0].pokerData.text != clickCardList[1].pokerData.text) {
        clickCardList[0].startRotateY(() {});
        clickCardList[1].startRotateY(() {});
      } else {
        score.value++;
        clearCardIndex = clearCardIndex + 2;
      }
      clickCardList.clear();
    }
    if (clearCardIndex == allCardIndex) {
      showMyDialog();
    }
  }

  void showMyDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('你贏了'),
        content: const Text('恭喜你贏得遊戲！'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Closethe dialog
              deal();
            },
            child: const Text('再來一局'),
          ),
        ],
      ),
      barrierDismissible: false, // Prevent closing by tapping outside
    );
  }
}
