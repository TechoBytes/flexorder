import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_background.dart';

class OrderTrackingPage extends StatefulWidget {
  final String orderId;

  const OrderTrackingPage({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final List<DeliveryStatusUpdate> _statusUpdates = [
    DeliveryStatusUpdate(
      status: 'Order Placed',
      description: 'Your order has been confirmed',
      time: '11:30 AM',
      isCompleted: true,
    ),
    DeliveryStatusUpdate(
      status: 'Order Packed',
      description: 'Your order has been packed and is ready for delivery',
      time: '12:05 PM',
      isCompleted: true,
    ),
    DeliveryStatusUpdate(
      status: 'Out for Delivery',
      description: 'Driver is on the way to your location',
      time: '12:15 PM',
      isCompleted: true,
    ),
    DeliveryStatusUpdate(
      status: 'Arriving Soon',
      description: 'Driver is approaching your location',
      time: 'Estimated in 10 minutes',
      isCompleted: false,
      isActive: true,
    ),
    DeliveryStatusUpdate(
      status: 'Delivered',
      description: 'Package has been delivered',
      time: 'Pending',
      isCompleted: false,
    ),
  ];

  // This would come from an API in a real application
  final Map<String, dynamic> _driverInfo = {
    'name': 'Michael Johnson',
    'phone': '+1 555-987-6543',
    'vehicle': 'White Toyota Van',
    'licensePlate': 'ABC 123',
    'photo': 'https://randomuser.me/api/portraits/men/32.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Track Order'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Map View (this would use GoogleMaps or similar in a real app)
              Container(
                height: 200,
                width: double.infinity,
                color: AppTheme.secondaryColor,
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.map,
                        size: 100,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    
                    // Delivery Route Simulation
                    CustomPaint(
                      size: const Size(double.infinity, 200),
                      painter: _DeliveryRoutePainter(),
                    ),
                    
                    // Map Controls
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Column(
                        children: [
                          _MapControlButton(
                            icon: Icons.my_location,
                            onPressed: () {
                              // Center on user location
                            },
                          ),
                          const SizedBox(height: 8),
                          _MapControlButton(
                            icon: Icons.zoom_in,
                            onPressed: () {
                              // Zoom in
                            },
                          ),
                          const SizedBox(height: 8),
                          _MapControlButton(
                            icon: Icons.zoom_out,
                            onPressed: () {
                              // Zoom out
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    // Mock Locations on Map
                    // Warehouse location
                    const Positioned(
                      top: 60,
                      left: 80,
                      child: _LocationMarker(
                        icon: Icons.store,
                        color: Colors.blue,
                        label: 'Warehouse',
                      ),
                    ),
                    
                    // Delivery location
                    const Positioned(
                      bottom: 50,
                      right: 80,
                      child: _LocationMarker(
                        icon: Icons.home,
                        color: Colors.green,
                        label: 'Delivery',
                      ),
                    ),
                    
                    // Driver location
                    const Positioned(
                      top: 100,
                      left: 150,
                      child: _LocationMarker(
                        icon: Icons.local_shipping,
                        color: Colors.orange,
                        label: 'Driver',
                        isMoving: true,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Delivery Status
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ETA Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Estimated Time of Arrival',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '12:45 PM (10 minutes)',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Driver Information
                      const Text(
                        'Driver Information',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: AppTheme.contentBoxDecoration,
                        child: Row(
                          children: [
                            // Driver Photo
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(_driverInfo['photo']),
                                  fit: BoxFit.cover,
                                  onError: (exception, stackTrace) {
                                    // Handle error loading image
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            
                            // Driver Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _driverInfo['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Vehicle: ${_driverInfo['vehicle']} (${_driverInfo['licensePlate']})',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Contact Actions
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.phone, color: Colors.green),
                                  onPressed: () {
                                    // Make phone call to driver
                                  },
                                ),
                                const Text(
                                  'Call',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Delivery Status Timeline
                      const Text(
                        'Delivery Status',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      ..._statusUpdates.asMap().entries.map((entry) {
                        final index = entry.key;
                        final status = entry.value;
                        final isLast = index == _statusUpdates.length - 1;
                        
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Status Icon and Line
                            Column(
                              children: [
                                // Status Icon
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: status.isCompleted
                                        ? Colors.green
                                        : (status.isActive
                                            ? Colors.orange
                                            : Colors.grey),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      status.isCompleted
                                          ? Icons.check
                                          : (status.isActive
                                              ? Icons.access_time
                                              : Icons.circle),
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                
                                // Connecting Line
                                if (!isLast)
                                  Container(
                                    width: 2,
                                    height: 40,
                                    color: status.isCompleted
                                        ? Colors.green
                                        : Colors.grey.withOpacity(0.3),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            
                            // Status Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    status.status,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: status.isActive
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    status.description,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    status.time,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: isLast ? 0 : 16),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
              
              // Action Buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    // Chat with Driver Button
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Open chat with driver
                        },
                        icon: const Icon(Icons.chat),
                        label: const Text('CHAT'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Share Location Button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Share location with driver
                        },
                        icon: const Icon(Icons.share_location),
                        label: const Text('SHARE LOCATION'),
                        style: AppTheme.primaryButtonStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Data Model
class DeliveryStatusUpdate {
  final String status;
  final String description;
  final String time;
  final bool isCompleted;
  final bool isActive;

  DeliveryStatusUpdate({
    required this.status,
    required this.description,
    required this.time,
    required this.isCompleted,
    this.isActive = false,
  });
}

// Location Marker Widget
class _LocationMarker extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final bool isMoving;

  const _LocationMarker({
    required this.icon,
    required this.color,
    required this.label,
    this.isMoving = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: isMoving ? 12 : 4,
                spreadRadius: isMoving ? 4 : 1,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// Map Control Button
class _MapControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _MapControlButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 18),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
      ),
    );
  }
}

// Custom Painter for Delivery Route
class _DeliveryRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    final dashPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    // Draw route path
    final path = Path();
    path.moveTo(80, 60); // Warehouse
    path.quadraticBezierTo(
      150, 30, // Control point
      150, 100, // Driver current position
    );
    
    // Draw completed route
    canvas.drawPath(path, paint);
    
    // Draw future route (dashed)
    final dashPath = Path();
    dashPath.moveTo(150, 100); // Driver current position
    dashPath.quadraticBezierTo(
      150, 170, // Control point
      size.width - 80, size.height - 50, // Delivery location
    );
    
    // Draw dashed line
    final dashWidth = 5.0;
    final dashSpace = 5.0;
    final dashCount = (dashPath.computeMetrics().single.length / (dashWidth + dashSpace)).floor();
    
    final metric = dashPath.computeMetrics().single;
    var distance = 0.0;
    
    for (var i = 0; i < dashCount; i++) {
      final extractPath = metric.extractPath(
        distance,
        distance + dashWidth,
      );
      canvas.drawPath(extractPath, dashPaint);
      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DeliveryRoutePainter oldDelegate) => false;
} 