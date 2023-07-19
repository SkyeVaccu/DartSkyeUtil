import '../../../util/service/smart_struct/annotations.dart';
import '../bo/user_bo.dart';
import '../dto/user_dto.dart';

part 'impl/user_mapper.g.dart';

/// Mapper showcasing a simple mapping between two fields
/// it define the convert rule
@Mapper()
abstract class UserMapper {
  ///convert the UserDTO object to UserBO object
  ///@param userDTO: DTO object
  ///@param password: the password
  ///@return : the converted userBO object
  @Mapping(source: "password", target: "password", isStraight: true)
  UserBO? dto2bo(UserDTO userDTO, String? password);

  ///convert the UserBO object to UserDTO object
  ///@param userBO: BO object
  ///@return : the dto object
  UserDTO? bo2dto(UserBO userBO);
}
