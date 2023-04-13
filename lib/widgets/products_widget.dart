import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/widgets/text_widget.dart';

import '../services/utils.dart';

class ProductWdiget extends StatefulWidget {
  const ProductWdiget({super.key});

  @override
  State<ProductWdiget> createState() => _ProductWdigetState();
}

class _ProductWdigetState extends State<ProductWdiget> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Image.network(
                        'https://i.pinimg.com/originals/92/69/8a/92698adcd3d266854b2c097414a0e830.png',
                        fit: BoxFit.fill,
                        height: size.width * 0.12,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {},
                                child: Text('Edit'),
                                value: 1,
                              ),
                              PopupMenuItem(
                                onTap: (){},
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ))
                            ])
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    TextWidget(
                      text: '\$1.99',
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: true,
                        child: Text(
                          '\$3.89',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color),
                        )),
                    const Spacer(),
                    TextWidget(
                      text: '1 Kg',
                      color: color,
                      textSize: 18,
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  text: 'Title',
                  color: color,
                  textSize: 24,
                  isTitle: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
