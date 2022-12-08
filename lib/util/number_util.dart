import 'dart:math';

///the util about number to operate
class NumberUtil {
  ///create a random by the ceil and floor
  ///@param ceil : the max number of the scope , default ceil is 10000
  ///@param floor : the min number of the scope , default floor is 0
  ///@return : the random number
  static int createRandomNumber({int ceil = 10000, int floor = 0}) {
    //create a random object
    var random = Random();
    //return number
    return floor + random.nextInt(ceil - floor);
  }
}
