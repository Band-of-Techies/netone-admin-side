// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:netone_loanmanagement_admin/config/config_dev.dart';

final String endpoint = AppConfig.apiUrl;

class CategoryStatus extends StatefulWidget {
  const CategoryStatus({super.key});

  @override
  State<CategoryStatus> createState() => _CategoryStatusState();
}

class _CategoryStatusState extends State<CategoryStatus> {
  TextEditingController catname = TextEditingController();
  TextEditingController catdesc = TextEditingController();
  List<dynamic> cats = []; // List to store product data
  bool isloading = true;
  String? email;
  String? token;
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
          catname.clear();
          catdesc.clear();

          _showAddProductPopup(context, false, '');
        },
      ),
      backgroundColor: AppColors.mainbackground,
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : cats != null && cats.isNotEmpty
              ? Wrap(children: [
                  for (int i = 0; i < cats.length; i++)
                    GestureDetector(
                      onTap: () {
                        _showAddProductPopup(
                            context, true, cats[i]['id'].toString());
                        setState(() {
                          catname.text = cats[i]['name'];
                          catdesc.text = cats[i]['description'];
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
                                  height:
                                      MediaQuery.of(context).size.height * .18,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CustomText(text: cats[i]['name']),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        text:
                                            'Created: ${formatDate(cats[i]['created_at'])}',
                                        fontSize: 12,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        text:
                                            'Updated: ${formatDate(cats[i]['updated_at'])}',
                                        fontSize: 12,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        text: cats[i]['description'],
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
                                        context, cats[i]['id'].toString());
                                  },
                                ))
                          ],
                        ),
                      ),
                    )
                ])
              : Center(
                  child: CustomText(text: "No Categories found"),
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      email = prefs.getString('email');
      isloading = true;
    });
    try {
      print(productId);
      Dio dio = Dio();
      dio.options.headers['Authorization'] = token!;
      final response = await dio.delete('$endpoint/categories/$productId');

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
          title: CustomText(text: 'Add Category'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Add your form fields or content for adding a product

                buildEditableField(
                  'Category Name',
                  catname,
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

                const SizedBox(
                  height: 20,
                ),
                buildEditableField(
                  'Description',
                  catdesc,
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
                    catname.text,
                    catdesc.text,
                    context,
                  );
                }
                if (update == true) {
                  await updateProduct(
                    catname.text,
                    id,
                    catdesc.text,
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      email = prefs.getString('email');
      isloading = true;
    });
    try {
      // Replace 'YOUR_BEARER_TOKEN' with your actual Bearer token
      String bearerToken = token!;

      final response = await Dio().get(
        '$endpoint/categories',
        options: Options(
          headers: {
            'Authorization': 'Bearer $bearerToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          cats = response.data;
          isloading = false;
        });
        print(response.data);
      } else {
        // Handle API error
        print('Failed to fetch products. Status code: ${response.statusCode}');
        setState(() {
          isloading = false;
        });
      }
    } catch (error) {
      // Handle Dio errors or network errors
      print('Error: $error');
      setState(() {
        isloading = false;
      });
    }
  }

  Future<void> addToCart(
    String name,
    String description,
    BuildContext context,
  ) async {
    // Validate the form fields before proceeding
    try {
      // Prepare data for API request
      Map<String, dynamic> categoryData = {
        "category": {"name": name, "description": description}
      };
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        token = prefs.getString('token');
        email = prefs.getString('email');
        isloading = true;
      });
      // Replace 'YOUR_BEARER_TOKEN' with your actual Bearer token
      String bearerToken = token!;
      print('here');
      // Perform the POST request using Dio
      Response response = await Dio().post(
        '$endpoint/categories',
        data: categoryData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Product added successfully, handle the response as needed
        print('Category added successfully: ${response.data}');
        catdesc.clear();
        catname.clear();

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
    String description,
    BuildContext context,
  ) async {
    // Validate the form fields before proceeding
    try {
      // Prepare data for API request
      Map<String, dynamic> productData = {
        "category": {
          "name": name,
          "description": description,
        }
      };
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        token = prefs.getString('token');
        email = prefs.getString('email');
        isloading = true;
      });
      // Replace 'YOUR_BEARER_TOKEN' with your actual Bearer token
      String bearerToken = token!;

      // Perform the POST request using Dio
      Response response = await Dio().put(
        '$endpoint/categories/$id',
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
        catdesc.clear();
        catname.clear();

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
