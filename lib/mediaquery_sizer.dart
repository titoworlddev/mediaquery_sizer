import 'package:flutter/widgets.dart';

/// The different sizes of screen to be able to manage your design according to the size of screen
enum ScreenSize { mobile, tablet, desktop }

/// Provides information about the screen that can be used to your liking
/// An instance can be created via a builder in [MaterialApp] so you can
/// use it globally and have the screen information wherever you want.
class Sizer {
  /// It tells you the exact value of the [height] of the screen
  static double h(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// It tells you the exact value of the [width] of the screen
  static double w(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// It tells you the exact value of the [devicePixelratio] of the screen
  static double devicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// It tells you the exact value of the [aspectRatio] of the screen
  static double aspectRatio(BuildContext context) {
    return MediaQuery.of(context).size.aspectRatio;
  }

  /// Tells you the current orientation of the device
  static Orientation orientation(BuildContext context) {
    return (h(context) > w(context))
        ? Orientation.portrait
        : Orientation.landscape;
  }

  /// It tells you if the orientation of the screen is in portrait mode so
  /// you don't have to put the condition `(orientation(context) == Orientation.portrait) ? true : false`
  static bool isPortrait(BuildContext context) {
    return (orientation(context) == Orientation.portrait) ? true : false;
  }

  /// It tells you if the orientation of the screen is in portrait mode so
  /// you don't have to put the condition `(orientation(context) == Orientation.landscape) ? true : false`
  static bool isLandscape(BuildContext context) {
    return (orientation(context) == Orientation.landscape) ? true : false;
  }

  /// Returns the size of the screen according to the type of device, as specified in [ScreenSize]
  static ScreenSize screenSize(BuildContext context) {
    if ((orientation(context) == Orientation.portrait && w(context) > 1200) ||
        (orientation(context) == Orientation.landscape && h(context) > 1200)) {
      return ScreenSize.desktop;
    } else if ((orientation(context) == Orientation.portrait &&
            w(context) > 600) ||
        (orientation(context) == Orientation.landscape && h(context) > 600)) {
      return ScreenSize.tablet;
    } else {
      return ScreenSize.mobile;
    }
  }

  /// It tells you if the screen is mobile so you don't have to put the condition
  static bool isMobile(BuildContext context) {
    return (screenSize(context) == ScreenSize.mobile) ? true : false;
  }

  /// It tells you if the screen is tablet so you don't have to put the condition
  static bool isTablet(BuildContext context) {
    return (screenSize(context) == ScreenSize.tablet) ? true : false;
  }

  /// It tells you if the screen is desktop so you don't have to put the condition
  static bool isDesktop(BuildContext context) {
    return (screenSize(context) == ScreenSize.desktop) ? true : false;
  }
}

/// It helps to be able to use the sizes by means of screen percentages in an easy way
/// and using only the `MediaQuery` through the `BuildContext` but without having to create
/// an instance of `MediaQuery` or having to use it directly by writing it completely.
/// For example you can use `20.h(context)` and you are automatically pointing to `MediaQuery.of(context).size.height * 20`
extension SizerExt on num {
  /// Calculates the height depending on the device's screen size
  /// Eg: 20.h(context) -> will take 20% of the screen's height
  double h(BuildContext context) {
    return MediaQuery.of(context).size.height * (this / 100);
  }

  /// Calculates the width depending on the device's screen size
  /// Eg: 20.w(context) -> will take 20% of the screen's width
  double w(BuildContext context) {
    return MediaQuery.of(context).size.width * (this / 100);
  }

  /// Calculates the height depending on the parent's height,
  /// Eg: 20.parentH -> will take 20% of the parent's height.
  /// You must use a LayoutBuilder to get the constraints of the parent
  /// and use the his height.
  double parentH(BoxConstraints constraints) {
    return constraints.maxHeight * (this / 100);
  }

  /// Calculates the height depending on the parent's width,
  /// Eg: 20.parentW(constraints) -> will take 20% of the parent's width.
  /// You must use a LayoutBuilder to get the constraints of the parent
  /// and use the his width.
  double parentW(BoxConstraints constraints) {
    return constraints.maxWidth * (this / 100);
  }

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  /// Eg: 12.sp(context) Makes the specified size look the same on all screen sizes.
  /// Which means it's going to look just as big in terms of design.
  /// If you want it to always be the same size in pixels just use 12 as it is done by default.
  double sp(BuildContext context) {
    double h = Sizer.h(context);
    double w = Sizer.w(context);
    double dPR = Sizer.devicePixelRatio(context);
    double aR = Sizer.aspectRatio(context);

    /* The formula adds all the values that refer to the size of the screen 
    so that the scalable pixel takes into account all the factors that affect 
    the size of the letter, since for example it is not the same as a screen 
    having 390x800, a pixel ratio of 2.75 and an aspect ratio of 0.45, 
    and then have another screen with 390x800, a pixel ratio of 2.5 
    and an aspect ratio of 0.55, since they are not going to look the same. 
    That is why we cannot take into account only the width. */
    return this * ((((h + w) + (dPR * aR)) / 3) / 4.07) / 100;
  }
}
