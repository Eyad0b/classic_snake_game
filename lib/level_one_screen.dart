import 'dart:async';
import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class Level1Screen extends StatefulWidget {
  Level1Screen(this.snakeColor, this.isInteractionSoundMuted, {Key? key})
      : super(key: key);
  Color snakeColor;
  bool isInteractionSoundMuted;

  @override
  State<Level1Screen> createState() => _Level1ScreenState();
}

class _Level1ScreenState extends State<Level1Screen> {
  List<int> snakePosition = [42, 62, 82, 102];
  late double squareSize;

  // int numberOfSquares = 760;
  static var randomNumber = Random();
  int food = randomNumber.nextInt(680);
  var speed = 150;
  bool playing = false;
  var direction = 'down';
  bool x1 = false;
  bool x2 = false;
  bool x3 = false;
  bool endGame = false;
  String changeDirectionAudio = 'whoosh-blow-flutter-shortwav-14678.mp3';
  String eatFoodAudio = 'food.mp3';

  int _duration = 1000;
  bool _isScaledUp = false;

  Timer? foodTimer;

  void startFoodTimer() {
    foodTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (!snakePosition.contains(food)) {
        generateNewFood();
        setState(() {});
      }
    });
  }

  void cancelFoodTimer() {
    foodTimer?.cancel();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() async {
  //     squareSize = await MediaQuery.of(context).size.width / 20;
  //     // Calculating the size of each square based on screen width
  //   });
  // }

  startGame() {
    setState(() {
      startFoodTimer();
      playing = true;
    });
    endGame = false;
    snakePosition = [42, 62, 82, 102];
    var duration = Duration(milliseconds: speed);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver() || endGame) {
        timer.cancel();
        showGameOverDialog('Game Over');
        playing = false;
        x1 = false;
        x2 = false;
        x3 = false;
      }
    });
  }

  gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          setState(() {
            playing = false;
          });
          return true;
        }
      }
    }
    return false;
  }

  showGameOverDialog(String dialogType) {
    showDialog(
      barrierColor: Colors.black12.withOpacity(.3),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            // color: Colors.black12.withOpacity(.1),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  dialogType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Schyler',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your score is ' + (snakePosition.length - 4).toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Schyler',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: () {
                        widget.isInteractionSoundMuted
                            ? null
                            : FlameAudio.play("jug-pop-2-186887.mp3");
                        startGame();
                        Navigator.of(context).pop(true);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.home, color: Colors.white),
                      onPressed: () {
                        widget.isInteractionSoundMuted
                            ? null
                            : FlameAudio.play("jug-pop-2-186887.mp3");
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  generateNewFood() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final elapsedSeconds =
          timer.tick / 10.0; // Calculate elapsed time in seconds

      if (elapsedSeconds <= 7) {
        _duration = 1000; // Slow animation for the first 7 seconds
      } else if (elapsedSeconds <= 12) {
        _duration = 500; // Faster animation from 7 to 12 seconds
      } else {
        _duration = 100; // Very fast animation for the last 3 seconds
      }

      if (timer.tick == 100) {
        // Adjust the tick value as needed for 10 seconds
        timer.cancel();
      }
      setState(() {});
    });

    setState(() {
      food = randomNumber.nextInt(700);
      cancelFoodTimer();
      startFoodTimer();
    });
  }

  updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          // playAudio(changeDirectionAudio);
          if (snakePosition.last > 740) {
            snakePosition.add(snakePosition.last + 20 - 760);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }
          break;
        case 'up':
          // playAudio(changeDirectionAudio);
          if (snakePosition.last < 20) {
            snakePosition.add(snakePosition.last - 20 + 760);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }
          break;
        case 'left':
          // playAudio(changeDirectionAudio);
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;
        case 'right':
          // playAudio(changeDirectionAudio);
          if ((snakePosition.last + 1) % 20 == 0) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;
        default:
      }
      if (snakePosition.last == food) {
        widget.isInteractionSoundMuted ? null : FlameAudio.play(eatFoodAudio);
        generateNewFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    squareSize = MediaQuery.of(context).size.width / 20;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    int numberOfSquares = (width ~/ squareSize) * (height ~/ squareSize);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onVerticalDragStart: (details) {
                    if (direction == 'left' || direction == 'right') {
                      widget.isInteractionSoundMuted
                          ? null
                          : FlameAudio.play(changeDirectionAudio);
                    }
                  },
                  onHorizontalDragStart: (details) {
                    if (direction == 'up' || direction == 'down') {
                      widget.isInteractionSoundMuted
                          ? null
                          : FlameAudio.play(changeDirectionAudio);
                    }
                  },
                  onVerticalDragUpdate: (details) {
                    if (direction != 'up' && details.delta.dy > 0) {
                      direction = 'down';
                    } else if (direction != 'down' && details.delta.dy < 0) {
                      direction = 'up';
                    }
                  },
                  onHorizontalDragUpdate: (details) {
                    if (direction != 'left' && details.delta.dx > 0) {
                      direction = 'right';
                    } else if (direction != 'right' && details.delta.dx < 0) {
                      direction = 'left';
                    }
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Opacity(
                          opacity: 0.5, // Set the opacity level (0.0 to 1.0)
                          child: Image.asset(
                            'assets/images/backgroundGreen.png',
                            fit: BoxFit.fitHeight,
                            height: height,
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: numberOfSquares,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: width ~/ squareSize,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (snakePosition.contains(index)) {
                            // Check if the index is the head of the snake
                            if (index == snakePosition.last) {
                              // Display the custom snake head image for the head segment
                              return Image.asset(
                                'assets/images/Untitled.png',
                                fit: BoxFit.fill,
                                // height: ,
                              );
                            } else {
                              // Display the body segments of the snake
                              return Center(
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: widget
                                          .snakeColor, // Customize body segment color
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                          if (index == food) {
                            return Center(
                              child: TweenAnimationBuilder(
                                duration: Duration(milliseconds: _duration),
                                tween: Tween<double>(
                                    begin: _isScaledUp ? 1.0 : 1.2,
                                    end: _isScaledUp ? 1.2 : 1.0),
                                curve: Curves.easeInOut,
                                builder: (context, scale, child) {
                                  return Transform.scale(
                                    scale: scale,
                                    child: child,
                                  );
                                },
                                onEnd: () {
                                  setState(() {
                                    _isScaledUp =
                                        !_isScaledUp; // Toggle between scaling up and down
                                  });
                                },
                                child: const Image(
                                  image: AssetImage(
                                      "assets/images/apple-3155.png"),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              padding: const EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: Colors.white.withOpacity(.03),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: width * .05,
            right: width * .05,
            child: SizedBox(
              height: 52,
              child: !playing
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: x1
                                ? const Color(0xFF3863AA)
                                : Colors.transparent,
                          ),
                          // margin: const EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {
                              widget.isInteractionSoundMuted
                                  ? null
                                  : FlameAudio.play("jug-pop-2-186887.mp3");
                              setState(() {
                                x1 = true;
                                x2 = false;
                                x3 = false;
                                speed = 150;
                              });
                            },
                            child: const Text(
                              'X1',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: x2
                                ? const Color(0xFF3863AA)
                                : Colors.transparent,
                          ),
                          child: TextButton(
                            onPressed: () {
                              widget.isInteractionSoundMuted
                                  ? null
                                  : FlameAudio.play("jug-pop-2-186887.mp3");
                              setState(() {
                                x2 = true;
                                x1 = false;
                                x3 = false;
                                speed = 100;
                              });
                            },
                            child: const Text(
                              'X2',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: x3
                                ? const Color(0xFF3863AA)
                                : Colors.transparent,
                          ),
                          child: TextButton(
                            onPressed: () {
                              widget.isInteractionSoundMuted
                                  ? null
                                  : FlameAudio.play("jug-pop-2-186887.mp3");
                              setState(() {
                                x3 = true;
                                x1 = false;
                                x2 = false;
                                speed = 50;
                              });
                            },
                            child: const Text(
                              'X3',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 1,
                          color: Colors.white70,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              widget.isInteractionSoundMuted
                                  ? null
                                  : FlameAudio.play("jug-pop-1-186886.mp3");
                              startGame();
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'Start',
                                  style: TextStyle(
                                    color: Colors.amber,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.amber,
                                ),
                              ],
                            ))
                      ],
                    )
                  : Container(
                      height: 50,
                      color: Colors.black.withOpacity(.2),
                      child: Center(
                        child: OutlinedButton(
                          onPressed: () {
                            widget.isInteractionSoundMuted
                                ? null
                                : FlameAudio.play("jug-pop-3-186888.mp3");
                            setState(() {
                              endGame = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'End the Game and show result',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              SizedBox(
                                width: width * .05,
                              ),
                              const Icon(
                                Icons.exit_to_app_rounded,
                                color: Colors.amber,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          // Add the score display in the top right corner
          Positioned(
            top: 20,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Score: ${(snakePosition.length - 4)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
