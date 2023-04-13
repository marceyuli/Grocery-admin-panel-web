import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/widgets/products_widget.dart';


import '../services/utils.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid(
      {super.key, this.crossAxisCount = 4, this.childAspectRatio = 1});
  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 4,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    childAspectRatio: childAspectRatio,
                                    crossAxisSpacing: defaultPadding,
                                    mainAxisSpacing: defaultPadding),
                            itemBuilder: (context, index) {
                              return ProductWdiget();
                            });
  }
}
