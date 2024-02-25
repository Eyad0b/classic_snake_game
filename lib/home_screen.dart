import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'level_one_screen.dart';

class MainMenuScreen extends StatefulWidget {
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool isSoundSettingsVisible = false;
  bool isGameModesVisible = false;
  bool isBackgroundSoundMuted = false;
  bool isInteractionSoundMuted = false;
  Color selectedColor = Colors.green; // Default snake color
  List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.amber,
    const Color(0xFFA33378),
    Colors.deepOrangeAccent,
  ]; // List of colors

  void updateColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    isBackgroundSoundMuted
        ? null
        : FlameAudio.bgm.play(
            "forest-with-small-river-birds-and-nature-field-recording-6735.mp3");
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            'Sankook',
            style: TextStyle(
              fontSize: 40,
              color: Color(0xFFA33378),
            ),
          ),
        ),
      ),
      body: Stack(
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      const Color(0xFFA33378).withOpacity(.4),
                    ),
                  ),
                  onPressed: () {
                    // _showGameModeSelectionDialog(context);
                    isInteractionSoundMuted ? null : FlameAudio.play("jug-pop-1-186886.mp3");
                    setState(() {
                      isGameModesVisible = !isGameModesVisible;
                      _showColorSelectionDialog(context);
                    });
                  },
                  child: const Text(
                    'Play',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                // if (isGameModesVisible)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       ElevatedButton(
                //         style: ButtonStyle(
                //           backgroundColor: MaterialStatePropertyAll(
                //             const Color(0xFFA33378).withOpacity(.2),
                //           ),
                //         ),
                //         onPressed: () {
                //           FlameAudio.play("jug-pop-2-186887.mp3");
                //           setState(() {
                //             _showColorSelectionDialog(context);
                //           });
                //         },
                //         child: const Text(
                //           'Classic 1',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 15,
                //             letterSpacing: 2,
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: width * .05,
                //       ),
                //       ElevatedButton(
                //         style: ButtonStyle(
                //           backgroundColor: MaterialStatePropertyAll(
                //             const Color(0xFFA33378).withOpacity(.2),
                //           ),
                //         ),
                //         onPressed: () {
                //           FlameAudio.play("jug-pop-2-186887.mp3");
                //           setState(() {
                //             _showColorSelectionDialog(context);
                //           });
                //         },
                //         child: const Text(
                //           'Classic 2',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 15,
                //             letterSpacing: 2,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      const Color(0xFFA33378).withOpacity(.4),
                    ),
                  ),
                  onPressed: () {
                    isInteractionSoundMuted ? null : FlameAudio.play("jug-pop-1-186886.mp3");
                    setState(() {
                      isSoundSettingsVisible = !isSoundSettingsVisible;
                    });
                  },
                  child: const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                if (isSoundSettingsVisible)
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * .15,
                      right: width * .15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              const Color(0xFFA33378).withOpacity(.2),
                            ),
                          ),
                          onPressed: () {
                            isInteractionSoundMuted ? null : FlameAudio.play("jug-pop-2-186887.mp3");
                            setState(() {
                              FlameAudio.bgm.stop();
                              isBackgroundSoundMuted = !isBackgroundSoundMuted;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Background Sound',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 2,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  isInteractionSoundMuted ? null : FlameAudio.play("jug-pop-2-186887.mp3");
                                  setState(() {
                                    FlameAudio.bgm.stop();
                                    isBackgroundSoundMuted =
                                        !isBackgroundSoundMuted;
                                  });
                                },
                                icon: Icon(
                                  isBackgroundSoundMuted
                                      ? Icons.music_off_rounded
                                      : Icons.music_note_rounded,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * .005,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              const Color(0xFFA33378).withOpacity(.2),
                            ),
                          ),
                          onPressed: () {
                            isInteractionSoundMuted ? null : FlameAudio.play("jug-pop-2-186887.mp3");
                            setState(() {
                              FlameAudio.bgm.stop();
                              isInteractionSoundMuted =
                                  !isInteractionSoundMuted;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Interaction Sound',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 2,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  isInteractionSoundMuted ? null : FlameAudio.play("jug-pop-2-186887.mp3");
                                  setState(() {
                                    FlameAudio.bgm.stop();
                                    isInteractionSoundMuted =
                                        !isInteractionSoundMuted;
                                  });
                                },
                                icon: Icon(
                                  isInteractionSoundMuted
                                      ? Icons.volume_off_rounded
                                      : Icons.volume_up_rounded,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      const Color(0xFFA33378).withOpacity(.4),
                    ),
                  ),
                  onPressed: () {
                    isInteractionSoundMuted ? null : FlameAudio.play("jug-pop-3-186888.mp3");
                    _showExitConfirmationDialog(context);
                  },
                  child: const Text(
                    'Exit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFA33378).withOpacity(.6),
          title: const Text(
            'Exit Game',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          content: const Text(
            'Are you sure you want to exit the game?',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                isInteractionSoundMuted ? null : FlameAudio.play("jug-pop-2-186887.mp3");
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                isInteractionSoundMuted ? null : FlameAudio.play("jug-pop-2-186887.mp3");
                Navigator.of(context).pop();
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                // Add code here to exit the game
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // void _showGameModeSelectionDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.transparent,
  //         title: const Text(
  //           'Select Game Mode',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 25,
  //             fontWeight: FontWeight.bold,
  //             fontFamily: 'Schyler',
  //           ),
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ElevatedButton(
  //               style: ButtonStyle(
  //                 backgroundColor:
  //                     MaterialStatePropertyAll(Colors.pink.withOpacity(.3)),
  //               ),
  //               onPressed: () {
  //                 _showColorSelectionDialog(context);
  //                 // Add logic for Classic V1 game mode
  //               },
  //               child: const Text(
  //                 'Classic V1',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 20,
  //                   fontFamily: 'Schyler',
  //                 ),
  //               ),
  //             ),
  //             ElevatedButton(
  //               style: ButtonStyle(
  //                 backgroundColor:
  //                     MaterialStatePropertyAll(Colors.pink.withOpacity(.3)),
  //               ),
  //               onPressed: () {
  //                 _showColorSelectionDialog(context);
  //                 // Add logic for Classic V2 game mode
  //               },
  //               child: const Text(
  //                 'Classic V2',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 20,
  //                   fontFamily: 'Schyler',
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showColorSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(.3),
          title: const Text(
            'Select Snake Color',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: colors.map((color) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black.withOpacity(.5),
                  borderRadius: BorderRadius.circular(20)
                ),
                width: 100,
                height: 50,
                child: InkWell(
                  onTap: () {
                    isInteractionSoundMuted ? null : FlameAudio.play("jug-pop-2-186887.mp3");
                    updateColor(color);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Level1Screen(selectedColor,isInteractionSoundMuted),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        padding: const EdgeInsets.all(3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: color, // Customize body segment color
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        padding: const EdgeInsets.all(3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: color, // Customize body segment color
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        padding: const EdgeInsets.all(3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: color, // Customize body segment color
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        padding: const EdgeInsets.all(3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: color, // Customize body segment color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
