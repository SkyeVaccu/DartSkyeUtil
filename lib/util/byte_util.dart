import 'dart:math';
import 'dart:typed_data';

class ByteUtil {
  //convert the string data to byte data, it convert the true string not the binary string or hex string
  //@param hexData : the string data like "Hello World"
  //@return : the converted byte data
  static Uint8List stringToUList(String hexData) => Uint8List.fromList(hexData.codeUnits);

  //convert the byte list to string hex data
  //@param uint8list: the byte list
  //@return : the converted string data, the true string
  static String ulistToString(Uint8List uint8list) => String.fromCharCodes(uint8list);

  //convert the binary string to the byte data
  //@param binaryString : the binaryString like "100110"
  //@return : the converted byte data
  static Uint8List binaryStringToUList(String binaryString) {
    List<int> list = [];
    for (int i = binaryString.length; i > 0; i -= 8) {
      int start = max(0, i - 8);
      int end = i;
      list.add(int.parse(binaryString.substring(start, end), radix: 2));
    }
    return listToUList(list.reversed.toList());
  }

  //convert the hex string to the byte data
  //@param hexString : the hexString like "7F1A0B"
  //@return : the converted byte data
  static Uint8List hexStringToUList(String hexString) {
    List<int> list = [];
    for (int i = hexString.length; i > 0; i -= 2) {
      int start = max(0, i - 2);
      int end = i;
      list.add(int.parse(hexString.substring(start, end), radix: 16));
    }
    return listToUList(list.reversed.toList());
  }

  //convert int data to byte data, it can save more space
  //@param list: the int data, the data can be hex or decimal or binary data
  //@return : the converted byte data
  static Uint8List listToUList(List<int> list) => Uint8List.fromList(list);

  //convert the byte data to int data
  //@param uint8list : the byte data
  //@return : the converted int data
  static List<int> ulistToList(Uint8List uint8list) => uint8list.toList();
}
