class CartData{
  int? p_id;
  String? p_name;
  double? p_cost;
  int? p_availability;
  String? p_details;
  String? p_category;
  int? p_quantity;
  String? p_img;

  CartData({
    required this.p_id,
    required this.p_name,
    required this.p_cost,
    required this.p_availability,
    required this.p_details,
    required this.p_category,
    required this.p_quantity,
    required this.p_img
  });

  CartData.fromJson(Map<String, dynamic> json){
    p_id = json['p_id'];
    p_name = json['p_name'];
    p_cost = json['p_cost'];
    p_availability = json['p_availability'] ?? 0;
    p_details = json['p_details'] ?? '';
    p_category = json['p_category'];
    p_quantity = json['p_quantity'];
    p_img = json['p_img'];
  }
}