import 'package:mobx/mobx.dart';
part 'long_text_controller.g.dart';

class LongTextController = LongTextControllerBase with _$LongTextController;

abstract class LongTextControllerBase with Store {
  @observable
  bool value = true;

  @action
  void toggleValue() {
    value = !value;
  }
}
