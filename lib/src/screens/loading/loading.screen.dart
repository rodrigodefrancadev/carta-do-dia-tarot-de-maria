import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      _checkAndGoToNextScreen(context);
    });

    return Scaffold(
      body: Container(
        color: const Color(0xfffaf1e9),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Carregando',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'IBM Plex Serif',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  _checkAndGoToNextScreen(BuildContext context) async {
    final navigator = Navigator.of(context);

    await _setupMetadata();

    final existCardSelected = await _existCardSelected();

    if (existCardSelected) {
      try {
        final cardIndex = await _getCardIndexLocalStorage();
        _navigateToCardDetailsScreen(navigator, cardIndex);
      } catch (_) {
        _navigateToGameScreen(navigator);
      }
    } else {
      _navigateToGameScreen(navigator);
    }
  }

  _setupMetadata() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      const version = 'v1.0.1';
      prefs.setString('meta.version', version);
    } catch (e) {
      print('Não foi possível acessar o local storage');
    }
  }

  _existCardSelected() async {
    bool existCard = false;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      /* prefs.clear(); */
      final String? dateString = prefs.getString('date');

      if (dateString != null) {
        final dateTimeToday = DateTime.now();

        final dayToday = dateTimeToday.day;
        final monthToday = dateTimeToday.month;
        final yearToday = dateTimeToday.year;

        final dateTimeLocalStorage = DateTime.parse(dateString);
        final dayLocalStorage = dateTimeLocalStorage.day;
        final monthLocalStorage = dateTimeLocalStorage.month;
        final yearLocalStorage = dateTimeLocalStorage.year;

        final dateToday = DateTime(yearToday, monthToday, dayToday);
        final dateLocalStorage =
            DateTime(yearLocalStorage, monthLocalStorage, dayLocalStorage);

        final isBefore = dateLocalStorage.isBefore(dateToday);
        existCard = !isBefore;
      }
    } catch (e) {
      print('Não foi possível acessar o local storage');
    }
    return existCard;
  }

  Future<int> _getCardIndexLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cardIndex = prefs.getInt('index');
    if (cardIndex == null) {
      throw Exception("Card index não encontrato no LocalStorage");
    }
    return cardIndex;
  }

  _navigateToCardDetailsScreen(NavigatorState navigator, int cardIndex) {
    return navigator.pushNamedAndRemoveUntil(
      '/card-details',
      (route) => false,
      arguments: cardIndex,
    );
  }

  _navigateToGameScreen(NavigatorState navigator) {
    navigator.pushNamedAndRemoveUntil('/game', (route) => false);
  }
}
