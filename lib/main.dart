import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              XylophoneKey(
                note: 'a',
                startColor: Color(0xFFFF3B30),
                endColor: Color(0xFFFB6B5C),
                displayText: 'C',
              ),
              XylophoneKey(
                note: 'b',
                startColor: Color(0xFFFF9500),
                endColor: Color(0xFFFFB74D),
                displayText: 'D',
              ),
              XylophoneKey(
                note: 'c',
                startColor: Color(0xFFFFCC00),
                endColor: Color(0xFFFFDE57),
                displayText: 'E',
              ),
              XylophoneKey(
                note: 'd',
                startColor: Color(0xFF4CD964),
                endColor: Color(0xFF7CE48C),
                displayText: 'F',
              ),
              XylophoneKey(
                note: 'e',
                startColor: Color(0xFF007AFF),
                endColor: Color(0xFF6EB8FF),
                displayText: 'G',
              ),
              XylophoneKey(
                note: 'f',
                startColor: Color(0xFF5856D6),
                endColor: Color(0xFF877DF0),
                displayText: 'A',
              ),
              XylophoneKey(
                note: 'g',
                startColor: Color(0xFFAF52DE),
                endColor: Color(0xFFD986F4),
                displayText: 'B',
              ),
              XylophoneKey(
                note: 'c2',
                startColor: Color(0xFFFF2D55),
                endColor: Color(0xFFFF6D8E),
                displayText: 'C2',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class XylophoneKey extends StatefulWidget {
  final String note;
  final Color startColor;
  final Color endColor;
  final String displayText;

  const XylophoneKey({
    super.key,
    required this.note,
    required this.startColor,
    required this.endColor,
    required this.displayText,
  });

  @override
  _XylophoneKeyState createState() => _XylophoneKeyState();
}

class _XylophoneKeyState extends State<XylophoneKey> {
  bool isPressed = false;

  // Function to play sound
  void playSound(String note) async {
    final player = AudioPlayer();
    await player
        .play(AssetSource('node $note.wav')); // Adjust for your file structure
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            isPressed = true;
          });
          playSound(widget.note);
        },
        onTapUp: (_) {
          setState(() {
            isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            isPressed = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                isPressed
                    ? widget.startColor.withOpacity(0.8)
                    : widget.startColor,
                isPressed ? widget.endColor.withOpacity(0.8) : widget.endColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isPressed ? 0.1 : 0.2),
                blurRadius: isPressed ? 4 : 8,
                offset: isPressed ? Offset(1, 2) : Offset(2, 4),
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Center(
            child: Text(
              widget.displayText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
