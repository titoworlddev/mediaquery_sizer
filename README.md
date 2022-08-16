# Mediaquery Sizer

> It helps you to use the screen sizes through mediaquery, without having to make instances to shorten its size or use it completely.

- Manage sizes by screen percentages or even scalable pixels
  - Width Percentage
  - Height Percentage
  - Scalable Pixels
- Use sizes by percentage of the parent widget thanks to the LayoutBuilder
  - Parent Width
  - Parent Height
- Manage all the information on the screen easily
  - Width
  - Height
  - Device Pixel Ratio
  - Aspect Ratio
  - Orientation
  - Screen Size

<img src="https://raw.githubusercontent.com/titoworlddev/mediaquery_sizer/master/example_screenshot.png" width="200">

## Getting started

Copy the dependency into your pubspec.yaml

```
mediaquery_sizer: ^1.0.3
```

Import the package in your file to be able to use it

```dart
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
```

## Usage

In order to use percentages and scalable pixels simply use the extension

By default it should be like this

```dart
Size size = MediaQuery.of(context).size;
Container(
  // Long way
  width: MediaQuery.of(context).size * 0.1,
  // Short way
  height: size * 0.2,
  color: Colors.red,
  Text(
    'Hello world!',
    // Text size is the same regardless of screen size
    style: TextStyle(fontSize: 16),
  )
);
```

But now you can put it like this

```dart
Container(
  // It is the same as using the full MediaQuery but much faster and applicable to all your apps quickly and easily.
  width: 10.w(context),
  height: 20.h(context),
  color: Colors.red,
  Text(
    'Hello world!',
    // The font size will grow with the screen size so as not to break the design. Something like a vectorized image.
    style: TextStyle(fontSize: 16.sp(context))
  )
);
```

Use the screen information through the static methods of the [Sizer] class

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Screen Height:   ${Sizer.h(context)}', style: style),
    Text('Screen Width:   ${Sizer.w(context)}', style: style),
    // Eg: This is the same as using MediaQuery.of(context).devicePixelRatio
    Text(
        'Screen Device Pixel Ratio:  ${Sizer.devicePixelRatio(context)}',
    // Eg: This is the same as using MediaQuery.of(context).size.aspectRatio
        style: style),
    Text('Screen Aspect Ratio:   ${Sizer.aspectRatio(context)}',
        style: style),
    Text('Screen Orientation:  ${Sizer.orientation(context)}',
        style: style),
    Text('Screen Is Portrait:   ${Sizer.isPortrait(context)}',
        style: style),
    Text('Screen Is Landscape:  ${Sizer.isLandscape(context)}',
        style: style),
    Text('Screen Screen Size:  ${Sizer.screenSize(context)}',
        style: style),
    Text('Screen Is Mobile:   ${Sizer.isMobile(context)}',
        style: style),
    Text('Screen Is Tablet:   ${Sizer.isTablet(context)}',
        style: style),
    Text('Screen Is Desktop:  ${Sizer.isDesktop(context)}',
        style: style),
  ],
),
```

Use the size as a percentage of the size of the containing parent widget

```dart
Container(
  alignment: Alignment.centerLeft,
  width: 300,
  color: Colors.yellow,
  child: LayoutBuilder(builder: (ctx, cons) {
    return Container(
      alignment: Alignment.centerLeft,
      // Here the width of the widget is specified with respect to the
      // total width of its parent widget thanks to the values received
      // by the constraints
      width: 40.parentW(cons),
      color: Colors.green,
    );
  }),
)
```

## Additional information

As specified this package only makes use of the MediaQuery class.
An external package is not used, nor is any strange or special method done, it is something that anyone could do but in a shorter way to make things easier, since I have seen many packages that make use of special methods that in the end always give errors .
But this package only makes use of what Flutter and Dart already provide but in an abbreviated form.

Feel free to use it or tweak it, and if you don't want to mess with it you can make the request in the repository and I'll try to add the feature.
