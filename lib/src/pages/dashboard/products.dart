// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';

class ProductsStatus extends StatefulWidget {
  const ProductsStatus({super.key});

  @override
  State<ProductsStatus> createState() => _ProductsStatusState();
}

class _ProductsStatusState extends State<ProductsStatus> {
  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productdesc = TextEditingController();
  List<dynamic> products = []; // List to store product data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: AppColors.neutral,
        ),
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          productname.clear();
          productdesc.clear();
          productprice.clear();
          _showAddProductPopup(context, false, '');
        },
      ),
      backgroundColor: AppColors.mainbackground,
      body: products != null && products.isNotEmpty
          ? Wrap(children: [
              for (int i = 0; i < products.length; i++)
                GestureDetector(
                  onTap: () {
                    _showAddProductPopup(
                        context, true, products[i]['id'].toString());
                    setState(() {
                      productname.text = products[i]['name'];
                      productdesc.text = products[i]['description'];
                      productprice.text = products[i]['price'];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * .35,
                    height: MediaQuery.of(context).size.height * .18,
                    decoration: BoxDecoration(
                        color: AppColors.sidebarbackground,
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 120,
                              height: MediaQuery.of(context).size.height * .18,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    scale: .5,
                                    opacity: .7,
                                    image: AssetImage(
                                        '../../assets/png/in-stock.png'), // Replace 'your_image.png' with the path to your image asset
                                    fit: BoxFit.contain,
                                  ),
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(text: products[i]['name']),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      CustomText(text: products[i]['price']),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text:
                                        'Created: ${formatDate(products[i]['created_at'])}',
                                    fontSize: 12,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text:
                                        'Updated: ${formatDate(products[i]['updated_at'])}',
                                    fontSize: 12,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text: products[i]['description'],
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            right: 5,
                            top: 5,
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: AppColors.mainbackground,
                              ),
                              onPressed: () {
                                // Show the confirmation dialog
                                _showDeleteConfirmationDialog(
                                    context, products[i]['id'].toString());
                              },
                            ))
                      ],
                    ),
                  ),
                )
            ])
          : Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
    );
  }

  // Function to show the confirmation dialog
  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String productId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.sidebarbackground,
          title: CustomText(text: 'Delete Confirmation'),
          content: CustomText(text: 'Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: CustomText(text: 'Cancel'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.mainColor)),
              onPressed: () {
                _deleteProduct(productId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: CustomText(text: 'Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      print(productId);
      Dio dio = Dio();
      dio.options.headers['Authorization'] =
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAyNjYwNzk3fQ.aNgcnhSk31oF3CP_72Aiy38hKiNYIuhrNrxcGk6jp7Y';
      final response = await dio
          .delete('https://loan-managment.onrender.com/products/$productId');

      // Check the response status code and handle accordingly
      if (response.statusCode == 200) {
        // Successful delete
        _fetchProducts();
        print('Product deleted successfully.');
      } else {
        // Handle error
        print('Error deleting product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle Dio errors
      print('Dio error: $error');
    }
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM yy, hh:mma').format(dateTime);
    return formattedDate;
  }

  void _showAddProductPopup(BuildContext context, bool update, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.sidebarbackground,
          title: CustomText(text: 'Add Product'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Add your form fields or content for adding a product
                Row(
                  children: [
                    Expanded(
                      child: buildEditableField(
                        'Product',
                        productname,
                        false,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a product';
                          } else if (value.length < 4) {
                            return 'Product name must be at least 4 characters long';
                          }
                          return null; // Return null if validation passes
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: buildEditableField(
                        'Price',
                        productprice,
                        false,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter product price';
                          }
                          return null; // Return null if validation passes
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                buildEditableField(
                  'Description',
                  productdesc,
                  false,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null; // Return null if validation passes
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the popup
                Navigator.of(context).pop();
              },
              child: CustomText(
                text: 'Cancel',
                fontSize: 16,
                color: AppColors.mainColor,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.mainColor)),
              onPressed: () async {
                if (update == false) {
                  await addToCart(
                    productname.text,
                    productprice.text,
                    productdesc.text,
                    context,
                  );
                }
                if (update == true) {
                  await updateProduct(
                    productname.text,
                    id,
                    productprice.text,
                    productdesc.text,
                    context,
                  );
                }
              },
              child: CustomText(
                text: update == true ? 'Update' : 'Add',
                fontSize: 16,
                color: AppColors.neutral,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Call the API when the page is opened
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      // Replace 'YOUR_BEARER_TOKEN' with your actual Bearer token
      String bearerToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAyNjYwNzk3fQ.aNgcnhSk31oF3CP_72Aiy38hKiNYIuhrNrxcGk6jp7Y';

      final response = await Dio().get(
        'https://loan-managment.onrender.com/products',
        options: Options(
          headers: {
            'Authorization': 'Bearer $bearerToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        products = response.data;
      } else {
        // Handle API error
        print('Failed to fetch products. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle Dio errors or network errors
      print('Error: $error');
    }
  }

  Future<void> addToCart(
    String name,
    String price,
    String description,
    BuildContext context,
  ) async {
    // Validate the form fields before proceeding
    try {
      // Prepare data for API request
      Map<String, dynamic> productData = {
        "product": {
          "name": name,
          "price": price,
          "description": description,
        }
      };

      // Replace 'YOUR_BEARER_TOKEN' with your actual Bearer token
      String bearerToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAyNjYwNzk3fQ.aNgcnhSk31oF3CP_72Aiy38hKiNYIuhrNrxcGk6jp7Y';
      print('here');
      // Perform the POST request using Dio
      Response response = await Dio().post(
        'https://loan-managment.onrender.com/products',
        data: productData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Product added successfully, handle the response as needed
        print('Product added successfully: ${response.data}');
        productdesc.clear();
        productname.clear();
        productprice
            .clear(); // Close the popup or perform other actions if needed
        _fetchProducts();
        Navigator.of(context).pop();
      } else {
        // Handle API error
        print('Failed to add product. Status code: ${response.statusCode}');
        // Display an error message to the user if needed
      }
    } catch (error) {
      // Handle Dio errors or network errors
      print('Error: $error');
      // Display an error message to the user if needed
    }
  }

  Future<void> updateProduct(
    String name,
    String id,
    String price,
    String description,
    BuildContext context,
  ) async {
    // Validate the form fields before proceeding
    try {
      // Prepare data for API request
      Map<String, dynamic> productData = {
        "product": {
          "name": name,
          "price": price,
          "description": description,
        }
      };

      // Replace 'YOUR_BEARER_TOKEN' with your actual Bearer token
      String bearerToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAyNjYwNzk3fQ.aNgcnhSk31oF3CP_72Aiy38hKiNYIuhrNrxcGk6jp7Y';

      // Perform the POST request using Dio
      Response response = await Dio().put(
        'https://loan-managment.onrender.com/products/$id',
        data: productData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Product added successfully, handle the response as needed
        print('Product updaed successfully: ${response.data}');
        productdesc.clear();
        productname.clear();
        productprice
            .clear(); // Close the popup or perform other actions if needed
        _fetchProducts();

        Navigator.of(context).pop();
      } else {
        // Handle API error
        print('Failed to update product. Status code: ${response.statusCode}');
        // Display an error message to the user if needed
      }
    } catch (error) {
      // Handle Dio errors or network errors
      print('Error: $error');
      // Display an error message to the user if needed
    }
  }
}

Widget buildEditableField(String labelText, TextEditingController controller,
    bool isEditing, String? Function(String?)? validator) {
  return TextFormField(
    readOnly: isEditing,
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: GoogleFonts.dmSans(
        color: AppColors.neutral,
        height: 0.5,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: AppColors.neutral, width: 1.0),
      ),
    ),
    style: GoogleFonts.dmSans(
      color: AppColors.neutral,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    validator: validator,
  );
}

class Product {
  final String serialNumber;
  final String id;
  final String name;
  final String price;
  final String description;
  final String created;
  final String updated;

  Product(
      {required this.serialNumber,
      required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.created,
      required this.updated});
}
