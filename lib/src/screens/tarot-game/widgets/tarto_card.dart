import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_de_maria/src/commom/constants.dart';
import 'package:tarot_de_maria/tarot_card_details.dart';

class TarotCard extends StatefulWidget {
  final double top;
  final double left;
  final double cardWidth;
  final int index;
  final double rotation;
  final bool iteractable;
  final Duration duration;
  final VoidCallback onTap;
  final bool isMobile;

  const TarotCard(
      {super.key,
      required this.top,
      required this.left,
      required this.cardWidth,
      required this.index,
      required this.rotation,
      required this.iteractable,
      required this.duration,
      required this.isMobile,
      required this.onTap});

  @override
  State<TarotCard> createState() => _TarotCardState();
}

class _TarotCardState extends State<TarotCard>
    with SingleTickerProviderStateMixin {
  late double _internalRotation;
  late double _scale;

  @override
  void initState() {
    _internalRotation = 0;
    _scale = 1;
    super.initState();
  }

  void _onMouseEnter() {
    setState(() {
      _internalRotation = Constants.kHoverRotation;
      _scale = Constants.kHoverScale;
    });
  }

  void _onMouseExit() {
    setState(() {
      _internalRotation = 0;
      _scale = 1;
    });
  }

  _onTap(BuildContext context) async {
    /* _flipCardcontroller.toggleCard(); */

    try {
      final prefs = await SharedPreferences.getInstance();

      prefs.setInt('index', widget.index);
      prefs.setString('date', DateTime.now().toIso8601String());
    } catch (e) {
      print('Não foi possível acessar o local storage');
    }

    await Future.delayed(
      const Duration(milliseconds: 500),
      () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          fullscreenDialog: true,
          pageBuilder: (context, animation, secondaryAnimation) =>
              TarotCardDetails(cardDataIndex: widget.index),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);

            final curvedAnimation = CurvedAnimation(
              parent: offsetAnimation,
              curve: Curves.ease,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: widget.duration,
      curve: Curves.ease,
      top: widget.top,
      left: widget.left,
      child: InkWell(
        onHover: (value) => value ? _onMouseEnter() : _onMouseExit(),
        /* onTap: widget.iteractable ? widget.onTap : null, */
        onTap: widget.iteractable ? () => _onTap(context) : null,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 300),
          scale: widget.iteractable ? _scale : 1,
          curve: Curves.ease,
          child: AnimatedRotation(
            duration: widget.iteractable
                ? const Duration(milliseconds: 300)
                : widget.duration,
            curve: Curves.ease,
            turns: widget.iteractable ? _internalRotation : widget.rotation,
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    widget.isMobile ? 4 : Constants.kCornerRadiusCard),
              ),
              elevation: 4,
              shadowColor: const Color.fromARGB(109, 155, 155, 155),
              child: SizedBox(
                width: widget.cardWidth,
                child: AspectRatio(
                  aspectRatio: Constants.kCardAspect,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          widget.isMobile ? 4 : Constants.kCornerRadiusCard),
                      color: const Color(0xffe5e3d6),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            widget.isMobile ? 4 : Constants.kCornerRadiusCard),
                        child: Image.asset('assets/back.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
