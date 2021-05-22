import 'package:flutter/material.dart';
import 'package:q8uc/core/actionService.dart';
import 'package:q8uc/model/categories.dart';
import 'package:q8uc/widget/export.dart';
import 'package:q8uc/widget/product_container.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  ActionService apiService;
  bool isApiCallProcess = false;

  @override
  void initState() {
    apiService = ActionService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText('homepage'),
      ),
      body: _categoriesList(),
    );
  }

  Widget _categoriesList() {
    return FutureBuilder(
        future: apiService.getProductCategories(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Categories>> model,
        ) {
          if (model.hasData) {
            return _buildCategoryList(model.data);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildCategoryList(List<Categories> categories) {
    return Container(
        height: 50,
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              var data = categories[index];
              return ProductContainer(
                network: true,
                image: data.images.url,
                productName: data.productName,
                productPrice: data.productPrice,
                productLastPrice: data.productLastPrice,
                productCancelledPrice: data.productCancelledPrice,
              );
            }));
  }
}
