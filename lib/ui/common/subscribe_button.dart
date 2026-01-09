import 'package:flutter/material.dart';
import 'package:roomy_ai/ui/common/colors.dart';

class SubscribeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubscribeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.attach_money_rounded,
        size: 15,
        color: Colors.white,
      ),
      label: const Text(
        "Subscribe",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: PaywallColors.secondary,
        elevation: 0,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 14, ),
      ),
    );
  }
  
}
