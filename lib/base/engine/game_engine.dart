import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:game2048/base/directions/axis_movement.dart';
import 'package:game2048/base/directions/gesture_directions.dart';

class GameEngine extends ChangeNotifier {
  int size;

  GameEngine({required this.size}) {
    initGridState();
  }

  List<List<int>> grid = [];

  int score = 0;

  int isGameWon = -1;

  bool isGridMoved = false;

  ///
  /// Grid methods
  ///
  void initGrid() {
    grid = List.generate(size, (_) => List.generate(size, (_) => 0));
  }

  void initGridState() {
    initGrid();
    Map<String, int> firstRandomCell = {
      'row': Random().nextInt(size),
      'col': Random().nextInt(size),
    };

    grid[firstRandomCell['row'] as int][firstRandomCell['col'] as int] =
        chooseRandomlyTwoOrFour();

    Map<String, int> secondRandomCell;
    do {
      secondRandomCell = {
        'row': Random().nextInt(size),
        'col': Random().nextInt(size)
      };
    } while (firstRandomCell['row'] == secondRandomCell['row'] &&
        firstRandomCell['col'] == secondRandomCell['col']);

    grid[secondRandomCell['row'] as int][secondRandomCell['col'] as int] =
        chooseRandomlyTwoOrFour();

    initScore();
    initIsGameWon();
    notifyListeners();
  }

  void initScore() {
    score = 0;
  }

  void initIsGameWon() {
    isGameWon = -1;
  }

  ///
  /// Utils methods
  ///
  int chooseRandomlyTwoOrFour() {
    int value = Random().nextInt(100) % 2 == 0 ? 2 : 4;
    return value;
  }

  AxisDirection getDirection(GestureDirection swipeType) {
    if (swipeType == GestureDirection.swipeLeft || swipeType == GestureDirection.swipeRight) {
      return AxisDirection.sideToSide;
    } else {
      return AxisDirection.upDown;
    }
  }

  void swapValues(int row1, int col1, int row2, int col2) {
    int temp = grid[row1][col1];
    grid[row1][col1] = grid[row2][col2];
    grid[row2][col2] = temp;
    isGridMoved = true;
  }

  void moveColumnUp(int col) {
    for (int i = 0; i < size; i++) {
      int temp = i;
      while (temp != 0 && grid[temp][col] != 0 && grid[temp - 1][col] == 0) {
        swapValues(temp, col, temp - 1, col);
        temp = temp - 1;
      }
    }
  }

  void moveColumnDown(int col) {
    for (int i = size - 1; i >= 0; i--) {
      int temp = i;
      while (temp != size - 1 &&
          grid[temp][col] != 0 &&
          grid[temp + 1][col] == 0) {
        swapValues(temp, col, temp + 1, col);
        temp = temp + 1;
      }
    }
  }

  void moveRowLeft(int row) {
    for (int i = 0; i < size; i++) {
      int temp = i;
      while (temp != 0 && grid[row][temp] != 0 && grid[row][temp - 1] == 0) {
        swapValues(row, temp, row, temp - 1);
        temp = temp - 1;
      }
    }
  }

  void moveRowRight(int row) {
    for (int i = size - 1; i >= 0; i--) {
      int temp = i;
      while (temp != size - 1 &&
          grid[row][temp] != 0 &&
          grid[row][temp + 1] == 0) {
        swapValues(row, temp, row, temp + 1);
        temp = temp + 1;
      }
    }
  }

  bool areNeighborsVertically(int row1, int col1, int row2, int col2) {
    if (col1 == col2 && (row1 - row2).abs() == 1) {
      return true;
    }

    return false;
  }

  bool areNeighborsHorizontally(int row1, int col1, int row2, int col2) {
    if (row1 == row2 && (col1 - col2).abs() == 1) {
      return true;
    }

    return false;
  }

  bool areSeparatedByEmptyCellsVertically(
      int row1, int col1, int row2, int col2) {
    if (col1 == col2 && (row1 - row2).abs() > 1) {
      int minRow = min(row1, row2);
      int maxRow = max(row1, row2);

      for (int i = minRow + 1; i < maxRow; i++) {
        if (grid[i][col1] != 0) {
          return false;
        }
      }

      return true;
    }

    return false;
  }

  bool areSeparatedByEmptyCellsHorizontally(
      int row1, int col1, int row2, int col2) {
    if (row1 == row2 && (col1 - col2).abs() > 1) {
      int minCol = min(col1, col2);
      int maxCol = max(col1, col2);

      for (int i = minCol + 1; i < maxCol; i++) {
        if (grid[row1][i] != 0) {
          return false;
        }
      }

      return true;
    }

    return false;
  }

  bool haveSameValues(int row1, int col1, int row2, int col2) {
    return grid[row1][col1] == grid[row2][col2];
  }

  int handleSum(int row1, int col1, int row2, int col2) {
    notifyListeners();
    return grid[row1][col1] + grid[row2][col2];
  }

  void generateRandomlyNewCell() {
    List<Map<String, int>> emptyCells = getEmptyCells();
    if (emptyCells.isNotEmpty) {
      int index = Random().nextInt(emptyCells.length);
      Map<String, int> cell = emptyCells[index];
      grid[cell['row'] as int][cell['col'] as int] = chooseRandomlyTwoOrFour();
    }
  }

  List<Map<String, int>> getEmptyCells() {
    List<Map<String, int>> emptyCells = [];
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (grid[i][j] == 0) {
          emptyCells.add({'row': i, 'col': j});
        }
      }
    }

    return emptyCells;
  }

  void increaseScore(int value) {
    score += value;
  }

  //
  // Getters
  //
  List getGrid() {
    return grid;
  }

  ///
  /// Game methods
  ///
  void moveGrid(GestureDirection swipeType) {
    switch (swipeType) {
      case GestureDirection.swipeLeft:
        for (int i = 0; i < size; i++) {
          moveRowLeft(i);
        }
        break;
      case GestureDirection.swipeRight:
        for (int i = 0; i < size; i++) {
          moveRowRight(i);
        }
        break;
      case GestureDirection.swipeUp:
        for (int i = 0; i < size; i++) {
          moveColumnUp(i);
        }
        break;
      case GestureDirection.swipeDown:
        for (int i = 0; i < size; i++) {
          moveColumnDown(i);
        }
        break;
    }
  }

  bool checkWin() {
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (grid[i][j] == 2048) {
          return true;
        }
      }
    }
    return false;
  }

  bool checkGameOver() {
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (grid[i][j] == 0) {
          return false;
        }
      }
    }

    for (int i = 0; i < size - 1; i++) {
      for (int j = 0; j < size - 1; j++) {
        if (forEachCellToCheckCombinationPossible(i, j)) {
          return false;
        }
      }
    }

    return true;
  }

  bool forEachCellToCheckCombinationPossible(int row, int col) {
    for (int i = 0; i < size; i++) {
      for (int i = row; i < size; i++) {
        if (grid[row][col] != 0 &&
            areNeighborsVertically(row, col, i, col) &&
            haveSameValues(row, col, i, col)) {
          return true;
        }
      }
      for (int i = col; i < size; i++) {
        if (grid[row][col] != 0 &&
            areNeighborsHorizontally(row, col, row, i) &&
            haveSameValues(row, col, row, i)) {
          return true;
        }
      }
    }

    return false;
  }

  void updateIsGameWon() {
    if (checkWin()) {
      isGameWon = 0;
      print('Game won! Score: $score');
    } else if (checkGameOver()) {
      isGameWon = 1;
      print('Game over! Score: $score');
    }
  }

  bool allCellsAreFilled() {
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (grid[i][j] == 0) {
          return false;
        }
      }
    }
    return true;
  }

  void forEachCellToCheck(int row, int col, GestureDirection swipeType) {
    AxisDirection direction = getDirection(swipeType);
    switch (direction) {
      case AxisDirection.upDown:
        for (int i = row; i < size; i++) {
          if (grid[row][col] != 0 &&
              (areNeighborsVertically(row, col, i, col) ||
                  areSeparatedByEmptyCellsVertically(row, col, i, col)) &&
              haveSameValues(row, col, i, col)) {
            int sum = handleSum(row, col, i, col);
            grid[row][col] = 0;
            grid[i][col] = sum;
            increaseScore(sum);
          }
        }
        break;
      case AxisDirection.sideToSide:
        for (int i = col; i < size; i++) {
          if (grid[row][col] != 0 &&
              (areNeighborsHorizontally(row, col, row, i) ||
                  areSeparatedByEmptyCellsHorizontally(row, col, row, i)) &&
              haveSameValues(row, col, row, i)) {
            int sum = handleSum(row, col, row, i);
            grid[row][col] = 0;
            grid[row][i] = sum;
            increaseScore(sum);
          }
        }
        break;
    }
  }

  void play(GestureDirection swipe) {
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (grid[i][j] != 0) {
          forEachCellToCheck(i, j, swipe);
        }
      }
    }
    moveGrid(swipe);
    updateIsGameWon();
    if (isGridMoved) {
      generateRandomlyNewCell();
    }
    isGridMoved = false;
  }

  //
  // DRAFT TESTS IN THIS FILE: without any widget
  //

  // SwipeType chooseRandomlySwipeType() {
  //   int value = Random().nextInt(5);
  //   switch (value) {
  //     case 1:
  //       return SwipeType.left;
  //     case 2:
  //       return SwipeType.right;
  //     case 3:
  //       return SwipeType.up;
  //     case 4:
  //       return SwipeType.down;
  //   }

  //   return SwipeType.left;
  // }

  // void playGameSimulationForTestWithoutWidget(SwipeType swipeType) {
  //   // initGridState();
  //   print("init grid");
  //   print(grid);
  //   int nbTimesToPlay = 5;
  //   while (nbTimesToPlay > 0) {
  //     SwipeType swipe = chooseRandomlySwipeType();
  //     print('swipe: $swipe'); // choose random swipe
  //     for (int i = 0; i < size; i++) {
  //       for (int j = 0; j < size; j++) {
  //         if (grid[i][j] != 0) {
  //           forEachCellToCheck(i, j, swipe);
  //         }
  //       }
  //     }
  //     // if (gameBlocked()) {
  //     //   print('Game over! Score: $score');
  //     //   break;
  //     // }

  //     print(grid);

  //     nbTimesToPlay--;
  //   }
  // }
}

void main() {
  // GameModel grid = GameModel(size: 4);
  // grid.playGameSimulationForTestWithoutWidget(SwipeType.up);
  // grid.initGrid();
  // grid.initGridState();
  // print(grid.grid);
  // grid.moveGrid(SwipeType.up);
  // print(grid.grid);
  // grid.moveGrid(SwipeType.down);
  // print(grid.grid);
  // grid.moveGrid(SwipeType.left);
  // print(grid.grid);
  // grid.moveGrid(SwipeType.right);
  // print(grid.grid);
  // grid.generateRandomlyNewCell();
  // print(grid.grid);
}