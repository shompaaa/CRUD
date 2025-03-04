import 'package:crud_app/data/models/productModel.dart';
import 'package:crud_app/presentation/ui/widgets/ProductCard.dart';
import 'package:crud_app/utils/ProductController.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ProductController productController = ProductController();
  void productDialog(
      {String? id,
      String? name,
      String? img,
      int? qty,
      int? unitPrice,
      int? totalPrice}) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productQtyController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

    productNameController.text = name ?? '';
    productImageController.text = img ?? '';
    productQtyController.text = qty !=null ? qty.toString() : '';
    productUnitPriceController.text = unitPrice != null ? unitPrice.toString() : '';
    productTotalPriceController.text = totalPrice != null ? totalPrice.toString() : '';

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(id == null ? 'Add Product' : 'Update Product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: productNameController,
                    decoration: InputDecoration(
                        labelText: 'Product Name',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.grey)),
                  ),
                  TextField(
                    controller: productImageController,
                    decoration: InputDecoration(
                        labelText: 'Product Image',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.grey)),
                  ),
                  TextField(
                    controller: productQtyController,
                    decoration: InputDecoration(
                        labelText: 'Product Qty',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.grey)),
                  ),
                  TextField(
                    controller: productUnitPriceController,
                    decoration: InputDecoration(
                        labelText: 'Product Unit Price',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.grey)),
                  ),
                  TextField(
                    controller: productTotalPriceController,
                    decoration: InputDecoration(
                        labelText: 'Product Total Price',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.grey)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 20),
                          )),
                      TextButton(
                          onPressed: () async {
                            if (id == null) {
                              productController.createProducts(
                                  productNameController.text,
                                  productImageController.text,
                                  int.parse(productQtyController.text),
                                  int.parse(productUnitPriceController.text),
                                  int.parse(productTotalPriceController.text));
                            } else {
                              productController.updateProduct(
                                id,
                                productNameController.text,
                                productImageController.text,
                                int.parse(productQtyController.text),
                                int.parse(productUnitPriceController.text),
                                int.parse(productTotalPriceController.text),
                              );
                            }

                            await fetchData();
                            Navigator.pop(context);
                            setState(() {});

                          },
                          child: Text(
                            id == null ? 'Add' : 'Update',
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  )
                ],
              ),
            ));
  }

  Future<void> fetchData() async {
    await productController.fetchProducts();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text(
          'CRUD Application',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8),
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              var product = productController.products[index];
              return ProductCard(
                  product: product,
                  onEdit: () => productDialog(
                    id: product.sId,
                    name: product.productName,
                    img: product.img,
                    qty: product.qty,
                    unitPrice: product.unitPrice,
                    totalPrice: product.totalPrice,
                  ),
                  onDelete: () {
                    productController
                        .deleteProduct(product.sId.toString())
                        .then((value) {
                      if (value) {
                        setState(() {
                          fetchData();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'successfully deleted',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.green,
                              ),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'something went wrong! try again later',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.red,
                              ),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    });
              });
            }),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
        onPressed: () => productDialog(),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
