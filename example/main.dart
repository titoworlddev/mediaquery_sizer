import 'package:flutter/material.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediaQuery Sizer Demo',

      // LayoutBuilder is optional, it is only needed in the Material app
      // if you want to use the context [Sizer.context] globally
      // but it must go in the home otherwise the context is not valids
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontWeight: FontWeight.bold,
      // You can use scalable pixels so that the font size looks the same on all screens.
      // Which means it's going to look just as big in terms of design.
      // If you want it to always be the same size in pixels just use 12 as it is done by default.
      fontSize: 20.sp(context),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('MediaQuery Sizer Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // You can receive the size through the static methods of the [Sizer] class
            Text('Screen Height:   ${Sizer.h(context)}', style: style),
            Text('Screen Width:   ${Sizer.w(context)}', style: style),
            Text(
                'Screen Device Pixel Ratio:  ${Sizer.devicePixelRatio(context)}',
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
            // Here you have 3 containers where you can see the size
            // of the child widget depending on the size of the parent widget
            ParentContainerWidget(width: 90.w(context)),
            ParentContainerWidget(width: 80.w(context)),
            ParentContainerWidget(width: 70.w(context)),
          ],
        ),
      ),
    );
  }
}

class ParentContainerWidget extends StatelessWidget {
  final double width;

  const ParentContainerWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 5.h(context),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.centerRight,
            width: double.maxFinite,
            color: Colors.yellow,
            child: Text('Parent: ${width.toStringAsFixed(2)} px'),
          ),
          LayoutBuilder(builder: (ctx, cons) {
            return Container(
              alignment: Alignment.centerLeft,
              // Here the width of the widget is specified with respect to the
              // total width of its parent widget thanks to the values received
              // by the constraints
              width: 40.parentW(cons),
              color: Colors.green,
              child: Text(
                  'Child: ${40.parentW(cons).toStringAsFixed(2)} px = 40%'),
            );
          }),
        ],
      ),
    );
  }
}
