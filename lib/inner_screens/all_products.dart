import 'package:flutter/material.dart' hide MenuController;
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:grocery_admin_panel/controllers/MenuController.dart';

import '../responsive.dart';
import '../screens/dashboard_screen.dart';
import '../services/utils.dart';
import '../widgets/grid_products.dart';
import '../widgets/side_menu.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    return Scaffold(
      key: context.read<MenuController>().getgridscaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Header(
                      fct: () {
                        context.read<MenuController>().controlProductsMenu();
                      },
                      title: 'All products',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Responsive(
                      mobile: ProductsGrid(
                        crossAxisCount: size.width < 650 ? 2 : 4,
                        childAspectRatio:
                            size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                        isInMain: false,
                      ),
                      desktop: ProductsGrid(
                        childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                        isInMain: false,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
