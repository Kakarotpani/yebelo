import 'package:cart/json_data/json_data.dart';
import 'package:cart/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {

  final String title;
  const CartView({Key? key, required this.title}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  List<CartData> cartList = [];
  double appBarHeight = AppBar().preferredSize.height;
  dynamic totalPrice = 0;
  List<String> selectedCategory = [];
  List selectCount = [];

  @override
  void initState() {
    cartList = data.map<CartData>((json) => CartData.fromJson(json)).toList();
    for(var item in cartList){
      totalPrice += item.p_cost!;
      selectCount.add(item.p_quantity);
    }
    super.initState();
  }

  Widget bottomValue(String title){
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 131, 57, 234),
      ),
    );
  }

  confirmation(BuildContext context,List cartList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: SizedBox(
            height: 210,
            width: 300,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text('Quantity',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 2),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(cartList[index].p_name.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 151, 47, 203),
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(cartList[index].p_quantity.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                  ),
                ),
              ],
            )
          ),
          actions: [
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff6750a4),
              ),
              child: const Text('order',
                style: TextStyle(
                  color: Colors.white
                ),
              )
            )
          ],
        );
      },
    );
  }

  Future<void> showInformationDialog(BuildContext context) async {
    List<String> allCategory = [];
    for(var i in cartList){
      allCategory.add(i.p_category.toString());
    }
    allCategory = allCategory.toSet().toList();
    allCategory.remove('null');

    return await showDialog(
      context: context,
      builder: (context) {
        List<bool> check = [];
        for(int i=0;i<allCategory.length;i++){
          check.add(false);
        }
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text("Select Category"),
            content: SizedBox(
              height: 300,
              width: 300,
              child: ListView.builder(
                itemCount: allCategory.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: check[index],
                      onChanged: (value) {
                        setState(() {
                          check[index] = value!;
                          selectedCategory.add(allCategory[index].toString());
                        });
                      },
                    ),
                    title: Text(allCategory[index].toString()),
                  );
                })
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: (){
                  for(var cat in selectedCategory){
                    for(int i=0;i<cartList.length;i++){
                      if(cartList[i].p_category != cat){
                        setState(() {
                          cartList.remove(cartList[i]);
                        });
                      }
                    }
                  }
                  Navigator.pop(context);
                },
                child: const Text('apply')
              )
            ],
          );
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: (){},
          child: const Icon(
            Icons.chevron_left_sharp,
            color: Color.fromARGB(255, 131, 57, 234),
            size: 24.0
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Color.fromARGB(255, 131, 57, 234),
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        height: appBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Total price',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Row(
                  children: [
                    bottomValue('₹ '),
                    bottomValue(totalPrice.toString())
                  ],
                )
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 131, 57, 234),
              ),
              onPressed: () => confirmation(context, cartList),
              child: const Text('continue',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
      
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.only(
              left: 10,
              right: 10
            ),
            height: appBarHeight,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Pin Code : ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: const Text('756969',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),                  
                ElevatedButton(                    
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () => showInformationDialog(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text('filter ',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.1
                        ),
                      ),
                      Icon(Icons.format_align_left_rounded, color: Colors.black, size: 18)
                    ],
                  )
                )
              ],
            )
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10
              ),
              itemCount: cartList.length,
              itemBuilder: ((context, index) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(94, 215, 231, 223),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height/5,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 6, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cartList[index].p_name.toString(),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 131, 57, 234),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(cartList[index].p_details.toString(),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  cartList[index].p_category != null 
                                  ? Text(cartList[index].p_category.toString(),
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 55, 177, 161),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                      ),
                                    )
                                  : Container(),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 14,
                                      right: 10
                                    ),
                                    height: appBarHeight/1.8,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(234, 200, 181, 227),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)
                                      )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text('Avl : ',
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Text(cartList[index].p_availability.toString(),
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  bottomValue('₹ '),
                                  bottomValue(cartList[index].p_cost.toString()),
                                  const Spacer(),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        cartList.remove(cartList[index]);
                                      });
                                    },
                                    child: const Icon(Icons.delete_outline)
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Image.network(
                                cartList[index].p_img.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        cartList[index].p_quantity = cartList[index].p_quantity! + 1;
                                      });
                                    },
                                    child: const Icon(Icons.add),
                                  ),
                                  Text(cartList[index].p_quantity.toString(),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 131, 57, 234),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  if(cartList[index].p_quantity! > 0)
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          cartList[index].p_quantity = cartList[index].p_quantity! - 1;
                                        });
                                      },
                                      child: const Icon(Icons.remove),
                                    )
                                ],
                              )
                            )
                          ],
                        )
                      ),
                    ],
                  )
                );
              }),
            ),
          ),
        ]
      ),
    );
  }
}