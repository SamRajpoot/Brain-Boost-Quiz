import 'package:flutter/material.dart';

class QuizOptionTile extends StatelessWidget {
  const QuizOptionTile({
    required this.index,
    required this.text,
    required this.selectedIndex,
    required this.correctIndex,
    required this.locked,
    required this.onTap,
    super.key,
  });

  final int index;
  final String text;
  final int selectedIndex;
  final int correctIndex;
  final bool locked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;
    final bool isCorrect = index == correctIndex;
    final bool showCorrect = locked && isCorrect;
    final bool showWrong = locked && isSelected && !isCorrect;

    Color bgColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    Color borderColor = Colors.transparent;

    if (showCorrect) {
      bgColor = Colors.green.withOpacity(0.18);
      borderColor = Colors.green;
    } else if (showWrong) {
      bgColor = Colors.red.withOpacity(0.16);
      borderColor = Colors.red;
    } else if (isSelected) {
      bgColor = Theme.of(context).colorScheme.primary.withOpacity(0.18);
      borderColor = Theme.of(context).colorScheme.primary;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: locked ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.17),
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(text)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
