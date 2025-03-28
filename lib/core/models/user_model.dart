import 'package:smart_event_planner/core/entities/user_entity.dart';

class UserModel {
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

  UserModel({
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

  // Convert UserModel to UserEntity
  UserEntity toEntity() {
    return UserEntity(
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

  // Convert UserEntity to UserModel
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uId: entity.uId,
      email: entity.email,
      name: entity.name,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      profileImage: entity.profileImage,
      gender: entity.gender,
      birthDate: entity.birthDate,
      isVerified: entity.isVerified,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      favorites: entity.favorites,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['id'] ?? json['_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? 
           '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}'.trim(),
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
      gender: json['gender'],
      birthDate: json['birthDate'] != null 
          ? DateTime.parse(json['birthDate']) 
          : null,
      isVerified: json['isVerified'] ?? false,
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
      favorites: json['favorites'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uId,
      'email': email,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'gender': gender,
      'birthDate': birthDate?.toIso8601String(),
      'isVerified': isVerified,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'favorites': favorites,
    };
  }
}