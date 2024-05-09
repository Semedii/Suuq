abstract class MyProfileState {}

class MyProfileInitialState extends MyProfileState {}

class MyProfileLoadingState extends MyProfileState {}

class MyProfileLoadedState extends MyProfileState {
  final String userName;
  final String userEmail;
  final String? userPhoneNumber;
  final String? userAddress;
  final String? userAvatar;
  final DateTime userJoinedDate;
  final bool issaveButtonLoading;
  final String? newPassword;
  final String? rePassword;

  

  MyProfileLoadedState({
    required this.userName,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.userJoinedDate,
    this.newPassword,
    this.rePassword,
    this.userAddress,
    this.userAvatar,
    this.issaveButtonLoading=false,
  });

  MyProfileLoadedState copyWith({
    String? userName,
    String? userEmail,
    String? userPhoneNumber,
    String? userAddress,
    String? userAvatar,
    DateTime? userJoinedDate,
    bool? issaveButtonLoading,
    String? newPassword,
    String? rePassword,
  }) {
    return MyProfileLoadedState(
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
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
