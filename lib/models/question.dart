class Question {
  /// The title of the question
  final String title;

  /// The answer of this question.
  /// Note: The answer must corrospond
  /// to the same piece of text from
  /// from the question list options.
  final String answer;

  /// The list of options for this question
  /// in a text format.
  final List<String> options;

  /// The amount of points this question
  /// is valued at. Easy would typically
  /// be around 200 points and hard around
  /// 3000.
  final double value;

  Question({
    required this.title,
    required this.answer,
    required this.options,
    required this.value,
  });
}
