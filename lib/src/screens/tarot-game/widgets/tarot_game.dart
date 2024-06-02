import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tarot_de_maria/src/commom/constants.dart';
import 'package:tarot_de_maria/src/screens/tarot-game/widgets/tarto_card.dart';

const STAGES_COUNT = 7;

class TartotGame extends StatefulWidget {
  final double width;
  final double height;

  const TartotGame({super.key, required this.width, required this.height});

  @override
  State<TartotGame> createState() => _TartotGameState();
}

class _TartotGameState extends State<TartotGame> {
  late double _cardWidth;
  late double _cardHeight;
  late double _space;
  late double _padStartSpace;
  late int _stage;
  late List<int> _randomIndexes;

  late bool _isMobile;

  @override
  void initState() {
    _setupValues();
    _stage = 1;
    _randomIndexes = List.generate(Constants.kCardsCount, (index) => index);
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    _setupValues();
    super.didUpdateWidget(oldWidget);
  }

  void _setupValues() {
    _isMobile = widget.width < Constants.kTabletWidthScreen;

    late double cardWidthRelative;
    if (widget.width < Constants.kTabletWidthScreen) {
      cardWidthRelative = Constants.kCardWidthProportionMobile;
    } else if (widget.width < Constants.kDesktopWidthScreen) {
      cardWidthRelative = Constants.kCardWidthProportionTablet;
    } else {
      cardWidthRelative = Constants.kCardWidthProportion;
    }

    _cardWidth = widget.width * cardWidthRelative;
    _cardHeight = _cardWidth / Constants.kCardAspect;
    _space = Constants.space;
    _padStartSpace = Constants.nLateralSpaces * _space;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        /*Row(
          children: List.generate(
            7,
            (index) {
              return ElevatedButton(
                onPressed: () => _setStage(index + 1),
                child: Text('${index + 1}'),
              );
            },
          ),
        ),*/
        ...List.generate(
          Constants.kCardsCount,
          (index) {
            return _buildCard(index);
          },
        ),
        Positioned(
          bottom: _isMobile ? 300 : widget.height * 0.2,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            curve: Curves.ease,
            opacity: _stage == 1 ? 1 : 0,
            child: _stage < 3
                ? SizedBox(
                    height: 53,
                    width: _isMobile ? 300 : 376,
                    child: ElevatedButton(
                      onPressed: _startSequence,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'EMBARALHAR AS CARTAS',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        Positioned(
          top: 10,
          left: _isMobile ? 27 : null,
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            switchInCurve: const Interval(
              0,
              0.5,
              curve: Curves.easeIn,
            ),
            switchOutCurve: const Interval(
              0.5,
              1,
              curve: Curves.easeOut,
            ),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Text(
              Constants.titleByStage[_stage != 7 ? _stage - 1 : 5],
              textAlign: TextAlign.start,
              key: ValueKey<String>(
                  Constants.titleByStage[_stage != 7 ? _stage - 1 : 5]),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: _isMobile ? 24 : 32,
                fontWeight: FontWeight.w700,
                fontFamily: 'IBM Plex Serif',
              ),
            ),
          ),
        ),
        Positioned(
          top: 60,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: (widget.width > 644 ? 644 : widget.width) - 54),
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0.0, 0.1),
                          end: const Offset(0, 0))
                      .animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: _stage <= 5
                  ? Text(
                      Constants.textByStage[_stage - 1],
                      textAlign: _isMobile ? TextAlign.start : TextAlign.center,
                      key: ValueKey<String>(Constants.textByStage[_stage - 1]),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(int index) {
    return TarotCard(
      top: _yPosition(index),
      left: _xPosition(index),
      cardWidth: _isMobile ? 50 : _cardWidth,
      index: _randomIndexes[index],
      rotation: _getRotation(index),
      iteractable: _stage == 7,
      isMobile: _isMobile,
      duration: _getDuration(),
      onTap: () {
        print('abrir carta $index');
      },
    );
  }

  void _startSequence() async {
    setState(() {
      _randomIndexes.shuffle();
    });

    for (int i = 2; i <= STAGES_COUNT; i++) {
      _setStage(i);
      final completeDuration = _getDuration() + const Duration(seconds: 1);
      await Future.delayed(completeDuration);
    }
  }

  void _setStage(int newStage) {
    print('Novo estado: $newStage');
    setState(() {
      _stage = newStage;
    });
  }

  Duration _getDuration() {
    switch (_stage) {
      case 1:
      case 7:
        return const Duration(seconds: 1);
      default:
        return const Duration(seconds: 2);
    }
  }

  double _xPosition(int n) {
    const int maxNRow = 5;
    int col = _isMobile && _stage >= 5 ? n % maxNRow : n % Constants.nCol;
    int row =
        _isMobile && _stage >= 5 ? n ~/ maxNRow : n ~/ (Constants.nCol + 2);
    switch (_stage) {
      case 1:
        final mdWidth = _cardWidth * 0.4 * (Constants.nCol + 1) / 2;
        return (widget.width / 2 - mdWidth) + col * _cardWidth * 0.4;
      case 2:
      case 4:
        return (widget.width - _cardWidth) / 2;
      case 3:
        if (_isMobile) {
          final offset =
              (widget.width - _cardWidth) / (Constants.kCardsCount - 1);
          return offset * n + offset / 2;
        }

        final col = n % (Constants.nCol + 2);
        final firstRow = row == 0;
        return col.toDouble() * (firstRow ? _cardWidth : _cardWidth + 30) +
            (firstRow ? 0 : 30) +
            (widget.width / 2 - (_cardWidth * (Constants.nCol + 2)) / 2);

      case 5:
        return widget.width - _cardWidth - _padStartSpace;
      case 6:
      case 7:
        final spaceCard = _cardWidth + _space + 5;
        return _isMobile
            ? ((_cardWidth + _space) * col.toDouble() + 27)
            : ((widget.width - (spaceCard) * Constants.nCol) / 2 +
                (spaceCard) * col.toDouble());
      default:
        return 0;
    }
  }

  double _yPosition(int n) {
    const int maxNRow = 5;
    int col = _isMobile && _stage >= 5 ? n % maxNRow : n % Constants.nCol;
    int row = _isMobile && _stage >= 5 ? n ~/ maxNRow : n ~/ Constants.nCol;

    switch (_stage) {
      case 1:
      case 4:
        final offsetY = _isMobile ? 20 : 0;

        return widget.height * Constants.kStage1yOffset +
            (_cardHeight * (_isMobile ? 0.2 : 0.3)) * row.toDouble() +
            pow(col - Constants.nCol / 2 + 1, 2) * Constants.kYAlphaStage1 +
            offsetY;

      case 2:
      case 3:
        return (widget.height - _cardHeight) / 2 - 100;

      case 5:
        return (_isMobile ? widget.height * 0.7 : widget.height) -
            _cardHeight * 2 -
            _padStartSpace * 2;

      case 6:
      case 7:
      default:
        return (_isMobile ? widget.height / 2 : widget.height) *
                Constants.kStage7yOffset +
            ((_isMobile ? 100 : _cardHeight) + _space + 5) * row.toDouble();
    }
  }

  double _getRotation(int n) {
    int col = n % Constants.nCol;
    switch (_stage) {
      case 1:
      case 4:
        return 2 * Constants.kModRotation * (col / (Constants.nCol - 1)) -
            Constants.kModRotation;
      case 2:
      case 3:
      case 5:
      case 6:
      case 7:
        return 0.00;

      default:
        return 0.0;
    }
  }
}
