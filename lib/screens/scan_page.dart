import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ProductInfoPage.dart'; // Make sure this displays the parsed result

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with TickerProviderStateMixin {
  String? barcodeText;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late MobileScannerController _scannerController;
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();

    // Initialize scanner controller
    _scannerController = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
    );

    // Initialize animation
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
    );
    _animationController.repeat(reverse: true);
  }

  void handleBarcodeDetection(String barcode) async {
    if (!_isScanning) return; // Prevent multiple scans

    setState(() {
      barcodeText = barcode;
      _isScanning = false;
    });

    // Stop scanning
    await _scannerController.stop();

    // Navigate to ProductInfoPage
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductInfoPage(
            barcode: barcode,
          ),
        ),
      ).then((_) {
        // Reset scanning state when returning from ProductInfoPage
        if (mounted) {
          setState(() {
            _isScanning = true;
          });
          _scannerController.start();
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scannerController.dispose(); // Properly dispose scanner controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Scan Barcode"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Camera view
          MobileScanner(
            controller: _scannerController,
            onDetect: (capture) {
              if (!_isScanning) return;

              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null &&
                    barcode.rawValue!.isNotEmpty &&
                    barcodeText != barcode.rawValue) {
                  handleBarcodeDetection(barcode.rawValue!);
                  break;
                }
              }
            },
          ),

          // Dark overlay with transparent scanning area
          CustomPaint(
            painter: ScannerOverlayPainter(),
            child: Container(),
          ),

          // Scanning frame with corners and animated line
          Center(
            child: Container(
              width: 250,
              height: 250,
              child: Stack(
                children: [
                  // Corner borders
                  ..._buildScannerCorners(),

                  // Animated scanning line
                  if (_isScanning)
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Positioned(
                          top: _animation.value * 220,
                          left: 10,
                          right: 10,
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.green,
                                  Colors.green,
                                  Colors.transparent,
                                ],
                                stops: [0.0, 0.3, 0.7, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),

          // Instruction text
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  _isScanning
                      ? "Align barcode within the frame"
                      : "Processing...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Torch toggle button
          Positioned(
            bottom: 50,
            right: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.green,
              onPressed: () {
                _scannerController.toggleTorch();
              },
              child: Icon(
                Icons.flash_on,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildScannerCorners() {
    return [
      // Top-left corner
      Positioned(
        top: 0,
        left: 0,
        child: _cornerBorder(top: true, left: true),
      ),
      // Top-right corner
      Positioned(
        top: 0,
        right: 0,
        child: _cornerBorder(top: true, right: true),
      ),
      // Bottom-left corner
      Positioned(
        bottom: 0,
        left: 0,
        child: _cornerBorder(bottom: true, left: true),
      ),
      // Bottom-right corner
      Positioned(
        bottom: 0,
        right: 0,
        child: _cornerBorder(bottom: true, right: true),
      ),
    ];
  }

  Widget _cornerBorder({
    bool top = false,
    bool bottom = false,
    bool left = false,
    bool right = false
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          top: top ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
          bottom: bottom ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
          left: left ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
          right: right ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
        ),
      ),
    );
  }
}

// Custom painter for the scanner overlay
class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    // Calculate the scanning area
    const double scanAreaSize = 250;
    final double left = (size.width - scanAreaSize) / 2;
    final double top = (size.height - scanAreaSize) / 2;

    // Create the full screen path
    final fullScreenPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create the scanning area path (hole)
    final scanningAreaPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize),
        Radius.circular(12),
      ));

    // Subtract the scanning area from the full screen
    final overlayPath = Path.combine(
      PathOperation.difference,
      fullScreenPath,
      scanningAreaPath,
    );

    canvas.drawPath(overlayPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}