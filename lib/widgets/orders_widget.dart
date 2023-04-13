import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/text_widget.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = theme == true ? Colors.white : Colors.black;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                flex: size.width < 650 ? 3 : 1,
                child: Image.network(
                  'https://i.pinimg.com/originals/92/69/8a/92698adcd3d266854b2c097414a0e830.png',
                  fit: BoxFit.fill,
                )),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: '12x for \$19.9',
                      color: color,
                      textSize: 16,
                      isTitle: true,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          TextWidget(
                            text: 'By',
                            color: Colors.blue,
                            textSize: 16,
                            isTitle: true,
                          ),
                          TextWidget(
                            text: 'Yuliana M.',
                            color: color,
                            textSize: 14,
                            isTitle: true,
                          )
                        ],
                      ),
                    ),
                    const Text('20/03/2022')
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
