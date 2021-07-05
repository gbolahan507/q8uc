// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);


// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

// class Welcome {
//     Welcome({
//         this.status,
//         this.msg,
//         this.data,
//     });

//     int status;
//     String msg;
//     List<Datum> data;

//     factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
//         status: json["status"],
//         msg: json["msg"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "msg": msg,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

class Datum {
    Datum({
        this.status,
        this.statusMessage,
        this.productId,
        this.serialNumber,
        this.productName,
        this.productImgPath,
        this.productPrice,
    });

    int status;
    String statusMessage;
    String productId;
    String serialNumber;
    String productName;
    String productImgPath;
    String productPrice;

    factory Datum.fromJson(dynamic json) => Datum(
        status: json["status"],
        statusMessage: json["status_message"],
        productId: json["product_id"],
        serialNumber: json["serial_number"],
        productName: json["product_name"],
        productImgPath: json["product_img_path"],
        productPrice: json["product_price"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_message": statusMessage,
        "product_id": productId,
        "serial_number": serialNumber,
        "product_name": productName,
        "product_img_path": productImgPath,
        "product_price": productPrice,
    };
}
