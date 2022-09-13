import 'controllers.dart';

final routes = {
  'inventory': (context) {
    return const DashboardController();
  },
  'inventory/products': (context) {
    return const ListProductsController();
  },
  'inventory/products/select': (context) {
    return const SelectProductController();
  },
  'inventory/products/create': (context) {
    return const CreateProductController();
  },
  'inventory/entries/create': (context) {
    return const CreateEntryController();
  },
};
