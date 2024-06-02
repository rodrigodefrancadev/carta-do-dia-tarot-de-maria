import 'package:flutter/material.dart';
import 'package:tarot_de_maria/src/commom/constants.dart';
import 'package:tarot_de_maria/src/screens/tarot-game/widgets/tarot_game.dart';

class TarotGameScreen extends StatelessWidget {
  const TarotGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        double gameWidth = _getGameWidth(maxWidth);
        double gameHeight = _getGameHeight(gameWidth);

        return Container(
          color: const Color(0xfffaf1e9),
          child: ListView(
            children: [
              Center(
                child: Container(
                  height: gameHeight,
                  width: gameWidth,
                  color: const Color(0xfffaf1e9),
                  child: TartotGame(
                    width: gameWidth,
                    height: gameHeight,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  double _getGameWidth(double maxWidth) {
    double width = maxWidth > Constants.kDesktopWidthScreen
        ? Constants.kDesktopWidthScreen
        : maxWidth;
    return width;
  }

  double _getGameHeight(double screenWidth) {
    if (screenWidth <= Constants.kTabletWidthScreen) {
      return 848;
    } else if (screenWidth < Constants.kDesktopWidthScreen) {
      return 582;
    }
    return 686;
  }
}
