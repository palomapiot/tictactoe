part of 'home_cubit.dart';

class HomeState {
  HomeState({
    this.scoreX = 0,
    this.scoreO = 0,
    this.turnO = true,
    this.filledNr = 0,
    this.winner = '',
    required this.game,
  });

  final int scoreX;
  final int scoreO;
  final bool turnO;
  final int filledNr;
  final String winner;
  List<String> game;

  HomeState copyWith({
    int? scoreX,
    int? scoreO,
    bool? turnO,
    int? filledNr,
    String? winner,
    List<String>? game,
  }) {
    return HomeState(
      scoreX: scoreX ?? this.scoreX,
      scoreO: scoreO ?? this.scoreO,
      turnO: turnO ?? this.turnO,
      filledNr: filledNr ?? this.filledNr,
      winner: winner ?? this.winner,
      game: game ?? this.game,
    );
  }
}
