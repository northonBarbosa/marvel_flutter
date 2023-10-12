import 'package:get/state_manager.dart';

abstract class BaseController {
  bool get hasMore => false;
  RxList get itemsList => [].obs;

  Future fetchItems({int? id});
}
