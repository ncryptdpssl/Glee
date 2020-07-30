import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glee/meditation/components/breathing_circle.dart';
import 'package:glee/meditation/state/settings.dart';
import 'package:glee/meditation/components/animated_widget_sequence.dart';
import 'package:glee/meditation//utilities/constants.dart';

enum CentralWidget {
  breathingCircle,
  breatheInText,
  holdTimer1,
  holdTimer2,
}

class BreatheScreen extends StatefulWidget {
  static const String id = 'BreatheScreen';

  @override
  _BreatheScreenState createState() => _BreatheScreenState();
}

class _BreatheScreenState extends State<BreatheScreen> with SingleTickerProviderStateMixin {
  int count = 0;
  int roundsElapsed = 0;

  CentralWidget centralWidget = CentralWidget.breathingCircle;
  DateTime startTime;

  BreathingCircleController breathingCircleController = BreathingCircleController();

  AnimatedSwitcherSequenceController animatedSwitcherSequenceController = AnimatedSwitcherSequenceController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.tealAccent,
        ),
        title: Text(
          'BREATHE',
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 25,
            letterSpacing: 3,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: AnimatedSwitcherSequence(
                  controller: animatedSwitcherSequenceController,
                  beforeLoop: () {
                    Settings settings = Provider.of<Settings>(context, listen: false);
                    count = 0;
                    roundsElapsed++;
                    if (roundsElapsed >= settings.numRounds) {
                      Navigator.pop(context);
                    }
                  },
                  builders: [
                    (next) {
                      next(delay: Duration(seconds: 4));
                      return Text(
                        'Get ready for round ${roundsElapsed + 1}',
                        style: kBreathingTextStyle,
                      );
                    },
                    (next) => _buildBreathingCircle(() {
                          Settings settings = Provider.of<Settings>(context, listen: false);
                          if (count + 1 == settings.breathsPerRound) {
                            breathingCircleController.stopAnimation();

                            setState(() {
                              count++;
                            });

                            next();
                          } else {
                            setState(() {
                              count++;
                            });
                          }
                        }),
                    (next) {
                      Settings settings = Provider.of<Settings>(context, listen: false);
                      return _buildTimerWidget(settings.holdTime, next);
                    },
                    (next) {
                      next(delay: Duration(seconds: 3));
                      return Text(
                        'Breathe In!',
                        style: kBreathingTextStyle,
                      );
                    },
                    (next) => _buildTimerWidget(10, next),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Center(
                child: RaisedButton(
                  color: Colors.tealAccent,
                  onPressed: () {
                    animatedSwitcherSequenceController.skipToNext();
                  },
                  child: Icon(
                    Icons.fast_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
                      child: Consumer<Settings>(
                        builder: (context, settings, child) => Slider(
                          value: settings.speed.toDouble(),
                          onChanged: (value) {
                            if (value.floor() != settings.speed) {
                              settings.speed = value.floor();
                            }
                          },
                          min: 1,
                          max: 9,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBreathingCircle(Function didCompleteCycle) {
    return BreathingCircle(
      controller: breathingCircleController,
      didCompleteCycle: didCompleteCycle,
      child: Text(
        count.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 60,
          fontWeight: FontWeight.w100,
        ),
      ),
    );
  }

  Widget _buildTimerWidget(int holdTime, Function onDone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('HOLD'),
      ],
    );
  }

  @override
  void dispose() {
    breathingCircleController.dispose();
    super.dispose();
  }
}
