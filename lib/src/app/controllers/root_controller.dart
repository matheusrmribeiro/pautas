import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'root_controller.g.dart';

class RootController = _RootControllerBase with _$RootController;

abstract class _RootControllerBase with Store {
  
  final PageController pageController = PageController(initialPage: 0);
  
  @observable
  int currentPage = 0;
  
}