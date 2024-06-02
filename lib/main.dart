import 'package:flutter/material.dart';
import 'package:tarot_de_maria/src/screens/loading/loading.screen.dart';
import 'package:tarot_de_maria/src/screens/tarot-game/tarot_game.screen.dart';
import 'package:tarot_de_maria/tarot_card_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarot - Carta do Dia',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(72, 41, 101, 1),
      ),
      routes: {
        '/loading': _createLoadingScreen,
        '/game': _createTarotGameScreen,
        '/card-details': _createTarotCardDetailsScreen,
      },
      initialRoute: '/loading',
    );
  }

  Widget _createLoadingScreen(BuildContext context) {
    return const LoadingScreen();
  }

  Widget _createTarotGameScreen(BuildContext context) {
    return const TarotGameScreen();
  }

  Widget _createTarotCardDetailsScreen(BuildContext context) {
    int cardDataIndex = ModalRoute.of(context)?.settings.arguments as int;
    return TarotCardDetails(cardDataIndex: cardDataIndex);
  }
}
