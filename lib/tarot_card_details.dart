import 'package:flutter/material.dart';
import 'package:tarot_de_maria/src/commom/constants.dart';
import 'package:tarot_de_maria/src/model/card-data.dart';

class TarotCardDetails extends StatefulWidget {
  final int cardDataIndex;

  const TarotCardDetails({
    super.key,
    required this.cardDataIndex,
  });

  @override
  State<TarotCardDetails> createState() => _TarotCardDetailsState();
}

class _TarotCardDetailsState extends State<TarotCardDetails> {
  late CardData card = _cardsData[widget.cardDataIndex];

  @override
  void initState() {
    super.initState();
  }

  double _getHeight(double screenWidth) {
    if (screenWidth <= Constants.kTabletWidthScreen) {
      return 848;
    } else if (screenWidth < Constants.kDesktopWidthScreen) {
      return 582;
    }
    return 686;
  }

  double _getWidthImgCard(double screenWidth) {
    if (screenWidth <= Constants.kTabletWidthScreen) {
      return 202;
    } else if (screenWidth < Constants.kTabletWidthScreen) {
      return 238;
    }
    return 308;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        double contentWidth =
            constraints.maxWidth > Constants.kDesktopWidthScreen
                ? Constants.kDesktopWidthScreen
                : constraints.maxWidth;
        double height = _getHeight(contentWidth);

        final imgCardWidth = _getWidthImgCard(contentWidth);
        final bool isMobile = contentWidth < Constants.kTabletWidthScreen;

        print('width x height');
        print('$contentWidth x $height');

        return Container(
          color: const Color(0xfffaf1e9),
          child: Center(
            child: Container(
              height: height,
              width: contentWidth,
              color: const Color(0xfffaf1e9),
              child: Scrollbar(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 16,
                      children: [
                        SizedBox(
                          width: imgCardWidth,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            elevation: 4,
                            shadowColor:
                                const Color.fromARGB(109, 155, 155, 155),
                            child: AspectRatio(
                              aspectRatio: Constants.kCardAspect,
                              child: Center(
                                child: Image.asset(
                                    'assets/front/${widget.cardDataIndex}.jpg'),
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxWidth: Constants.kDetailsCardWidth),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card.nome,
                                style: TextStyle(
                                  fontSize: isMobile ? 24 : 32,
                                  color: const Color(0xff492966),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'IBM Plex Serif',
                                ),
                              ),
                              const SizedBox(
                                height: 37,
                              ),
                              Wrap(
                                spacing: 16,
                                runSpacing: isMobile ? 16 : 40,
                                children: [
                                  Wrap(
                                    children: [
                                      _buildField('Referência', card.referencia,
                                          isMobile),
                                      _buildField(
                                          'Elemento', card.elemento, isMobile)
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      _buildField(
                                          'Regência', card.regencia, isMobile),
                                      _buildField('Luz do Arcano',
                                          card.luzDoArcano, isMobile),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      _buildField('Sombra do Arcano',
                                          card.sombraDoArcano, isMobile),
                                      _buildField('Conselho de Maria',
                                          card.conselhoDeMaria, isMobile),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  _buildField(String label, String value, bool isMobile) {
    return SizedBox(
      width: isMobile
          ? Constants.kDetailsCardFieldWidth - 60
          : Constants.kDetailsCardFieldWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSubHeader(label, isMobile),
          SizedBox(
            height: isMobile ? 16 : 24,
          ),
          _buildText(value),
        ],
      ),
    );
  }

  _buildSubHeader(String text, bool isMobile) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xff492966),
        fontSize: isMobile ? 20 : 24,
        fontWeight: FontWeight.w700,
        fontFamily: 'IBM Plex Serif',
      ),
    );
  }

  _buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),
    );
  }
}

List<CardData> _cardsData = [
  {
    "Nome da Carta": "FADA MARIA – 0",
    "Referência": "O Louco",
    "Elemento": "Ar",
    "Regência": "Planeta Urano",
    "Luz do Arcano": "Curiosidade e Coragem",
    "Sombra do Arcano": "Ignorar a Realidade",
    "Conselho de Maria": "Para encontrar tem que procurar."
  },
  {
    "Nome da Carta": "MARIA MAGIA - I",
    "Referência": "O Mago",
    "Elemento": "Ar",
    "Regência": "Planeta Mercúrio",
    "Luz do Arcano": "Buscar conhecimento técnico e científico.",
    "Sombra do Arcano": "Vaidade com conhecimento superficial.",
    "Conselho de Maria":
        "Conhecer novas habilidades é essencial para encontrar sua verdadeira missão."
  },
  {
    "Nome da Carta": "CORAÇÃO DE MARIA – II",
    "Referência": "A Sacerdotisa",
    "Elemento": "Água",
    "Regência": "A Lua",
    "Luz do Arcano": "Sabedoria profunda advinda da intuição.",
    "Sombra do Arcano": "Confusão e fuga dos sentimentos.",
    "Conselho de Maria": "Precisa ser profundo para atingir sabedoria."
  },
  {
    "Nome da Carta": "MARIA FERTILIDADE – III",
    "Referência": "A Imperatriz",
    "Elemento": "Água",
    "Regência": "Planeta Vênus",
    "Luz do Arcano": "Abundância, prosperidade e fertilidade.",
    "Sombra do Arcano": "Desequilíbrio do dar e receber.",
    "Conselho de Maria": "A energia feminina é a gestação da vida."
  },
  {
    "Nome da Carta": "MARIA IMPÉRIO - IV",
    "Referência": "O Imperador",
    "Elemento": "Fogo",
    "Regência": "Signo de Áries",
    "Luz do Arcano": "Direcionamento e definição de caminhos.",
    "Sombra do Arcano": "Rigidez e Austeridade",
    "Conselho de Maria":
        "A energia masculina motiva para enfrentar desafios e definir escolhas."
  },
  {
    "Nome da Carta": "O PAPA - V",
    "Referência": "O Papa",
    "Elemento": "Terra",
    "Regência": "Signo de Touro",
    "Luz do Arcano": "Aprendizado com Sabedoria.",
    "Sombra do Arcano": "Arrogância e teimosia.",
    "Conselho de Maria":
        "A sabedoria mais divina é aquela oriunda da descoberta ancestral."
  },
  {
    "Nome da Carta": "MARIA NAMORADEIRA - VI",
    "Referência": "Os Enamorados",
    "Elemento": "Ar",
    "Regência": "Signo de Gêmeos",
    "Luz do Arcano": "Encantamento e escolhas.",
    "Sombra do Arcano": "Indecisão e excesso de dúvidas.",
    "Conselho de Maria":
        "A impermanência é a única certeza da nossa condição humana."
  },
  {
    "Nome da Carta": "MARIA DOS VENTOS - VII",
    "Referência": "O Carro",
    "Elemento": "Água",
    "Regência": "Signo de Câncer",
    "Luz do Arcano": "Vitória advinda de luta e definição de caminhos.",
    "Sombra do Arcano": "Competitividade e disputa.",
    "Conselho de Maria":
        "Vencer a si mesmo é a maior conquista que o ser humano pode ter no caminho da iluminação."
  },
  {
    "Nome da Carta": "MARIA PEQUENA - VIII",
    "Referência": "A Força",
    "Elemento": "Fogo",
    "Regência": "Signo de Leão",
    "Luz do Arcano": "Criança interior, essência e liberdade.",
    "Sombra do Arcano": "Emoções reprimidas e feridas da infância.",
    "Conselho de Maria":
        "Para ser grandioso em qualquer aspecto, é necessário ter sido pequeno, e focado nas pequenas ações, pois são elas que transformam o mundo."
  },
  {
    "Nome da Carta": "MARIA SOLITUDE - IX",
    "Referência": "O Ermitão",
    "Elemento": "Terra",
    "Regência": "Signo de Virgem",
    "Luz do Arcano": "Paciência e paz interior.",
    "Sombra do Arcano": "Solidão e falta de confiança.",
    "Conselho de Maria":
        "Para encontrar a paz, é necessário iluminar suas origens. Conhecimento ancestral é autoconhecimento puro."
  },
  {
    "Nome da Carta": "MARIAZINHA - X",
    "Referência": "A Roda da Fortuna",
    "Elemento": "Ar",
    "Regência": "Planeta Júpiter",
    "Luz do Arcano": "Prosperidade, sorte e mudança.",
    "Sombra do Arcano":
        "Ciclos repetitivos, padrões comportamentais inconscientes.",
    "Conselho de Maria":
        "Você é parte do universo, e tudo, exatamente tudo, está em constante renovação."
  },
  {
    "Nome da Carta": "MARIA ÁGUIA - XI",
    "Referência": "A Justiça",
    "Elemento": "Ar",
    "Regência": "Signo de Libra",
    "Luz do Arcano": "Luz, justiça e integridade.",
    "Sombra do Arcano": "Excesso de racionalidade e formalismo.",
    "Conselho de Maria":
        "Justiça está diretamente atrelada a concepção do merecimento advindo das ações. Consequência da ação."
  },
  {
    "Nome da Carta": "MARIA SACRIFICADA - XII",
    "Referência": "O Enforcado",
    "Elemento": "Água",
    "Regência": "Planeta Netuno",
    "Luz do Arcano": "Amor próprio e amor incondicional.",
    "Sombra do Arcano": "Sacrifícios repetidos sem aprendizado.",
    "Conselho de Maria":
        "O sagrado ofício é um dom, um presente de Deus para sua missão."
  },
  {
    "Nome da Carta": "ROSA MARIA CAVEIRA - XIII",
    "Referência": "A Morte",
    "Elemento": "Água",
    "Regência": "Signo de Escorpião",
    "Luz do Arcano": "Transformação, renovação e renascimento.",
    "Sombra do Arcano": "Dificuldade em aceitar a terminalidade.",
    "Conselho de Maria":
        "Para todo início há um fim, para todo fim há um início."
  },
  {
    "Nome da Carta": "MARIA CURANDEIRA - XIV",
    "Referência": "A Temperança",
    "Elemento": "Fogo",
    "Regência": "Signo de Sagitário",
    "Luz do Arcano": "Cura, milagres e vitalidade.",
    "Sombra do Arcano": "Procrastinação da sua missão.",
    "Conselho de Maria":
        "Bendita são as mãos que abençoam, afagam, alimentam e se unem."
  },
  {
    "Nome da Carta": "MARIA ATRATIVA - XV",
    "Referência": "O Diabo",
    "Elemento": "Terra",
    "Regência": "Signo de Capricórnio",
    "Luz do Arcano": "Atração, conexão e vibração.",
    "Sombra do Arcano": "Enganos, luxúria e ganância.",
    "Conselho de Maria": "O verdadeiro magnetismo da mente é o coração."
  },
  {
    "Nome da Carta": "FENDAS DE MARIA - XVI",
    "Referência": "A Torre",
    "Elemento": "Fogo",
    "Regência": "Planeta Marte",
    "Luz do Arcano": "Mudança, ruptura do que não serve mais.",
    "Sombra do Arcano": "Agitação, inquietação e ansiedade.",
    "Conselho de Maria":
        "Romper padrões que causam angústia, é se permitir ser feliz. Seja você."
  },
  {
    "Nome da Carta": "MARIA ESTRELA - XVII",
    "Referência": "A Estrela",
    "Elemento": "Ar",
    "Regência": "Signo de Aquário",
    "Luz do Arcano": "Entendimento da ancestralidade feminina.",
    "Sombra do Arcano": "Lidar com o oculto, que está escondido.",
    "Conselho de Maria":
        "A noite é escura, mas ninguém proibiu você de brilhar."
  },
  {
    "Nome da Carta": "MARIA DA LUA - XVIII",
    "Referência": "A Lua",
    "Elemento": "Água",
    "Regência": "Signo de Peixes",
    "Luz do Arcano": "Clarear as sombras, revelações.",
    "Sombra do Arcano": "Medo, covardia e inquietação.",
    "Conselho de Maria": "A coragem é o enfrentamento da sua própria covardia."
  },
  {
    "Nome da Carta": "MARISOL - XIX",
    "Referência": "O Sol",
    "Elemento": "Éter",
    "Regência": "O Sol",
    "Luz do Arcano": "Sucesso, clareza e revelação.",
    "Sombra do Arcano": "Sinceridade exacerbada e exposição desnecessária.",
    "Conselho de Maria": "O sol faz morada no seu coração. Acenda-se."
  },
  {
    "Nome da Carta": "O JUÍZO DE MARIA - XX",
    "Referência": "O Julgamento",
    "Elemento": "Terra",
    "Regência": "Planeta Plutão",
    "Luz do Arcano": "Ordem, firmeza e decisão.",
    "Sombra do Arcano": "Arrogância e frieza.",
    "Conselho de Maria": "O seu julgamento é modulado pelo seu olhar."
  },
  {
    "Nome da Carta": "O MUNDO DE MARIA - XXI",
    "Referência": "O Mundo ",
    "Elemento": "Terra",
    "Regência": "Planeta Saturno",
    "Luz do Arcano": "Realização, viagens e abertura.",
    "Sombra do Arcano": "Festejar com exagero a ponto de comprometer a saúde.",
    "Conselho de Maria":
        "Aceitar quem você é, é um passo decisivo para o sucesso."
  }
]
    .map((e) => CardData(
          nome: e['Nome da Carta']!,
          referencia: e['Referência']!,
          elemento: e['Elemento']!,
          regencia: e['Regência']!,
          luzDoArcano: e['Luz do Arcano']!,
          sombraDoArcano: e['Sombra do Arcano']!,
          conselhoDeMaria: e['Conselho de Maria']!,
        ))
    .toList();
