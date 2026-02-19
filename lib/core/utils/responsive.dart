import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 767;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1024 &&
      MediaQuery.of(context).size.width >= 768;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static T of<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (Responsive.isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (Responsive.isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  static double dialogWidth(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Responsive.of<double>(
      context: context,
      mobile: size.width - 32, // почти во всю ширину, с отступами
      tablet: size.width / 3,
      desktop: size.width / 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 1025) {
      return desktop;
    } else if (size.width >= 768) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
