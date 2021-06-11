void main() {
  var parse = Uri.parse("process://tasks");
  print(parse.authority);
}