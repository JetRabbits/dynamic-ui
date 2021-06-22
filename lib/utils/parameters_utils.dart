String substituteParams(String template, Map<String, dynamic> parameters) {
  String result = template;
  parameters.keys
      .forEach((key) => result = result.replaceAll("#$key#", parameters[key]));
  return result;
}
