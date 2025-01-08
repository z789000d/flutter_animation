import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class StartController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;
  late AnimationController _controller5;

  final positionOffset1 = const Offset(0, 0).obs;
  final positionOffset2 = const Offset(0, 0).obs;
  final positionOffset3 = const Offset(0, 0).obs;
  final positionOffset4 = const Offset(0, 0).obs;
  final positionOffset5 = const Offset(0, 0).obs;

  var _positionTween1 = Tween<Offset>(
    begin: const Offset(0, 0), // Start at the center
    end: const Offset(0, 0), // End at the fixed offset
  );
  var _positionTween2 = Tween<Offset>(
    begin: const Offset(0, 0), // Start at the center
    end: const Offset(0, 0), // End at the fixed offset
  );
  var _positionTween3 = Tween<Offset>(
    begin: const Offset(0, 0), // Start at the center
    end: const Offset(0, 0), // End at the fixed offset
  );
  var _positionTween4 = Tween<Offset>(
    begin: const Offset(0, 0), // Start at the center
    end: const Offset(0, 0), // End at the fixed offset
  );
  var _positionTween5 = Tween<Offset>(
    begin: const Offset(0, 0), // Start at the center
    end: const Offset(0, 0), // End at the fixed offset
  );

  Callback? statusCallBack1;
  Callback? statusCallBack2;
  Callback? statusCallBack3;
  Callback? statusCallBack4;
  Callback? statusCallBack5;

  @override
  void onInit() {
    super.onInit();
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller3 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller4 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller5 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    positionOffset1.value = Offset(Get.width / 2 - 140, 80);
    positionOffset2.value = Offset(Get.width / 2 - 90, 80);
    positionOffset3.value = Offset(Get.width / 2 - 40, 80);
    positionOffset4.value = Offset(Get.width / 2 + 10, 80);
    positionOffset5.value = Offset(Get.width / 2 + 60, 80);

    _controller1.addListener(() {
      positionOffset1.value = _positionTween1.evaluate(_controller1);
    });
    _controller2.addListener(() {
      positionOffset2.value = _positionTween2.evaluate(_controller2);
    });
    _controller3.addListener(() {
      positionOffset3.value = _positionTween3.evaluate(_controller3);
    });
    _controller4.addListener(() {
      positionOffset4.value = _positionTween4.evaluate(_controller4);
    });
    _controller5.addListener(() {
      positionOffset5.value = _positionTween5.evaluate(_controller5);
    });

    _controller1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        statusCallBack1 == null ? () {} : statusCallBack1!();
      }
    });
    _controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        statusCallBack2 == null ? () {} : statusCallBack2!();
      }
    });
    _controller3.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        statusCallBack3 == null ? () {} : statusCallBack3!();
      }
    });
    _controller4.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        statusCallBack4 == null ? () {} : statusCallBack4!();
      }
    });
    _controller5.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        statusCallBack5 == null ? () {} : statusCallBack5!();
      }
    });

    moveRepeat();
  }

  Future<void> move1() async {
    _positionTween1 = Tween<Offset>(
      begin: Offset(positionOffset1.value.dx, positionOffset1.value.dy),
      // Start at the center
      end: Offset(positionOffset1.value.dx,
          positionOffset1.value.dy - 40), // End at the fixed offset
    );
    await _controller1.forward();
  }

  Future<void> reserve1() async {
    await _controller1.reverse();
    statusCallBack1 = null;
  }

  Future<void> move2() async {
    _positionTween2 = Tween<Offset>(
      begin: Offset(positionOffset2.value.dx, positionOffset2.value.dy),
      // Start at the center
      end: Offset(positionOffset2.value.dx,
          positionOffset2.value.dy - 40), // End at the fixed offset
    );
    await _controller2.forward();
  }

  Future<void> reserve2() async {
    await _controller2.reverse();
    statusCallBack2 = null;
  }

  Future<void> move3() async {
    _positionTween3 = Tween<Offset>(
      begin: Offset(positionOffset3.value.dx, positionOffset3.value.dy),
      // Start at the center
      end: Offset(positionOffset3.value.dx,
          positionOffset3.value.dy - 40), // End at the fixed offset
    );
    await _controller3.forward();
  }

  Future<void> reserve3() async {
    await _controller3.reverse();
    statusCallBack3 = null;
  }

  Future<void> move4() async {
    _positionTween4 = Tween<Offset>(
      begin: Offset(positionOffset4.value.dx, positionOffset4.value.dy),
      // Start at the center
      end: Offset(positionOffset4.value.dx,
          positionOffset4.value.dy - 40), // End at the fixed offset
    );
    await _controller4.forward();
  }

  Future<void> reserve4() async {
    await _controller4.reverse();
    statusCallBack4 = null;
  }

  Future<void> move5() async {
    _positionTween5 = Tween<Offset>(
      begin: Offset(positionOffset5.value.dx, positionOffset5.value.dy),
      // Start at the center
      end: Offset(positionOffset5.value.dx,
          positionOffset5.value.dy - 40), // End at the fixed offset
    );
    await _controller5.forward();
  }

  Future<void> reserve5() async {
    await _controller5.reverse();
    statusCallBack5 = null;
  }

  Future<void> moveRepeat() async {
    await a1();
    await a2();
    await a3();
    await a4();
    await a5();
    await moveRepeat();
  }

  Future<void> a1() async {
    await move1();
    await reserve1();
  }

  Future<void> a2() async {
    await move2();
    await reserve2();
  }

  Future<void> a3() async {
    await move3();
    await reserve3();
  }

  Future<void> a4() async {
    await move4();
    await reserve4();
  }

  Future<void> a5() async {
    await move5();
    await reserve5();
  }
}
