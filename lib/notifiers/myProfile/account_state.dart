import 'package:suuq/utils/enums/language.dart';

abstract class AccountState {}

class AccountInitialState extends AccountState {}

class AccountLoadingState extends AccountState {}

class AccountLoadedState extends AccountState {
  final String userName;
  final String userEmail;
  final String? userPhoneNumber;
  final String? userAddress;
  final String? userAvatar;
  final Language language;
  final DateTime userJoinedDate;
  final bool issaveButtonLoading;
  final String? newPassword;
  final String? rePassword;

  

  AccountLoadedState({
    required this.userName,
    required this.userEmail,
    this.userPhoneNumber,
    required this.userJoinedDate,
    required this.language,
    this.newPassword,
    this.rePassword,
    this.userAddress,
    this.userAvatar,
    this.issaveButtonLoading=false,
  });

  AccountLoadedState copyWith({
    String? userName,
    String? userEmail,
    String? userPhoneNumber,
    String? userAddress,
    String? userAvatar,
    DateTime? userJoinedDate,
    bool? issaveButtonLoading,
    String? newPassword,
    String? rePassword,
    Language? language,
  }) {
    return AccountLoadedState(
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      language: language?? this.language,
      userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
      userJoinedDate: userJoinedDate ?? this.userJoinedDate,
      userAddress: userAddress ?? this.userAddress,
      userAvatar: userAvatar ?? this.userAvatar,
      issaveButtonLoading: issaveButtonLoading??this.issaveButtonLoading,
      newPassword: newPassword ?? this.newPassword,
      rePassword: rePassword ?? this.rePassword,
    );
  }
}
