import 'package:smart_event_planner/core/models/user_model.dart';

class UserEntity {
  final String uId;
  final String email;
  final String name;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? profileImage;
  final String? gender;
  final DateTime? birthDate;
  final bool isVerified;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> favorites;

  UserEntity({
    required this.uId,
    required this.email,
    required this.name,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profileImage,
    this.gender,
    this.birthDate,
    this.isVerified = false,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
    this.favorites = const [],
  });

  // Convert UserEntity to UserModel
  UserModel toModel() {
    return UserModel(
      uId: uId,
      email: email,
      name: name,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      profileImage: profileImage,
      gender: gender,
      birthDate: birthDate,
      isVerified: isVerified,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
      favorites: favorites,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          uId == other.uId;

  @override
  int get hashCode => uId.hashCode;
}