# FleXOrdeR - B2B Ordering App

A modern Flutter application for wholesale B2B ordering between retailers and wholesalers.

## Features

- **User Authentication**
  - Login and registration pages for retailers and wholesalers
  - User role-based access control

- **Dashboard**
  - Featured products showcase
  - Category browsing
  - Quick access to recent orders

- **Product Management**
  - Comprehensive product catalog
  - Detailed product information (pricing, description, ratings)
  - High-quality product images
  - Category filtering

- **Order Processing**
  - Shopping cart management
  - Checkout flow
  - Order confirmation
  - Real-time order tracking

- **User Profile**
  - Profile management
  - Settings customization
  - Order history

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Chrome browser (for web testing)

### Installation

1. Clone the repository
   ```
   git clone https://github.com/yourusername/flexorder.git
   ```

2. Navigate to the project directory
   ```
   cd flexorder
   ```

3. Get dependencies
   ```
   flutter pub get
   ```

4. Run the application
   ```
   flutter run -d chrome
   ```

## Architecture

This application follows a feature-first architecture with clear separation of concerns:

- **Core**: Common utilities, themes, and routing
- **Features**: Individual modules (auth, products, cart, etc.) with their own presentation, domain, and data layers

## Tech Stack

- **Flutter**: UI framework
- **Provider**: State management
- **Go Router**: Navigation
- **Firebase** (planned): Backend and authentication

## Screenshots

*Screenshots will be added here*

## Roadmap

- [ ] Implement backend integration
- [ ] Add payment processing
- [ ] Enhance order tracking with real-time updates
- [ ] Implement wholesaler inventory management
- [ ] Add analytics dashboard

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Images courtesy of Unsplash
- Icons from Material Design
