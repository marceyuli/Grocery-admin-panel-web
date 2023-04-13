import 'package:flutter/material.dart' hide MenuController;
import 'package:flutter/services.dart';
import 'package:grocery_admin_panel/responsive.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/buttons.dart';
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:grocery_admin_panel/widgets/side_menu.dart';
import 'package:grocery_admin_panel/widgets/text_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../controllers/MenuController.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';
  const UploadProductForm({super.key});

  @override
  State<UploadProductForm> createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController titleController, priceController;

  @override
  void initState() {
    priceController = TextEditingController();
    titleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    priceController.dispose();
    titleController.dispose();
    super.dispose();
  }

  void uploadForm() async {
    final isValid = formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = Utils(context).color;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).getScreenSize;

    var inputDecoration = InputDecoration(
        filled: true,
        fillColor: scaffoldColor,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color, width: 1.0)));
    return Scaffold(
      key: context.read<MenuController>().getAddProductscaffoldKey,
      drawer: const SideMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context)) const Expanded(child: SideMenu()),
          Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Header(
                      fct: () {
                        context.read<MenuController>().controlAddProductsMenu();
                      },
                      title: 'Add product',
                      showText: false,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: size.width > 650 ? 650 : size.width,
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextWidget(
                            text: 'Product title',
                            color: color,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: titleController,
                            key: const ValueKey('Title'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                            decoration: inputDecoration,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: FittedBox(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: 'Price in \$*',
                                            color: color,
                                            isTitle: true,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: TextFormField(
                                              controller: priceController,
                                              key: const ValueKey('Price \$'),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Price is missed';
                                                }
                                                return null;
                                              },
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9.]'))
                                              ],
                                              decoration: inputDecoration,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextWidget(
                                            text: 'Product category',
                                            color: color,
                                            isTitle: true,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          //Drop down menu code here
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextWidget(
                                            text: 'Measure unit*',
                                            color: color,
                                            isTitle: true,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ]),
                                  )),
                              //Image to be picked code is here
                              Expanded(
                                flex: 4,
                                child: Container(
                                  color: Colors.red,
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    child: Column(
                                      children: [
                                        TextButton(
                                            onPressed: () {},
                                            child: TextWidget(
                                                text: 'Clear',
                                                color: Colors.red)),
                                        TextButton(
                                            onPressed: () {},
                                            child: TextWidget(
                                                text: 'Update image',
                                                color: Colors.blue))
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtonsWidget(
                                    onPressed: () {},
                                    text: 'Clear form',
                                    icon: IconlyBold.danger,
                                    backgroundColor: Colors.red.shade300),
                                ButtonsWidget(
                                    onPressed: () {
                                      uploadForm();
                                    },
                                    text: 'Upload',
                                    icon: IconlyBold.upload,
                                    backgroundColor: Colors.blue)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ))
        ],
      ),
    );
  }
}
