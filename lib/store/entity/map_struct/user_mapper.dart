import '../../../util/service/smart_struct/annotations.dart';
import '../bo/user_bo.dart';
import '../dto/user_dto.dart';

part 'impl/user_mapper.g.dart';

/// Mapper showcasing a simple mapping between two fields
@Mapper()
abstract class UserMapper {
  @Mapping(source: "password", target: "password", isStraight: true)
  UserBO? dto2bo(UserDTO userDTO, String? password);

  UserDTO? bo2dto(UserBO userBO);
}
