import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../data/poker_data.dart';

class PokerController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _positionController;
  late AnimationController _rotationYController;
  late AnimationController _rotationYOutSideController;

  final rotationAngle = 0.0.obs;
  final _rotationTween = Tween<double>(begin: 0, end: 2 * 3.14159265359);

  final rotationY = 0.0.obs;
  final _rotationYTween = Tween<double>(begin: 0, end: 1 * 3.14159265359);

  final rotationYOutSide = 0.0.obs;
  final _rotationYTweenOutSide =
      Tween<double>(begin: 0, end: 1 * 3.14159265359);

  final positionOffset = const Offset(0, 0).obs;

  var _positionTween = Tween<Offset>(
    begin: const Offset(0, 0), // Start at the center
    end: const Offset(0, 0), // End at the fixed offset
  );

  var isMove = false;
  var isHalf = false;

  var zIndex = 0.obs;
  Callback? statusCallBack;
  Callback? rotateStatusCallBack;

  var pokerIsBack = true.obs;

  PokerData pokerData = PokerData(imageUrlBack: '', imageUrl: '', text: '');

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _positionController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationYController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationYOutSideController = AnimationController(
      duration: const Duration(milliseconds: 0),
      vsync: this,
    );

    _controller.addListener(() {
      rotationAngle.value = _rotationTween.evaluate(_controller);
    });

    _positionController.addListener(() {
      positionOffset.value = _positionTween.evaluate(_positionController);
    });

    _rotationYController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotateStatusCallBack == null ? () {} : rotateStatusCallBack!();
      }
    });

    _rotationYController.addListener(() {
      rotationY.value = _rotationYTween.evaluate(_rotationYController);
      if (isHalf == false) {
        if (pokerIsBack.value) {
          if (rotationY > 1.7) {
            print(' rotationY.value ${rotationY.value}');
            pokerIsBack.value = !pokerIsBack.value;
            startRotateYOutSide();
            isHalf = true;
            print('pokerIsBack.value ${pokerIsBack.value}');
            print('start $isHalf');
          }
        } else {
          if (rotationY < 1.7) {
            print(' rotationY.value ${rotationY.value}');
            pokerIsBack.value = !pokerIsBack.value;
            startRotateYOutSide();
            isHalf = true;
            print('pokerIsBack.value ${pokerIsBack.value}');
            print('start $isHalf');
          }
        }
      }
    });

    _rotationYOutSideController.addListener(() {
      rotationYOutSide.value =
          _rotationYTweenOutSide.evaluate(_rotationYOutSideController);
    });

    _positionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        statusCallBack == null ? () {} : statusCallBack!();
      }
    });
  }

  @override
  void onClose() {
    _controller.dispose();
    _positionController.dispose();
  }

  void _rotate() {
    if (!_controller.isAnimating) {
      _controller.reset();
      _controller.forward();
    }
  }

  void startRotateY(Callback callback) {
    if (!_rotationYController.isAnimating) {
      rotateStatusCallBack = callback;
      isHalf = false;
      // _rotationYController.reset();
      if (_rotationYController.isForwardOrCompleted) {
        _rotationYController.reverse();
      } else {
        _rotationYController.forward();
      }
    }
  }

  void startRotateYOutSide() {
    if (!_rotationYOutSideController.isAnimating) {
      if (_rotationYOutSideController.isForwardOrCompleted) {
        _rotationYOutSideController.reverse();
      } else {
        _rotationYOutSideController.forward();
      }
    }
  }

  void _moveToOffset(double x, double y) {
    if (!_positionController.isAnimating) {
      if (isMove) {
        _positionTween = Tween<Offset>(
          begin: Offset(x, y), // Start at the center
          end: const Offset(0, 0), // End at the fixed offset
        );

        _positionController.reset();
        _positionController.forward();
        isMove = false;
      } else {
        _positionTween = Tween<Offset>(
          begin: const Offset(0, 0), // Start at the center
          end: Offset(x, y), // End at the fixed offset
        );

        _positionController.reset();
        _positionController.forward();
        isMove = true;
      }
    }
  }

  void move(double x, double y, Callback? callback) {
    statusCallBack = callback;
    _rotate();
    _moveToOffset(x, y);
  }

  void back(double x, double y, Callback? callback) {
    statusCallBack = callback;
    _rotate();
    _moveToOffset(x, y);
  }
}
