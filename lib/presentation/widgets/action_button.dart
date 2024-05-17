import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Reducing the overall size of the button and the icon
    return Container(
      width: 40, // Smaller size than the default FAB, adjust size as needed
      height: 40,
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: theme.colorScheme.secondary,
        elevation: 4.0,
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
          iconSize: 20, // Smaller icon size within the button
          color: theme.colorScheme.onSecondary,
          padding: EdgeInsets.zero, // Reduce or remove padding if necessary
          constraints: BoxConstraints(), // Remove minimum size constraints
        ),
      ),
    );
  }
}
