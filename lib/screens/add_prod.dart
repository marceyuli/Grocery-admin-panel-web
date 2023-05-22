import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide MenuController;
import 'package:flutter/services.dart';
import 'package:grocery_admin_panel/responsive.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/buttons.dart';
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:grocery_admin_panel/widgets/side_menu.dart';
import 'package:grocery_admin_panel/widgets/text_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
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
  String catValue = 'Vegetables';
  int groupValue = 1;
  bool isPiece = false;
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);

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
                                          categoryDropDown(),
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
                                          ),
                                          Row(
                                            children: [
                                              TextWidget(
                                                  text: 'KG', color: color),
                                              Radio(
                                                value: 1,
                                                groupValue: groupValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    groupValue = 1;
                                                    isPiece = false;
                                                  });
                                                },
                                                activeColor: Colors.green,
                                              ),
                                              TextWidget(
                                                  text: 'Piece', color: color),
                                              Radio(
                                                value: 2,
                                                groupValue: groupValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    groupValue = 2;
                                                    isPiece = true;
                                                  });
                                                },
                                                activeColor: Colors.green,
                                              )
                                            ],
                                          )
                                        ]),
                                  )),
                              //Image to be picked code is here
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: size.width > 650
                                          ? 350
                                          : size.width * 0.45,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: _pickedImage == null
                                          ? dottedBorder(color: color)
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: kIsWeb
                                                  ? Image.memory(webImage,
                                                      fit: BoxFit.fill)
                                                  : Image.file(
                                                      _pickedImage!,
                                                      fit: BoxFit.fill,
                                                    ),
                                            )),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    child: Column(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _pickedImage = null;
                                                webImage = Uint8List(8);
                                              });
                                            },
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

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }

  Widget dottedBorder({required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DottedBorder(
          dashPattern: const [6.7],
          borderType: BorderType.RRect,
          color: color,
          radius: const Radius.circular(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.image_outlined, color: color, size: 50),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: (() {
                    _pickImage();
                  }),
                  child:
                      TextWidget(text: 'Choose an image', color: Colors.blue),
                )
              ],
            ),
          )),
    );
  }

  Widget categoryDropDown() {
    final color = Utils(context).color;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20, color: color),
          value: catValue,
          onChanged: (value) {
            setState(() {
              catValue = value!;
            });
          },
          hint: const Text('Select a category'),
          items: const [
            DropdownMenuItem(
              child: Text('Vegetables'),
              value: 'Vegetables',
            ),
            DropdownMenuItem(
              child: Text('Fruits'),
              value: 'Fruits',
            ),
            DropdownMenuItem(
              child: Text('Grains'),
              value: 'Grains',
            ),
            DropdownMenuItem(
              child: Text('Nuts'),
              value: 'Nuts',
            ),
            DropdownMenuItem(
              child: Text('Herbs'),
              value: 'Herbs',
            ),
            DropdownMenuItem(
              child: Text('Species'),
              value: 'Species',
            ),
          ],
        )),
      ),
    );
  }
}
