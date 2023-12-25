import 'package:flutter/material.dart';
import 'package:hangman/const.dart';
import 'package:hangman/figure.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var charactors = 'abcdefghijklmnopqrstuvwxyz'.toUpperCase();
  var words = 'saylani'.toUpperCase();
  List<String> selecChar = [];
  var tries = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff392988),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Hangman : The Game'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                        flex: 2,
                        child: Stack(
                          children: [
                            figure(one, tries == 0),
                            figure(two, tries == 1),
                            figure(three, tries == 2),
                            figure(four, tries == 3),
                            figure(five, tries == 4),
                            figure(six, tries == 5),
                          ],
                        )),
                    Expanded(
                        child: Container(
                      // color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: words.split("").map((e) {
                          return Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Visibility(
                                visible: selecChar.contains(e.toUpperCase()),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )),
                          );
                        }).toList(),
                      ),
                    ))
                  ],
                )),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  // color: Colors.yellow.shade200,
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 7,
                    children: charactors.split("").map((e) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow.shade800),
                          onPressed: selecChar.contains(e.toUpperCase())
                              ? null
                              : () {
                                  setState(() {
                                    selecChar.add(e.toUpperCase());
                                    if (!words
                                        .split('')
                                        .contains(e.toUpperCase())) {
                                      tries++;
                                    }
                                    if (tries == 6) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                              ),
                                              backgroundColor:
                                                  Color(0xff39298B),
                                              content: Container(
                                                height: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Your Guessed Wrong",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        GameScreen()));
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            20.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .amber.shade800,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Icon(
                                                          Icons.arrow_back,
                                                          color: Colors.black,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    }
                                  });
                                },
                          child: Text(
                            e,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ));
                    }).toList(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
