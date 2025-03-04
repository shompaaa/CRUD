import 'dart:convert';

import 'package:crud_app/data/models/productModel.dart';
import 'package:http/http.dart' as http;

import 'Urls.dart';



class ProductController{
  List<Data> products = [];
  Future<void> fetchProducts() async{
    final response = await http.get(Uri.parse(Urls.readProduct));

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      productModel model = productModel.fromJson(data);
      products = model.data ?? [];
    }
  }

  Future<void> createProducts(String name, String img, int qty, int unitPrice, int totalPrice) async{
    final response = await http.post(Uri.parse(Urls.createProduct),
      headers: {'Content-Type' : 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().millisecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      })
    );

    if(response.statusCode == 201){
      await fetchProducts();
    }
  }

  Future<void> updateProduct(String id,String name, String img, int qty, int unitPrice, int totalPrice) async{
    final response = await http.post(Uri.parse(Urls.updateProduct(id)),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({
          "ProductName": name,
          "ProductCode": DateTime.now().millisecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": unitPrice,
          "TotalPrice": totalPrice,
        })
    );

    if(response.statusCode == 201){
      await fetchProducts();
    }
  }

  Future<bool> deleteProduct(String id) async{
    final response = await http.get(Uri.parse(Urls.deleteProduct(id)));

    if(response.statusCode == 200){
     return true;
    }else{
      return false;
    }
  }
}