///the class_extension on the String, to add the method
extension StringExtension on String {
  ///judge whether it pass the regExp
  ///@param regExpStr: the regular expression
  ///@return : whether it pass the matching
  bool match(String regExpStr) {
    var regExp = RegExp(regExpStr);
    return regExp.hasMatch(this);
  }

  ///concat the string
  ///@param obj : the concat string
  ///@param joinStr : join string
  ///@return : the joined string
  String join(dynamic obj, {String joinStr = ":"}) {
    return this + joinStr + obj.toString();
  }
}
