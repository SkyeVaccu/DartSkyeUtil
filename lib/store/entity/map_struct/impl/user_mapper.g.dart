// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class UserMapperImpl extends UserMapper {
  UserMapperImpl() : super();

  @override
  UserBO? dto2bo(
    UserDTO userDTO,
    String? password,
  ) {
    final userbo = UserBO.create(
      userDTO.username,
      password,
    );
    return userbo;
  }

  @override
  UserDTO? bo2dto(UserBO userBO) {
    final userdto = UserDTO.create(userBO.username);
    return userdto;
  }
}
