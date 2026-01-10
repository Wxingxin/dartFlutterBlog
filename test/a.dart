void main() {
  bool a = true;
  print(a.toString());
  print(a.hashCode);
  true.noSuchMethod(Invocation.method(#test, []));

}
