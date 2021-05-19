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

/// Below is the list of questions

List<Question> myquestions = [
  Question(
    title: 'Why does Cassius not like Caesar?',
    answer:
        'Cassius sees Caesar as an unfit leader because he thinks he is weak.',
    options: [
      'Cassius sees Caesar as an unfit leader because he thinks he is weak.',
      'He does not like him because he is corrupt and unjust'
    ],
    value: 1000,
  ),
  Question(
    title: 'How did Cassius trick Brutus into conspiring against Caesar?',
    answer:
        'He tricked Brutus by showing him fake letters that the citizens wrote but Brutus wrote the letters.',
    options: [
      'Cassius gave Brutus a speech on how Caesar was weak',
      'He tricked Brutus by showing him fake letters that the citizens wrote but Brutus wrote the letters.'
    ],
    value: 1000,
  ),
  Question(
    title: 'Why would Caesar fear Cassius if he feared men?',
    answer:
        'Cassius was a man that did not like being under ranked and that makes him dangerous. ',
    options: [
      'Cassius was a man that did not like being under ranked and that makes him dangerous. ',
      'Cassius never smiled.'
    ],
    value: 1000,
  ),
  Question(
    title: 'Who is Calpurnia?',
    answer: 'Caesar’s wife.',
    options: ['Caesar’s wife.', 'Cassius\'s wife'],
    value: 1000,
  ),
  Question(
    title: 'Who is Portia?',
    answer: 'Brutus’s wife.',
    options: ['Brutus’s wife.', 'Cassius\'s wife '],
    value: 1000,
  ),
  Question(
    title: 'What does Portia do to prove herself ?',
    answer: 'She harms herself to prove her strength.',
    options: [
      'She lists off the things she has done to prove her strength',
      'She harms herself to prove her strength.'
    ],
    value: 1500,
  ),
  Question(
    title: 'Who contacts a soothsayer?',
    answer: 'Portia',
    options: ['Lucius', 'Portia'],
    value: 1500,
  ),
  Question(
    title: 'Who has an evil Omen while sleeping?',
    answer: 'Calpurnia',
    options: ['Caesar', 'Calpurnia'],
    value: 1500,
  ),
  Question(
    title: 'Who gives Caesar a warning about the conspiracy plan?',
    answer: 'Artemidorus',
    options: ['Artemidorus', 'Antony'],
    value: 1500,
  ),
  Question(
    title: 'Who is Portia’s servant boy?',
    answer: 'Lucius',
    options: ['Domeitia', 'Lucius'],
    value: 1000,
  ),
  Question(
    title: 'When was Julius Caesar killed?',
    answer: 'March 15 44 BC',
    options: ['March 16 44 BC', 'March 15 44 BC'],
    value: 3000,
  ),
  Question(
    title: 'How many times was Julius Caesar stabbed?',
    answer: '23 times',
    options: ['23 times', '26 times'],
    value: 3000,
  ),
  Question(
    title: 'Who was the last person to stab Julius Caesar?',
    answer: 'Brutus',
    options: ['Brutus', 'Cassius'],
    value: 3000,
  ),
  Question(
    title: 'What did Cinna rant after Caesars death?',
    answer:
        'Liberty! Freedom! Tyranny is dead! Run and proclaim it in the streets',
    options: [
      'Justice! exemption! autocracy is dead! Run and proclaim it in the streets',
      'Liberty! Freedom! Tyranny is dead! Run and proclaim it in the streets'
    ],
    value: 3000,
  ),
  Question(
    title: 'What is Julius Caesars biggest flaw? ',
    answer: 'arrogant',
    options: ['humble', 'arrogant'],
    value: 3000,
  ),
];
