import 'dart:math' as math;

import 'package:neumorphic_ui/neumorphic_ui.dart';

class ImageSizeAnimation extends StatefulWidget {
  const ImageSizeAnimation({super.key});

  @override
  _ImageSizeAnimationState createState() => _ImageSizeAnimationState();
}

class _ImageSizeAnimationState extends State<ImageSizeAnimation>
    with SingleTickerProviderStateMixin {
  double imageSize = 100.0;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void animateToSize(double size) {
    _controller!.reset();
    _controller!.forward();
    setState(() {
      imageSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Size Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Bacon Burger"),
            const Text(
                "A Signature flame-grill beaf patty\ntopped with smoked bacon."),
            const SizedBox(
              height: 20,
            ),
            // CustomPaint(
            //   painter: HalfCirclePainter(),
            //   child: const SizedBox(
            //     height: 150,
            //     width: 100,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150,
                child: CustomPaint(
                  painter: HalfCirclePainter(),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.blueGrey.withOpacity(0.1), // darker color
                        ),
                        const BoxShadow(
                          color: Colors.white, // background color
                          spreadRadius: -7.0,
                          blurRadius: 7.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.1), // darker color
                      ),
                      const BoxShadow(
                        color: Colors.white, // background color
                        spreadRadius: -7.0,
                        blurRadius: 7.0,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/burger.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    duration: const Duration(milliseconds: 500),
                    width: imageSize,
                    height: imageSize,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            RoundedSquareButton(
              text: "S",
              onPressed: () => animateToSize(100.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => animateToSize(100.0), // Small size
                  child: const Text('S'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () => animateToSize(150.0), // Medium size
                  child: const Text('M'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () => animateToSize(200.0), // Large size
                  child: const Text('L'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 0.5;

    // final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // const startAngle = -math.pi / 2; // Start angle at 12 o'clock position
    // const sweepAngle = math.pi; // Sweep half of a circle

    canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width / 2, size.height / 2),
        math.pi, 3.14, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyShapePathProvider extends NeumorphicPathProvider {
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    return Path()
      ..moveTo(radius, 0)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        math.pi,
        -math.pi,
        true,
      );
  }

  @override
  bool get oneGradientPerPath => false;
}

class RoundedSquareButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RoundedSquareButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.yellow,
          boxShadow: const [
            BoxShadow(
              color: Colors.yellow,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({super.key, this.diameter = 200});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    Path path = Path();
    path.addArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      math.pi,
      math.pi,
    );
    

    Paint fillPaint = Paint()..color = Colors.transparent;
    canvas.drawPath(path, fillPaint);

    Paint borderPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, borderPaint);

    Path shadowPath = Path();
    shadowPath.addArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      math.pi,
      math.pi,
    );

    canvas.clipPath(path);

    // Paint shadowPaint = Paint()
    //   ..color = Colors.green.withOpacity(0.3)
    //   ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    // canvas.drawPath(shadowPath, shadowPaint);

    Paint innerShadowPaint = Paint()
      ..blendMode = BlendMode.srcATop
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 5)
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.yellow.withOpacity(0.3),
          Colors.white.withOpacity(0.0),
        ],
        stops: const [0.0, 1.0],
      ).createShader(
          Rect.fromCircle(center: Offset(centerY, centerX), radius: radius));

    canvas.drawPath(shadowPath, innerShadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
