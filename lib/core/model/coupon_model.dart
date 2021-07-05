class CouponModel {
  int status;
  String msg;
  String couponCode;
  String discountAmount;

  CouponModel({this.status, this.msg, this.couponCode, this.discountAmount});

  CouponModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    couponCode = json['coupon_code'];
    discountAmount = json['discount_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['coupon_code'] = this.couponCode;
    data['discount_amount'] = this.discountAmount;
    return data;
  }
}
