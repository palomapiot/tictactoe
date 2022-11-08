import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:tictactoe/common/samain_facts.dart';
import 'package:tictactoe/home/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/custom_text.dart';

class HomeForm extends StatelessWidget {
  const HomeForm({Key? key, required this.facts}) : super(key: key);

  final SamainFacts facts;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (context.read<HomeCubit>().state.winner != '') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Dialogs.materialDialog(
            title: state.winner + ' has won!',
            msg: 'Did you know..? ' + facts.getFact(),
            lottieBuilder: Lottie.asset(
              'img/pumpkin.json',
              fit: BoxFit.contain,
              repeat: true,
            ),
            color: Colors.white,
            context: context,
            actions: [
              IconsButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'New Game',
                iconData: Icons.play_arrow_rounded,
                color: Colors.deepOrangeAccent,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ],
          ).then((dynamic value) {
            context.read<HomeCubit>().resetGame();
          });
        });
      }
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[900],
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<HomeCubit>().resetGame();
              },
            )
          ],
          title: Text(
            'Tic Tac Toe',
            style: kCustomText(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w800),
          ),
        ),
        backgroundColor: Colors.grey[900],
        body: Column(
          children: [
            _scoreboard(context),
            _board(context),
            _turn(context),
          ],
        ),
      );
    });
  }
}

Widget _scoreboard(BuildContext context) {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            children: [
              Text(
                'Player O',
                style: kCustomText(
                    fontSize: 22,
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                context.read<HomeCubit>().state.scoreO.toString(),
                style: kCustomText(
                    color: Colors.deepOrangeAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: Column(
            children: [
              Text(
                'Player X',
                style: kCustomText(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                context.read<HomeCubit>().state.scoreX.toString(),
                style: kCustomText(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _board(BuildContext context) {
  return Expanded(
    flex: 3,
    child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              context.read<HomeCubit>().newTurn(index);
            },
            child: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    previous.filledNr != current.filledNr,
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade700)),
                    child: Center(
                      child: Text(
                        context.read<HomeCubit>().state.game[index],
                        style: TextStyle(
                          color:
                              context.read<HomeCubit>().state.game[index] == 'X'
                                  ? Colors.white
                                  : Colors.deepOrangeAccent,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  );
                }),
          );
        }),
  );
}

Widget _turn(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Center(
      child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => previous.turnO != current.turnO,
          builder: (context, state) {
            return Text(
              context.read<HomeCubit>().state.turnO ? 'Turn of O' : 'Turn of X',
              style: kCustomText(color: Colors.white),
            );
          }),
    ),
  );
}
