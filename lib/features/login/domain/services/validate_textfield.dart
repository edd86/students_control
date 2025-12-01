class ValidateTextfield {
  final String? content;
  ValidateTextfield({this.content});

  bool validate() {
    if (content == null || content!.isEmpty) return false;
    return true;
  }
}
