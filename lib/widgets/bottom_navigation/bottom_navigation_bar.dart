import 'package:bottom_navigation_bar/widgets/bottom_navigation/navigation_paint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'bottom_navigation_action.dart';

class _NavigationScope extends InheritedWidget {
  _NavigationScope({
    Key? key,
    required this.state,
    required Widget child,
  }) : super(key: key, child: child);

  final _CustomBottomNavigationBarState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      (oldWidget is _NavigationScope) && state != oldWidget.state;
}

/// NavigationAction class
class NavigationAction {
  /// Navigation Action constructor.
  NavigationAction({
    required this.icon,
    this.label,
  });

  /// Navigation icon.
  final Icon icon;

  /// Navigation label.
  final String? label;
}

class CustomBottomNavigationBar extends StatefulWidget {
  /// Constructor [CustomBottomNavigationBar]
  CustomBottomNavigationBar({
    Key? key,
    required this.onPressed,
    required this.actions,
    this.iconClickColor,
    this.iconUnclickColor,
    this.backgroundColor,
    this.initialIndex = 0,
    this.clickColor,
    this.labelColor,
  })  : assert(actions.length == 4 || actions.length == 5),
        super(key: key);

  /// Click icon
  final Function(int) onPressed;

  /// Color background.
  final Color? backgroundColor;

  /// Color click icon.
  final Color? iconClickColor;

  /// Color unclick icon.
  final Color? iconUnclickColor;

  /// Color click icon background color.
  final Color? clickColor;

  /// Color label click.
  final Color? labelColor;

  /// Navigation Action list.
  final List<NavigationAction> actions;

  /// Initial icon index.
  /// default [0]
  final int initialIndex;

  static _CustomBottomNavigationBarState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_NavigationScope>()!.state;

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _paintController;
  late AnimationController _actionController;
  late Animation<double>? _actionAnimaion;
  late Animation<double>? _paintAnimation;
  late int _currentIndex = widget.initialIndex;
  late int _oldIndex = widget.initialIndex;

  @override
  void initState() {
    super.initState();
    _paintController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _actionController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _actionAnimaion = Tween<double>(
      begin: -20.0,
      end: 0.0,
    ).animate(_actionController);
    _paintAnimation = Tween<double>(
      begin: widget.initialIndex.toDouble(),
      end: 0.0,
    ).animate(_paintController);
    _actionController.addListener(() {
      setState(() {});
    });
    _paintController.addListener(() {});
  }

  @override
  void dispose() {
    _actionController.dispose();
    _paintController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_oldIndex != _currentIndex) {
      _oldIndex = _currentIndex;
    }
  }

  int get iconCount => widget.actions.length;

  List<Icon> get icons => List.generate(
        iconCount,
        (index) => widget.actions[index].icon,
      );

  List<String> get labels => List.generate(
        (iconCount),
        (index) => widget.actions[index].label!,
      );

  List<Widget> get actions => List.generate(
        (iconCount),
        (index) {
          return CustomBottomNavigationAction(
            iconClickColor: widget.iconClickColor,
            iconUnclickColor: widget.iconUnclickColor,
            opacity: _currentIndex == index ? 0.0 : 1.0,
            color: widget.backgroundColor!,
            backgroundColor: widget.clickColor,
            icon: icons[index],
            label: labels[index],
            clickColor: widget.clickColor,
            labelColor: widget.labelColor,
            index: index,
            alignmentY:
                _currentIndex == index ? _actionAnimaion?.value ?? -20.0 : 0,
          );
        },
      );

  /// Listen [CustomBottomNavigationAction]
  void clickNavigation(int index) async {
    widget.onPressed(index);
    _actionAnimaion = _actionController.drive(
      Tween<double>(
        begin: 0.0,
        end: -20.0,
      ),
    );
    _paintAnimation = _paintController.drive(
      Tween<double>(
        begin: _currentIndex.toDouble(),
        end: index.toDouble(),
      ),
    );
    const spring = SpringDescription(
      mass: 20.0,
      stiffness: .5,
      damping: 1.0,
    );
    final simulation = SpringSimulation(
      spring,
      0,
      1,
      1.0,
    );

    final simulationPaint = SpringSimulation(
      spring,
      0,
      1,
      1.0,
    );
    _currentIndex = index;
    _paintController.animateWith(simulationPaint);
    _actionController.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _NavigationScope(
      state: this,
      child: Stack(
        children: [
          Container(
            height: 60.0,
            width: size.width,
            child: CustomPaint(
              painter: NavigationPaint(
                index: _currentIndex,
                offsetPage: _paintAnimation!.value,
                pageCount: iconCount,
                color: widget.backgroundColor,
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            child: Container(
              width: size.width,
              height: 60.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: actions,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
