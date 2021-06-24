String substituteParams(String template, Map<String, dynamic> parameters) {
  String result = template;
  parameters.keys
      .forEach((key) {
        result = parameters[key] is String ? result.replaceAll("#$key#", parameters[key]): result;
      });
  return result;
}
