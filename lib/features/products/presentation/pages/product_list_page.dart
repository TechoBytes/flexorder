import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String category;
  final bool inStock;
  final double rating;
  final int reviewCount;
  final int stockQuantity;
  final DateTime addedDate;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.inStock,
    required this.rating,
    required this.reviewCount,
    required this.stockQuantity,
    required this.addedDate,
  });
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Sorting and filtering
  String _sortBy =
      'popularity'; // popularity, price_low_high, price_high_low, new_arrivals
  RangeValues _priceRange = const RangeValues(0, 1000);
  bool _inStockOnly = false;

  // Product list
  final List<Product> _allProducts = [
    Product(
      id: '1',
      name: 'Premium Dark Chocolate',
      price: 24.99,
      description:
          '70% Cacao premium dark chocolate bar. Rich and smooth flavor with hints of vanilla.',
      imageUrl:
          'https://images.unsplash.com/photo-1549007994-cb92caebd54b?q=80&w=800',
      category: 'Chocolates & Confectionery',
      inStock: true,
      rating: 4.8,
      reviewCount: 128,
      stockQuantity: 45,
      addedDate: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Product(
      id: '2',
      name: 'Organic Rice (10kg)',
      price: 42.50,
      description:
          'Organic basmati rice, sourced from premium farms. Perfect for restaurants and cafes.',
      imageUrl:
          'https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?q=80&w=800',
      category: 'Grains & Rice',
      inStock: true,
      rating: 4.5,
      reviewCount: 97,
      stockQuantity: 120,
      addedDate: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Product(
      id: '3',
      name: 'Arabica Coffee Beans',
      price: 35.99,
      description:
          'Premium Arabica coffee beans, medium roast. Aromatic with notes of caramel and nuts.',
      imageUrl:
          'https://images.unsplash.com/photo-1447933601403-0c6688de566e?q=80&w=800',
      category: 'Beverages',
      inStock: true,
      rating: 4.9,
      reviewCount: 215,
      stockQuantity: 78,
      addedDate: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Product(
      id: '4',
      name: 'Extra Virgin Olive Oil (5L)',
      price: 89.99,
      description:
          'Cold-pressed extra virgin olive oil from Mediterranean olives. Ideal for restaurants.',
      imageUrl:
          'https://images.unsplash.com/photo-1596360770107-8d263ccc6fcc?q=80&w=800',
      category: 'Oils & Condiments',
      inStock: true,
      rating: 4.7,
      reviewCount: 63,
      stockQuantity: 35,
      addedDate: DateTime.now().subtract(const Duration(days: 45)),
    ),
    Product(
      id: '5',
      name: 'Almond Flour (1kg)',
      price: 29.99,
      description:
          'Fine ground blanched almond flour, perfect for gluten-free baking and pastries.',
      imageUrl:
          'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?q=80&w=800',
      category: 'Baking Supplies',
      inStock: true,
      rating: 4.6,
      reviewCount: 48,
      stockQuantity: 60,
      addedDate: DateTime.now().subtract(const Duration(days: 12)),
    ),
    Product(
      id: '6',
      name: 'Assorted Spice Set',
      price: 54.99,
      description:
          'Professional grade spice collection with 15 essential spices for commercial kitchens.',
      imageUrl:
          'https://images.unsplash.com/photo-1600565193348-f74bd3c7ccdf?q=80&w=800',
      category: 'Spices & Seasonings',
      inStock: true,
      rating: 4.8,
      reviewCount: 72,
      stockQuantity: 40,
      addedDate: DateTime.now().subtract(const Duration(days: 60)),
    ),
    Product(
      id: '7',
      name: 'Organic Quinoa (5kg)',
      price: 78.50,
      description:
          'Organic white quinoa, high in protein and nutrients. Perfect for health-focused menus.',
      imageUrl:
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?q=80&w=800',
      category: 'Grains & Rice',
      inStock: true,
      rating: 4.7,
      reviewCount: 51,
      stockQuantity: 85,
      addedDate: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Product(
      id: '8',
      name: 'Honey (3kg Jar)',
      price: 65.00,
      description:
          'Pure raw honey sourced from wildflower fields. Unfiltered and unpasteurized.',
      imageUrl:
          'https://images.unsplash.com/photo-1555211652-5c6222f971fc?q=80&w=800',
      category: 'Sweeteners',
      inStock: true,
      rating: 4.9,
      reviewCount: 89,
      stockQuantity: 30,
      addedDate: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Product(
      id: '9',
      name: 'Dried Mushrooms Assortment',
      price: 46.99,
      description:
          'Premium selection of dried porcini, shiitake, and morel mushrooms for gourmet cooking.',
      imageUrl:
          'https://images.unsplash.com/photo-1504545102780-26774c1bb073?q=80&w=800',
      category: 'Dried Goods',
      inStock: false,
      rating: 4.8,
      reviewCount: 37,
      stockQuantity: 0,
      addedDate: DateTime.now().subtract(const Duration(days: 90)),
    ),
    Product(
      id: '10',
      name: 'Coconut Milk (Case of 12)',
      price: 42.00,
      description:
          'Premium organic coconut milk, perfect for curries, soups, and desserts.',
      imageUrl:
          'https://images.unsplash.com/photo-1562114808-b4b33cf60f4f?q=80&w=800',
      category: 'Canned Goods',
      inStock: true,
      rating: 4.6,
      reviewCount: 65,
      stockQuantity: 58,
      addedDate: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Product(
      id: '11',
      name: 'Premium Vanilla Beans',
      price: 89.99,
      description:
          'Grade A Madagascar bourbon vanilla beans. Aromatic and flavorful for pastries and desserts.',
      imageUrl:
          'https://images.unsplash.com/photo-1601055903647-ddf1ee9701b7?q=80&w=800',
      category: 'Baking Supplies',
      inStock: true,
      rating: 4.9,
      reviewCount: 42,
      stockQuantity: 25,
      addedDate: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Product(
      id: '12',
      name: 'Sea Salt Flakes (500g)',
      price: 28.50,
      description:
          'Premium Maldon sea salt flakes, perfect as a finishing salt for all types of dishes.',
      imageUrl:
          'https://images.unsplash.com/photo-1535208049305-fd3d20a7a668?q=80&w=800',
      category: 'Spices & Seasonings',
      inStock: true,
      rating: 4.7,
      reviewCount: 54,
      stockQuantity: 42,
      addedDate: DateTime.now().subtract(const Duration(days: 25)),
    ),
    Product(
      id: '13',
      name: 'Organic Maple Syrup (1L)',
      price: 38.99,
      description:
          'Pure Grade A maple syrup from sustainable farms. Rich flavor, perfect for pancakes and baking.',
      imageUrl:
          'https://images.unsplash.com/photo-1589496933738-f5e67ae9868a?q=80&w=800',
      category: 'Sweeteners',
      inStock: true,
      rating: 4.8,
      reviewCount: 67,
      stockQuantity: 38,
      addedDate: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Product(
      id: '14',
      name: 'Dried Apricots (2kg)',
      price: 32.50,
      description:
          'Sun-dried apricots with no added sugar or preservatives. Sweet, tangy flavor.',
      imageUrl:
          'https://images.unsplash.com/photo-1596591868231-05e908752cc8?q=80&w=800',
      category: 'Dried Goods',
      inStock: true,
      rating: 4.5,
      reviewCount: 41,
      stockQuantity: 53,
      addedDate: DateTime.now().subtract(const Duration(days: 18)),
    ),
    Product(
      id: '15',
      name: 'Premium Jasmine Rice (20kg)',
      price: 75.99,
      description:
          'Aromatic jasmine rice from Thailand. Long grain with a delicate floral aroma.',
      imageUrl:
          'https://images.unsplash.com/photo-1516824361285-b987224fbdb6?q=80&w=800',
      category: 'Grains & Rice',
      inStock: true,
      rating: 4.9,
      reviewCount: 112,
      stockQuantity: 65,
      addedDate: DateTime.now().subtract(const Duration(days: 8)),
    ),
    Product(
      id: '16',
      name: 'Green Tea (100 bags)',
      price: 29.99,
      description:
          'Premium Japanese green tea, rich in antioxidants. Delicate flavor and aroma.',
      imageUrl:
          'https://images.unsplash.com/photo-1564890369478-c89ca6d9cde9?q=80&w=800',
      category: 'Beverages',
      inStock: true,
      rating: 4.7,
      reviewCount: 83,
      stockQuantity: 92,
      addedDate: DateTime.now().subtract(const Duration(days: 22)),
    ),
    Product(
      id: '17',
      name: 'Artisanal Sourdough Bread',
      price: 8.99,
      description:
          'Freshly baked sourdough bread using traditional methods. Crusty exterior with a soft interior.',
      imageUrl:
          'https://images.unsplash.com/photo-1549931319-a545dcf3bc7c?q=80&w=800',
      category: 'Bakery',
      inStock: true,
      rating: 4.8,
      reviewCount: 156,
      stockQuantity: 25,
      addedDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Product(
      id: '18',
      name: 'Truffle Oil (250ml)',
      price: 49.99,
      description:
          'Premium black truffle infused olive oil. Adds luxurious flavor to pasta, risotto, and more.',
      imageUrl:
          'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?q=80&w=800',
      category: 'Oils & Condiments',
      inStock: true,
      rating: 4.9,
      reviewCount: 37,
      stockQuantity: 18,
      addedDate: DateTime.now().subtract(const Duration(days: 35)),
    ),
    Product(
      id: '19',
      name: 'Aged Balsamic Vinegar (500ml)',
      price: 56.50,
      description:
          '12-year aged balsamic vinegar from Modena, Italy. Rich, complex flavor for salads and marinades.',
      imageUrl:
          'https://images.unsplash.com/photo-1611499677455-e9dbac302829?q=80&w=800',
      category: 'Oils & Condiments',
      inStock: true,
      rating: 4.8,
      reviewCount: 42,
      stockQuantity: 30,
      addedDate: DateTime.now().subtract(const Duration(days: 40)),
    ),
    Product(
      id: '20',
      name: 'Milk Chocolate Couverture (5kg)',
      price: 89.99,
      description:
          'Professional grade couverture chocolate with 38% cocoa. Perfect for desserts and confections.',
      imageUrl:
          'https://images.unsplash.com/photo-1606312619558-abcabc7e0875?q=80&w=800',
      category: 'Chocolates & Confectionery',
      inStock: true,
      rating: 4.9,
      reviewCount: 76,
      stockQuantity: 42,
      addedDate: DateTime.now().subtract(const Duration(days: 14)),
    ),
  ];

  List<Product> get _filteredProducts {
    return _allProducts.where((product) {
        // Filter by search query
        if (_searchQuery.isNotEmpty &&
            !product.name.toLowerCase().contains(_searchQuery.toLowerCase()) &&
            !product.description.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            )) {
          return false;
        }

        // Filter by stock
        if (_inStockOnly && !product.inStock) {
          return false;
        }

        // Filter by price range
        if (product.price < _priceRange.start ||
            product.price > _priceRange.end) {
          return false;
        }

        // Filter by category
        if (_tabController.index > 0) {
          final categories = [
            'All',
            'Chocolates & Confectionery',
            'Grains & Rice',
            'Beverages',
            'Baking Supplies',
          ];

          if (categories[_tabController.index] != 'All' &&
              product.category != categories[_tabController.index]) {
            return false;
          }
        }

        return true;
      }).toList()
      ..sort((a, b) {
        // Sort by selected method
        switch (_sortBy) {
          case 'price_low_high':
            return a.price.compareTo(b.price);
          case 'price_high_low':
            return b.price.compareTo(a.price);
          case 'new_arrivals':
            return b.addedDate.compareTo(a.addedDate);
          case 'popularity':
          default:
            return b.rating.compareTo(a.rating);
        }
      });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.secondaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter Products',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price Range
                  Text(
                    'Price Range: \$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    activeColor: AppTheme.accentColor,
                    inactiveColor: Colors.white.withOpacity(0.2),
                    labels: RangeLabels(
                      '\$${_priceRange.start.toInt()}',
                      '\$${_priceRange.end.toInt()}',
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // In Stock Only
                  Row(
                    children: [
                      Checkbox(
                        value: _inStockOnly,
                        onChanged: (value) {
                          setState(() {
                            _inStockOnly = value ?? false;
                          });
                        },
                        activeColor: AppTheme.accentColor,
                        checkColor: Colors.white,
                      ),
                      const Text(
                        'Show In-Stock Items Only',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Sort By
                  const Text(
                    'Sort By',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _SortChip(
                        label: 'Popularity',
                        isSelected: _sortBy == 'popularity',
                        onTap: () {
                          setState(() {
                            _sortBy = 'popularity';
                          });
                        },
                      ),
                      _SortChip(
                        label: 'Price: Low to High',
                        isSelected: _sortBy == 'price_low_high',
                        onTap: () {
                          setState(() {
                            _sortBy = 'price_low_high';
                          });
                        },
                      ),
                      _SortChip(
                        label: 'Price: High to Low',
                        isSelected: _sortBy == 'price_high_low',
                        onTap: () {
                          setState(() {
                            _sortBy = 'price_high_low';
                          });
                        },
                      ),
                      _SortChip(
                        label: 'New Arrivals',
                        isSelected: _sortBy == 'new_arrivals',
                        onTap: () {
                          setState(() {
                            _sortBy = 'new_arrivals';
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Save filter settings and close
                        this.setState(() {
                          // Update state in parent
                          _priceRange = _priceRange;
                          _inStockOnly = _inStockOnly;
                          _sortBy = _sortBy;
                        });
                        Navigator.pop(context);
                      },
                      style: AppTheme.secondaryButtonStyle,
                      child: const Text('Apply Filters'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _filteredProducts;

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showFilterBottomSheet,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    suffixIcon:
                        _searchQuery.isNotEmpty
                            ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                            )
                            : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Category Tabs
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Chocolates & Confectionery'),
                  Tab(text: 'Grains & Rice'),
                  Tab(text: 'Beverages'),
                  Tab(text: 'Baking Supplies'),
                ],
                onTap: (_) {
                  setState(() {
                    // Refresh to apply category filter
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body:
          filteredProducts.isEmpty
              ? const Center(
                child: Text(
                  'No products match your criteria',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
              : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return _ProductCard(
                    product: product,
                    onTap: () {
                      // TODO: Navigate to product details
                    },
                  );
                },
              ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SortChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(label),
        backgroundColor:
            isSelected ? AppTheme.accentColor : Colors.white.withOpacity(0.1),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const _ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Stack(
                children: [
                  Image.network(
                    product.imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: Colors.grey.shade800,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.white54,
                          ),
                        ),
                      );
                    },
                  ),
                  if (!product.inStock)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Out of Stock',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${product.rating} (${product.reviewCount})',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: product.inStock ? onTap : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        textStyle: const TextStyle(fontSize: 12),
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: const Text('Add to Cart'),
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
