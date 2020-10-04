bool isNumeric(String s) {
  return s.isEmpty || (num.tryParse(s) == null) ? false : true;
}
