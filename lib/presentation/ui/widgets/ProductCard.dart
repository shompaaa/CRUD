import 'package:crud_app/data/models/productModel.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Data product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const ProductCard({super.key, required this.product, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05)
            )
          ]
      ),
      child: Column(
        children: [
          ClipRect(
            child: Center(
              child: Container(
                height: 130,
                color: Colors.grey.shade200,
                child: Image.network(
                  product.img.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName.toString(),
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                Text('Price: ${product.unitPrice} | Qty: ${product.qty}',
                  style: TextStyle(
                      fontSize: 18, color: Colors.black54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: onEdit, icon: Icon(Icons.edit,size: 30,)),
                      IconButton(onPressed: onDelete, icon: Icon(Icons.delete,size: 30,color: Colors.red,))
                    ],
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
