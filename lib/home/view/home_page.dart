import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/common/samain_facts.dart';
import 'package:tictactoe/home/cubit/home_cubit.dart';
import 'package:tictactoe/home/view/home_form.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.facts}) : super(key: key);

  final SamainFacts facts;

  Page page() => MaterialPage<void>(child: HomePage(facts: facts));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: HomeForm(facts: facts),
    );
  }
}
