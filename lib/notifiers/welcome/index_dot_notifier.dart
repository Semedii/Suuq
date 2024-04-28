
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'index_dot_notifier.g.dart';

@riverpod
class IndexDotNotifier extends _$IndexDotNotifier{

  @override
  int build(){
    return 0;
  }

  void changeIndex(int value){
    state = value;
  }
}