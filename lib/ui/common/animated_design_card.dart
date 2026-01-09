import 'dart:async';
import 'package:flutter/material.dart';
import 'package:before_after/before_after.dart';

class AnimatedDesignCard extends StatefulWidget {
  final String title;
  final String description;
  final String tag;
  final Color tagColor;
  final String beforeImagePath; // Dışarıdan gelen Before resmi
  final String afterImagePath; // Dışarıdan gelen After resmi
  final VoidCallback onTap;

  const AnimatedDesignCard({
    super.key,
    required this.title,
    required this.description,
    required this.tag,
    required this.tagColor,
    required this.beforeImagePath,
    required this.afterImagePath,
    required this.onTap,
  });

  @override
  State<AnimatedDesignCard> createState() => _AnimatedDesignCardState();
}

class _AnimatedDesignCardState extends State<AnimatedDesignCard> {
  double _value = 0.5;
  Timer? _timer;
  bool _increasing = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) return;
      setState(() {
        if (_increasing) {
          _value += 0.004;
          if (_value >= 0.8) _increasing = false;
        } else {
          _value -= 0.005;
          if (_value <= 0.2) _increasing = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: BeforeAfter(
                      trackColor: Colors.white,
                      trackWidth: 1.5,
                      thumbColor: Colors.red,
                      thumbHeight: 15,
                      value: _value,
                      before: Image.asset(
                        widget.beforeImagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      after: Image.asset(
                        widget.afterImagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4433),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            widget.tag == "Recommended"
                                ? Icons.auto_awesome
                                : Icons.whatshot,
                            color: Colors.white,
                            size: 12,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.tag,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
