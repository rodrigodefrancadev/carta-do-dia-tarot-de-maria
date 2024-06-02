class Constants {
  static const double kGameAspectRatio = 9.0 / 16.0;
  static const double kCardWidthProportion = 0.065;
  static const double kCardWidthProportionTablet = 0.076;
  static const double kCardWidthProportionMobile = 0.17;
  static const int nCol = 11;
  static const int kCardsCount = 22;
  static const int nLateralSpaces = 2;
  static const double kCardAspect = 0.52;
  static const double kModRotation = 0.10;
  static const double kHoverRotation = 0.03;
  static const double kHoverScale = 1.1;
  static const double kStage1yOffset = 0.25;
  static const double kStage7yOffset = 0.17;
  static const double kYAlphaStage1 = 2;
  static const double space = 2;

  static const double kDetailsCardFieldWidth = 200;
  static const double kDetailsCardWidth = 416;

  static const double kCornerRadiusCard = 7;

  static const double kMobileWidthScreen = 360;
  static const double kTabletWidthScreen = 768;
  static const double kDesktopWidthScreen = 1120;

  static const List<String> titleByStage = [
    'Carta do dia',
    'Embaralhando',
    'Concentre-se',
    'Medite',
    'Quase lá...',
    'Escolha sua carta',
  ];

  static const String textStage1 =
      'Escolha um momento tranquilo para o jogo e feche os olhos por alguns instantes. Concentre-se e peça mentalmente uma orientação para o seu dia. Você só pode tirar uma carta, por isso, quando se sentir preparado embaralhe as cartas.';
  static const String textStage2 =
      'Respire fundo, mentalize a orientação que deseja...';
  static const String textStage3 =
      'Continue mentalizando e respirando fundo...';
  static const String textStage4 =
      'Enquanto respira e mentaliza, tenha desejos positivos e objectivos conclusivos para o seu bem estar';
  static const String textStage5 =
      'Vamos posicionar as cartas e nos preparar para fazer uma escolha';

  static const List<String> textByStage = [
    textStage1,
    textStage2,
    textStage3,
    textStage4,
    textStage5
  ];
}
