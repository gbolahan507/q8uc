import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/core/api/get_serial.dart';
import 'package:q8uc/core/api/pdf_api.dart';
import 'package:q8uc/core/api/pdf_invoice_api.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/model/pdf_model/customer.dart';
import 'package:q8uc/core/model/pdf_model/invoice.dart';
import 'package:q8uc/core/model/pdf_model/supplier.dart';
import 'package:q8uc/core/model/serial_model.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/core/view_models/serial_vm.dart';
import 'package:q8uc/ui/screens/navigation_screen.dart';
import 'package:q8uc/ui/screens/order_history.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_icon.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/router.dart';
import 'package:q8uc/utils/util.dart';
import 'package:share/share.dart';

class ReceitScreen extends StatefulWidget {
  const ReceitScreen({Key key, this.itemid, this.discount, this.totalAmount})
      : super(key: key);

  final String itemid;
  final String totalAmount, discount;

  @override
  _ReceitScreenState createState() => _ReceitScreenState();
}

class _ReceitScreenState extends State<ReceitScreen> {
  String pasteValue = '';
  SerialViewModel model;
  SerialApi serialApi;

  List serialNumber = [];
  TextEditingController field = TextEditingController();
  List<SerialResponse> seria = <SerialResponse>[];

  Future futureCheckout;
  SerialResponse serialResponse;

  getCheckout(SerialResponse serialResponse) async {
    return await serialApi.checkOut('68',
        '191b07af5d388b6d4a33c4da6312eb2b-1,39dc5563dbc51751f968c6e0f847d901-2'
        // AppCache.getUser().custormerId.toString(),
        // widget.itemid,
        );
  }

  @override
  void initState() {
    model = SerialViewModel();
    serialApi = SerialApi();
    super.initState();
    serialResponse = SerialResponse();
    futureCheckout = getCheckout(serialResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: CustomText(
            'ORDER COMPLETE ',
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          actions: [
            InkWell(
              onTap: () {
                print('HELLO');
                routeTo(context, OrderHistory());
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  CustomText(
                    'View history ',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ],
          leading: BackButton(
            onPressed: () => routeTo(context, ButtomNavScreen()),
          ),
        ),
        body: FutureBuilder(
            future: futureCheckout,
            builder: (context, snapshot) {
              final SerialResponse posts = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Center(
                    child: new Column(
                      children: <Widget>[
                        new Padding(padding: new EdgeInsets.all(50.0)),
                        new CircularProgressIndicator(),
                      ],
                    ),
                  );
                default:
                  if (snapshot.hasData) {
                    return Container(
                        color: Styles.colorLightPink,
                        padding: MediaQuery.of(context).viewInsets,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView(children: <Widget>[
                              verticalSpaceSmall,
                              Column(
                                children: [
                                  CustomText(
                                    'Order Details',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Styles.colorDeepGreen,
                                  ),
                                  verticalSpaceSmall,
                                  Container(
                                    padding: EdgeInsets.only(top: 12),
                                    decoration: BoxDecoration(
                                      color: Styles.colorWhite,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Styles.colorGreyLight,
                                            blurRadius: 4),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: posts.data.length,
                                            itemBuilder: (context, index) {
                                              return bagItem(
                                                context,
                                                index,
                                                '${posts.data[index].productImgPath}',
                                                '${posts.data[index].productName}',
                                                '${posts.data[index].unitProductPrice}',
                                              );
                                            }),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              CustomText('Discount',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Styles.colorBlack),
                                              CustomText('\$${widget.discount}',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Styles.colorLightBlue),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              CustomText('Total',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Styles.colorBlack),
                                              CustomText(
                                                  '\$${widget.totalAmount}',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Styles.colorDeepGreen),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  verticalSpaceMedium,
                                  CustomText(
                                    'Serial Number',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Styles.colorDeepGreen,
                                  ),
                                  verticalSpaceSmall,
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 12, left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      color: Styles.colorWhite,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Styles.colorGreyLight,
                                            blurRadius: 4),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(posts.data.length,
                                          (index) {
                                        final title =
                                            posts.data[index].productName;
                                        final sn =
                                            posts.data[index].serialNumbers;
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                title.toString(),
                                                color: Styles.colorBlack,
                                                fontSize: 12,
                                              ),
                                              horizontalSpaceSmall,
                                              horizontalSpaceMedium,
                                              Expanded(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectableText(sn.toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Styles.colorRed,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      cursorColor: Colors.red,
                                                      showCursor: true,
                                                      toolbarOptions:
                                                          ToolbarOptions(
                                                              copy: true,
                                                              selectAll: true,
                                                              cut: false,
                                                              paste: false)),
                                                ],
                                              )),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final date = DateTime.now();
                                          final dueDate =
                                              date.add(Duration(days: 7));

                                          final invoice = Invoice(
                                            supplier: Supplier(
                                              name: 'Q8UC',
                                              address:
                                                  'Sarah Street 9, Beijing, Arab',
                                              paymentInfo: 'https://q8uc.com',
                                            ),
                                            customer: Customer(
                                              name: AppCache.getUser()
                                                  .email
                                                  .toString(),
                                              address:
                                                  'Apple Street, Cupertino, CA 95014',
                                            ),
                                            info: InvoiceInfo(
                                              date: date,
                                              dueDate: dueDate,
                                              description: 'My description...',
                                              number:
                                                  '${DateTime.now().year}-9999',
                                            ),
                                            
                                            items: [
                                              InvoiceItem(
                                                description: 'Coffee',
                                                date: DateTime.now(),
                                                quantity: 3,
                                                vat: 0.19,
                                                unitPrice: 5.99,
                                              ),
                                              InvoiceItem(
                                                description: 'Water',
                                                date: DateTime.now(),
                                                quantity: 8,
                                                vat: 0.19,
                                                unitPrice: 0.99,
                                              ),
                                              InvoiceItem(
                                                description: 'Orange',
                                                date: DateTime.now(),
                                                quantity: 3,
                                                vat: 0.19,
                                                unitPrice: 2.99,
                                              ),
                                              InvoiceItem(
                                                description: 'Apple',
                                                date: DateTime.now(),
                                                quantity: 8,
                                                vat: 0.19,
                                                unitPrice: 3.99,
                                              ),
                                              InvoiceItem(
                                                description: 'Mango',
                                                date: DateTime.now(),
                                                quantity: 1,
                                                vat: 0.19,
                                                unitPrice: 1.59,
                                              ),
                                              InvoiceItem(
                                                description: 'Blue Berries',
                                                date: DateTime.now(),
                                                quantity: 5,
                                                vat: 0.19,
                                                unitPrice: 0.99,
                                              ),
                                              InvoiceItem(
                                                description: 'Lemon',
                                                date: DateTime.now(),
                                                quantity: 4,
                                                vat: 0.19,
                                                unitPrice: 1.29,
                                              ),
                                            ],
                                          );

                                          final pdfFile =
                                              await PdfInvoiceApi.generate(
                                                  invoice);

                                          PdfApi.openFile(pdfFile);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: CustomText('Generate pdf')),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: screenAwareSize(20, context)),
                            ])));
                  } else {
                    return Center(
                      child: new Column(
                        children: <Widget>[
                          new Padding(padding: new EdgeInsets.all(50.0)),
                          verticalSpaceLarge,
                          verticalSpaceLarge,
                          verticalSpaceLarge,
                          Center(
                            child: new CustomText(
                              'No order has been made',
                              color: Styles.colorWhite,
                            ),
                          ),
                          verticalSpaceMedium,
                          InkWell(
                            onTap: () {
                              routeTo(context, ButtomNavScreen());
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Styles.colorRed),
                                child: CustomText(
                                  'Home',
                                  fontSize: 12,
                                  color: Styles.colorWhite,
                                )),
                          )
                        ],
                      ),
                    );
                  }
              }
            }));
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      color: Styles.colorRed,
      child: Icon(
        Icons.delete,
        color: Styles.colorWhite,
      ),
    );
  }

  Widget bagItem(
    BuildContext context,
    int index,
    String imageUrl,
    String name,
    String price,
  ) {
    return Container(
      child: Padding(
          padding: EdgeInsets.only(
              bottom: screenAwareSize(12, context), left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      screenAwareSize(33, context),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '$imageUrl',
                      height: screenAwareSize(50, context),
                      width: screenAwareSize(50, context),
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Utils.progress(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(width: screenAwareSize(20, context)),
                  CustomText(
                    '$name',
                    fontSize: 13,
                    color: Styles.colorBlack,
                  ),
                  Spacer(),
                  CustomText(
                    '\$$price',
                    fontSize: 13,
                    color: Styles.colorBlack,
                  )
                ],
              ),
              verticalSpaceTiny,
            ],
          )),
    );
  }

  Widget serialBag(BuildContext context, int index, String imageUrl,
      String name, String price, String serialNumber, int total) {
    return Container(
      child: Padding(
          padding: EdgeInsets.only(
              bottom: screenAwareSize(12, context), left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    '$name',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Styles.colorBlack,
                  ),
                  // Spacer(),
                  horizontalSpaceMedium,

                  Expanded(
                    child: Column(
                      children: List.generate(total, (index) {
                        return SelectableText('$serialNumber',
                            style: TextStyle(
                                color: Styles.colorRed,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            cursorColor: Colors.red,
                            showCursor: true,
                            toolbarOptions: ToolbarOptions(
                                copy: true,
                                selectAll: true,
                                cut: true,
                                paste: false));
                      }),
                    ),
                  ),

                  horizontalSpaceMedium,
                  CustomIcon(
                    icon: Icons.share,
                    size: 17,
                    color: Styles.appBackground1,
                    onPressed: () async {
                      await Share.share('$serialNumber');
                    },
                  ),
                ],
              ),
              verticalSpaceTiny,
            ],
          )),
    );
  }
}
