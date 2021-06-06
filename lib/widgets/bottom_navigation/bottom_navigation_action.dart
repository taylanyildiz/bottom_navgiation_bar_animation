
import 'package:bottom_navigation_bar/widgets/bottom_navigation/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationAction extends StatelessWidget {
  CustomBottomNavigationAction({
    Key? key,
    required this.icon,
    required this.label,
    required this.index,
    required this.opacity,
    required this.color,
    required this.iconClickColor,
    required this.iconUnclickColor,
    this.alignmentY,
    this.backgroundColor,
    this.clickColor,
    this.labelColor,
  }) : super(key: key);

  final Icon icon;

  final String label;

  final Color? backgroundColor;

  final Color? clickColor;

  final Color? iconClickColor;

  final Color? iconUnclickColor;

  final Color? labelColor;

  final int index;

  final double? alignmentY;

  final double? opacity;

  final Color color;

  void _clickNavigation(BuildContext context, int index) {
    final nav = CustomBottomNavigationBar.of(context)!;
    nav.clickNavigation(index);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, alignmentY!),
      child: GestureDetector(
        onTap: () => _clickNavigation(context, index),
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: opacity == 0 ? backgroundColor : color,
          ),
          child: Center(
            child: opacity != 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon.icon,
                        color: opacity == 0 ? iconClickColor : iconUnclickColor,
                      ),
                      Opacity(
                        opacity: opacity ?? 1.0,
                        child: Container(
                          width: 50.0,
                          child: Center(
                            child: Text(
                              label,
                              style: TextStyle(
                                color: labelColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      icon.icon,
                      color: iconClickColor,
                      size: 30.0,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
