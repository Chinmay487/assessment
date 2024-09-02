import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../utils/common_style.dart';

class RiveDemoScreen extends StatefulWidget {
  const RiveDemoScreen({super.key});

  @override
  State<RiveDemoScreen> createState() => _RiveDemoScreenState();
}

class _RiveDemoScreenState extends State<RiveDemoScreen> {
  Artboard? _riveArtboard;
  SMINumber? _levelInput;

  int currentLevel = 0;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    final file = await RiveFile.asset('assets/rive_assets/skills.riv');
    final artboard = file.mainArtboard.instance();
    var controller =
        StateMachineController.fromArtboard(artboard, 'Designer\'s Test');
    if (controller != null) {
      artboard.addController(controller);
      _levelInput = controller.getNumberInput('Level');
    }
    setState(() => _riveArtboard = artboard);
  }

  void updateCurrentLevel({required int newLevel}) {
    // Updating state machine here
    currentLevel = newLevel;
    _levelInput?.value = newLevel.toDouble();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rive Animation Demo"),
      ),
      body: SafeArea(
        child: Center(
          child: _riveArtboard == null
              ? Container()
              : Stack(
                  children: [
                    Rive(
                      artboard: _riveArtboard!,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Text(
                        "Level $currentLevel",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => updateCurrentLevel(newLevel: 0),
              child: const Text(
                "1",
                style: buttonTextStyle,
              ),
            ),
            ElevatedButton(
              onPressed: () => updateCurrentLevel(newLevel: 1),
              child: const Text(
                "2",
                style: buttonTextStyle,
              ),
            ),
            ElevatedButton(
              onPressed: () => updateCurrentLevel(newLevel: 2),
              child: const Text(
                "3",
                style: buttonTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
