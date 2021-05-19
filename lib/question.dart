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

  /// This will be the image url for the
  /// question.
  final String imgUrl;

  Question({
    required this.title,
    required this.answer,
    required this.options,
    required this.value,
    required this.imgUrl,
  });
}

/// Below is the list of questions

List<Question> myquestions = [
  // Question 1
  Question(
    title: 'Why does Cassius not like Caesar?',
    answer:
        'Cassius sees Caesar as an unfit leader because he thinks he is weak.',
    options: [
      'Cassius sees Caesar as an unfit leader because he thinks he is weak.',
      'He does not like him because he is corrupt and unjust'
    ],
    value: 1000,
    imgUrl:
        'https://th.bing.com/th/id/OIP.waO21TKRHuA2vNy6A_dnbwHaFA?pid=ImgDet&rs=1',
  ),
  // Question 2
  Question(
    title: 'How did Cassius trick Brutus into conspiring against Caesar?',
    answer:
        'He tricked Brutus by showing him fake letters that the citizens wrote but Brutus wrote the letters.',
    options: [
      'Cassius gave Brutus a speech on how Caesar was weak',
      'He tricked Brutus by showing him fake letters that the citizens wrote but Brutus wrote the letters.'
    ],
    value: 1000,
    imgUrl:
        'https://static.tornadomovies.co/images/character/O51CGE295eVH_SmHMIpk8dcX1leCa6Trb54zY-JshivB9EyUFOP-bTqYel5ZGYhhU1qznpQJ8T13msGhHJ-RWUH0wK2CDlNeI9qy5Cr34js.jpg?1&resize_w=320',
  ),
  // Question 3
  Question(
    title: 'Why would Caesar fear Cassius if he feared men?',
    answer:
        'Cassius was a man that did not like being under ranked and that makes him dangerous. ',
    options: [
      'Cassius was a man that did not like being under ranked and that makes him dangerous. ',
      'Cassius never smiled.'
    ],
    value: 1000,
    imgUrl:
        'https://pbs.twimg.com/profile_images/3315575320/e64399dd197152d8660fcb3843ade5f5.jpeg',
  ),
  // Question 4
  Question(
    title: 'Who is Calpurnia?',
    answer: 'Caesar’s wife.',
    options: ['Caesar’s wife.', 'Cassius\'s wife'],
    value: 1000,
    imgUrl:
        'https://th.bing.com/th/id/OIP.xt4oyaZK_OtsRw_oWpHxtQHaD_?pid=ImgDet&rs=1',
  ),
  // Question 5
  Question(
    title: 'Who is Portia?',
    answer: 'Brutus’s wife.',
    options: ['Brutus’s wife.', 'Cassius\'s wife '],
    value: 1000,
    imgUrl:
        'https://th.bing.com/th/id/Reaa202a36e6a410a763b352c40592199?rik=gq5MaS8tsLe%2frQ&riu=http%3a%2f%2fcelebritywc.com%2fimages%2fkate-steavensonpayne-10.jpg&ehk=LCkVcukAyAzVtVxTSTPJ0XlTQCDQXOtvB0I443rve9w%3d&risl=&pid=ImgRaw',
  ),
  // Question 6
  Question(
    title: 'What does Portia do to prove herself ?',
    answer: 'She harms herself to prove her strength.',
    options: [
      'She lists off the things she has done to prove her strength',
      'She harms herself to prove her strength.'
    ],
    value: 1500,
    imgUrl:
        'https://th.bing.com/th/id/OIP._qw42n0ChbB82JtWGUeIEwHaGD?pid=ImgDet&rs=1',
  ),
  // Question 7
  Question(
    title: 'Who contacts a soothsayer?',
    answer: 'Portia',
    options: ['Lucius', 'Portia'],
    value: 1500,
    imgUrl:
        'https://th.bing.com/th/id/Raf75fb4c8f25d410c0f4c269d6d4cce4?rik=qgMbKQQocU3LGw&pid=ImgRaw',
  ),
  // Question 8
  Question(
    title: 'Who has an evil Omen while sleeping?',
    answer: 'Calpurnia',
    options: ['Caesar', 'Calpurnia'],
    value: 1500,
    imgUrl:
        'https://th.bing.com/th/id/R4e61eaa540b2e2df447438854ae6ea14?rik=Hf040BfrB1mKWw&pid=ImgRaw',
  ),
  // Question 9
  Question(
    title: 'Who gives Caesar a warning about the conspiracy plan?',
    answer: 'Artemidorus',
    options: ['Artemidorus', 'Antony'],
    value: 1500,
    imgUrl:
        'https://schoolhistory.co.uk/wp-content/uploads/2019/02/Mark-Antony_1.jpg',
  ),
  // Question 10
  Question(
    title: 'Who is Portia’s servant boy?',
    answer: 'Lucius',
    options: ['Domeitia', 'Lucius'],
    value: 1000,
    imgUrl:
        'https://th.bing.com/th/id/OIP.kPY4ytm1v5KxXcDus_wqdwHaFj?pid=ImgDet&rs=1',
  ),
  // Question 11
  Question(
    title: 'When was Julius Caesar killed?',
    answer: 'March 15 44 BC',
    options: ['March 16 44 BC', 'March 15 44 BC'],
    value: 3000,
    imgUrl:
        'https://th.bing.com/th/id/OIP.dGk_3kJBuNz1-OvT8M87aQHaD5?pid=ImgDet&rs=1',
  ),
  // Question 12
  Question(
    title: 'How many times was Julius Caesar stabbed?',
    answer: '23 times',
    options: ['23 times', '26 times'],
    value: 3000,
    imgUrl:
        'https://th.bing.com/th/id/Ra73e8f97b33b78900707cde9733f56d3?rik=NdIbzc%2fdU5uZRg&pid=ImgRaw',
  ),
  // Question 13
  Question(
    title: 'Who was the last person to stab Julius Caesar?',
    answer: 'Brutus',
    options: ['Brutus', 'Cassius'],
    value: 3000,
    imgUrl:
        'https://s3.amazonaws.com/s3.timetoast.com/public/uploads/photos/1533633/JuliusCaesarStabbing.jpg?1473643538',
  ),
  // Question 14
  Question(
    title: 'What did Cinna rant after Caesars death?',
    answer:
        'Liberty! Freedom! Tyranny is dead! Run and proclaim it in the streets',
    options: [
      'Justice! exemption! autocracy is dead! Run and proclaim it in the streets',
      'Liberty! Freedom! Tyranny is dead! Run and proclaim it in the streets'
    ],
    value: 3000,
    imgUrl:
        'https://pbs.twimg.com/profile_images/973520040245985281/orzsVRqS_400x400.jpg',
  ),
  // Question 15
  Question(
    title: 'What is Julius Caesars biggest flaw?',
    answer: 'arrogant',
    options: ['humble', 'arrogant'],
    value: 3000,
    imgUrl:
        'https://cdn.vox-cdn.com/thumbor/aP0NVihSnNFOdwNRC98gE1Hmlgk=/230x145:1575x1154/1220x813/filters:focal(230x145:1575x1154):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/45894920/deathofcaesar.0.0.jpg',
  ),
];
