import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productImageController = TextEditingController();
  TextEditingController productQtyController = TextEditingController();
  TextEditingController productUnitPriceController = TextEditingController();
  TextEditingController productTotalPriceController = TextEditingController();
  void productDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add Product'),
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
                          onPressed: () {},
                          child: Text(
                            'Add',
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: ListTile(
                  leading: Icon(
                    Icons.image,
                    size: 50,
                  ),
                  title: Text(
                    'Iphone 16',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Price: \$500 | Qty: 20',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            size: 30,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
              );
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
