
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/providers/signup/signup_state.dart';

part 'signup_notifier.g.dart';

@riverpod
class SignupNotifier extends _$SignupNotifier{
  
  @override
  SignupState build(){
    return SignupState();
  } 
}