import 'package:bloc/bloc.dart';
import 'package:quiver/iterables.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState(game: List.filled(9, '')),
        );

  void scoreXChanged(int value) {
    emit(
      state.copyWith(
        scoreX: value,
      ),
    );
  }

  void score0Changed(int value) {
    emit(
      state.copyWith(
        scoreO: value,
      ),
    );
  }

  void newTurn(int index) {
        if (state.turnO && state.game[index] == '') {
          state.game[index] = 'O';
        } else if (!state.turnO && state.game[index] == '') {
          state.game[index] = 'X';
        }

        emit(
          state.copyWith(
            game: state.game,
            turnO: !state.turnO,
            filledNr: state.filledNr + 1
          ),
        );
        checkWinner();
  }

  void checkWinner() {
    var board = partition(state.game, 3);
    var winner = checkRows(board);

    if (winner == '') {
      winner = checkColumns(board);
    }
    if (winner == '' ) {
      winner = checkDiagonals(board);
    }

    if (winner == 'O') {
       emit(state.copyWith(scoreO: state.scoreO + 1, winner: 'O'));
    } else if (winner == 'X') {
      emit(state.copyWith(scoreO: state.scoreX + 1, winner: 'X'));
    } else if (state.filledNr == 9) {
      emit(state.copyWith(winner: 'Draw'));
    }
  }

  String checkRows(Iterable<List<String>> board) {
    for (var row in board) {
      if (row.toSet().length == 1) {
        return row[0];
      }
    }
    return '';
  }

  String checkColumns(Iterable<List<String>> board) {
    if (board.elementAt(0)[0] == board.elementAt(1)[0] && board.elementAt(1)[0] == board.elementAt(2)[0]) {
      return board.elementAt(0)[0];
    }
    if (board.elementAt(0)[1] == board.elementAt(1)[1] && board.elementAt(1)[1] == board.elementAt(2)[1]) {
      return board.elementAt(0)[1];
    }
    if (board.elementAt(0)[2] == board.elementAt(1)[2] && board.elementAt(1)[2] == board.elementAt(2)[2]) {
      return board.elementAt(0)[2];
    }
    return '';
  }

  String checkDiagonals(Iterable<List<String>> board) {
    if (board.elementAt(0)[0] == board.elementAt(1)[1] && board.elementAt(1)[1] == board.elementAt(2)[2]) {
      return board.elementAt(0)[0];
    }
    if (board.elementAt(0)[2] == board.elementAt(1)[1] && board.elementAt(1)[1] == board.elementAt(2)[0]) {
      return board.elementAt(0)[2];
    }
    return '';
  }


  void resetGame() {
    emit(
      state.copyWith(
          scoreX: 0,
          scoreO: 0,
          turnO: true,
          filledNr: 0,
          winner: '',
          game: List.filled(9, ''),
      ),
    );
  }
}
