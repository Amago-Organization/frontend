import 'package:mobx/mobx.dart';
part 'visibility_controller.g.dart';

class VisibilityController = VisibilityControllerBase with _$VisibilityController;

abstract class VisibilityControllerBase with Store {
  @observable
  bool isVisible = true;

  @action
  void toggleVisibility() {
    isVisible = !isVisible;
  }
}