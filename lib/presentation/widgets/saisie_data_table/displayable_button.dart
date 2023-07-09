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
                return isActive
                    ? Colors.green // The color when button is active.
                    : Colors.blue; // Use the component's default.
              },
            ),
          ),
          onPressed: () {
            onPressed();
            ref.watch(displayTypeProvider.notifier).state = text;
          },
          child: Text(text),
        ),
      ),
    );
  }
}
