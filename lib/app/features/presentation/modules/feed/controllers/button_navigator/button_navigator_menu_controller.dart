import 'package:mobx/mobx.dart';
part 'button_navigator_menu_controller.g.dart';

class ButtonNavigatorMenuController = ButtonNavigatorMenuControllerBase
    with _$ButtonNavigatorMenuController;

abstract class ButtonNavigatorMenuControllerBase with Store {
  @observable
  int currentIndex = 0;

  @action
  void onItemTapped(int index) {
    currentIndex = index;
  }
}
