

import 'dart:convert';

SerialResponse itemModelFromJson(String str) => SerialResponse.fromJson(json.decode(str));

String itemModelToJson(SerialResponse data) => json.encode(data.toJson());

class SerialResponse {
    SerialResponse({
        this.status,
        this.msg,
        this.data,
    });

    int status;
    String msg;
    List<Datum> data;

    factory SerialResponse.fromJson(Map<String, dynamic> json) => SerialResponse(
        status: json["status"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.status,
        this.productId,
        this.statusForProduct,
        this.serialNumbers,
        this.productName,
        this.productImgPath,
        this.unitProductPrice,
        this.totalProductPrice,
        this.customerEmail,
    });

    int status;
    String productId;
    String statusForProduct;
    List<String> serialNumbers;
    String productName;
    String productImgPath;
    String unitProductPrice;
    double totalProductPrice;
    dynamic customerEmail;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        status: json["status"],
        productId: json["product_id"],
        statusForProduct: json["status_for_product"],
        serialNumbers: List<String>.from(json["serial_numbers"].map((x) => x)),
        productName: json["product_name"],
        productImgPath: json["product_img_path"],
        unitProductPrice: json["unit_product_price"],
        totalProductPrice: json["total_product_price"].toDouble(),
        customerEmail: json["customer_email"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "product_id": productId,
        "status_for_product": statusForProduct,
        "serial_numbers": List<dynamic>.from(serialNumbers.map((x) => x)),
        "product_name": productName,
        "product_img_path": productImgPath,
        "unit_product_price": unitProductPrice,
        "total_product_price": totalProductPrice,
        "customer_email": customerEmail,
    };
}
