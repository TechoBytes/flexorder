import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  String _deliveryMethod = 'delivery'; // 'delivery' or 'pickup'
  final _deliveryFee = 5.99;
  
  // Delivery address
  final _nameController = TextEditingController(text: 'John Doe');
  final _phoneController = TextEditingController(text: '+1 555-123-4567');
  final _addressController = TextEditingController(text: '123 Main St, Apt 4B');
  final _cityController = TextEditingController(text: 'New York');
  final _zipController = TextEditingController(text: '10001');
  
  // Pickup details
  String _selectedPickupSlot = 'Today, 2:00 PM - 4:00 PM';
  final List<String> _pickupSlots = [
    'Today, 2:00 PM - 4:00 PM',
    'Today, 4:00 PM - 6:00 PM',
    'Tomorrow, 10:00 AM - 12:00 PM',
    'Tomorrow, 2:00 PM - 4:00 PM',
  ];
  
  // Payment method
  String _paymentMethod = 'cash_on_delivery';

  // Order details (these would typically come from a cart provider)
  final double _subtotal = 59.95;
  double get _total => _subtotal + (_deliveryMethod == 'delivery' ? _deliveryFee : 0);

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _placeOrder() async {
    if (_formKey.currentState!.validate()) {
      // Show processing dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        // Close dialog and navigate to confirmation page
        Navigator.pop(context);
        context.go('/order-confirmation', extra: {'orderId': 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 6)}'});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery Method Section
                    const Text(
                      'Delivery Method',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Delivery Options
                    Container(
                      decoration: AppTheme.contentBoxDecoration,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: const Text(
                              'Wholesaler Delivery',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Estimated delivery time: 2-3 hrs • \$${_deliveryFee.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                            value: 'delivery',
                            groupValue: _deliveryMethod,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                _deliveryMethod = value!;
                              });
                            },
                          ),
                          const Divider(color: Colors.white24),
                          RadioListTile<String>(
                            title: const Text(
                              'Self-Pickup',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Pickup at warehouse anytime today',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                            value: 'pickup',
                            groupValue: _deliveryMethod,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                _deliveryMethod = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Delivery Address or Pickup Slot Section
                    if (_deliveryMethod == 'delivery') ...[
                      const Text(
                        'Delivery Address',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Container(
                        decoration: AppTheme.contentBoxDecoration,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Name
                            TextFormField(
                              controller: _nameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.white70,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            
                            // Phone
                            TextFormField(
                              controller: _phoneController,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.white70,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            
                            // Street Address
                            TextFormField(
                              controller: _addressController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Street Address',
                                labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                prefixIcon: const Icon(
                                  Icons.home,
                                  color: Colors.white70,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            
                            // City & ZIP Row
                            Row(
                              children: [
                                // City
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: _cityController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'City',
                                      labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your city';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                
                                // ZIP Code
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _zipController,
                                    style: const TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'ZIP',
                                      labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter ZIP';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      // Pickup Slot Selection
                      const Text(
                        'Select Pickup Slot',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Container(
                        decoration: AppTheme.contentBoxDecoration,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: _pickupSlots.map((slot) {
                            final isSelected = _selectedPickupSlot == slot;
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedPickupSlot = slot;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? AppTheme.accentColor.withOpacity(0.3) 
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected 
                                        ? AppTheme.accentColor 
                                        : Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: isSelected 
                                          ? Colors.white 
                                          : Colors.white.withOpacity(0.7),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      slot,
                                      style: TextStyle(
                                        color: isSelected 
                                            ? Colors.white 
                                            : Colors.white.withOpacity(0.7),
                                        fontWeight: isSelected 
                                            ? FontWeight.bold 
                                            : FontWeight.normal,
                                      ),
                                    ),
                                    const Spacer(),
                                    if (isSelected)
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    
                    // Payment Method Section
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Container(
                      decoration: AppTheme.contentBoxDecoration,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: const Text(
                              'Cash on Delivery',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Pay with cash when your order arrives',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                            value: 'cash_on_delivery',
                            groupValue: _paymentMethod,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value!;
                              });
                            },
                            secondary: const Icon(
                              Icons.money,
                              color: Colors.white70,
                            ),
                          ),
                          const Divider(color: Colors.white24),
                          RadioListTile<String>(
                            title: const Text(
                              'Credit/Debit Card',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Pay securely with your card',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                            value: 'card',
                            groupValue: _paymentMethod,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value!;
                              });
                            },
                            secondary: const Icon(
                              Icons.credit_card,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Order Summary Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Summary',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Subtotal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        '\$${_subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Delivery Fee
                  if (_deliveryMethod == 'delivery') ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Fee',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          '\$${_deliveryFee.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                  
                  const Divider(color: Colors.white24),
                  
                  // Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '\$${_total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Place Order Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _placeOrder,
                      style: AppTheme.secondaryButtonStyle,
                      child: const Text(
                        'PLACE ORDER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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