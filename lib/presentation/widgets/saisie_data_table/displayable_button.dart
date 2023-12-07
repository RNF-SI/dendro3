import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class DisplayableButton extends ConsumerWidget {
  final String text;
  final Function onPressed;

  DisplayableButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isActive = ref.watch(displayTypeProvider) == text;

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return isActive ? Colors.green : Colors.blue;
              },
            ),
            // Reducing padding inside the button
            padding: MaterialStateProperty.all(EdgeInsets.all(4)),
          ),
          onPressed: () {
            onPressed();
            ref.watch(displayTypeProvider.notifier).state = text;
          },
          child: FittedBox(
            fit: BoxFit
                .scaleDown, // Scales down text size to fit within the button
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14, // You can adjust the font size
              ),
              maxLines: 1, // Ensures text is in a single line
              overflow:
                  TextOverflow.ellipsis, // Adds ellipsis for overflow text
            ),
          ),
        ),
      ),
    );
  }
}
