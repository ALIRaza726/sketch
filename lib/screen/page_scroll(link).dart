import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketch/models/cart.dart';
import 'package:sketch/screen/cart.dart';

class PageScroll extends StatefulWidget {
  static const routeName = '/ScrolLinked';
  const PageScroll({super.key});

  @override
  State<PageScroll> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<PageScroll> {
  List<List<int>> countsList = List.generate(8, (index) => List.filled(10, 0));
  int count = 1;
  int selectedIndex = 0;
  int? singleItemIndex;
  int? singleCartIndex;

  final List<Map<String, dynamic>> menuItems = [
    {'image': 'assets/images/fast-food.png', "text": 'Fast-Food'},
    {'image': 'assets/images/mobile.png', "text": 'Mobile'},
    {'image': 'assets/images/clothes.png', "text": 'Clothes'},
    {'image': 'assets/images/laptop.png', "text": 'Laptop'},
    {'image': 'assets/images/starter.png', "text": 'STARTER'},
    {'image': 'assets/images/dessert.png', "text": 'DESSERT'},
    {'image': 'assets/images/beverages.png', "text": 'BEVERAGES'},
  ];
  final List<Map<String, dynamic>> items = [
    {'image': 'assets/images/fast-food.png', "text": 'Fast-Food', "Price": '8'},
    {'image': 'assets/images/mobile.png', "text": 'Mobile', "Price": '100'},
    {'image': 'assets/images/clothes.png', "text": 'Clothes', "Price": '50'},
    {'image': 'assets/images/laptop.png', "text": 'Laptop', "Price": '700'},
    {'image': 'assets/images/starter.png', "text": 'STARTER', "Price": '8'},
    {'image': 'assets/images/dessert.png', "text": 'DESSERT', "Price": '90'},
    {'image': 'assets/images/beverages.png', "text": 'BEVERAGES', "Price": '6'},
  ];
  final List<String> cartItem = [
    'Fast-Food',
    'Mobile',
    'Clothes',
    'Laptop',
    'STARTER',
    'DESSERT',
    'BEVERAGES'
  ];
  List<List<Map<String, dynamic>>> itemsList = [];
  List<ScrollController> itemControllers = [];
  List<List<Map<String, dynamic>>> items_point = [];

  // bool isEnable = false;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    itemsList = List.generate(menuItems.length, (index) => menuItems);
    items_point = List.generate(items.length, (index) => items);
    // itemControllers =
    //     List.generate(menuItems.length, (index) => ScrollController());
    selectedIndex = 0; // Set the first index as the default selected index
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 114, 174, 215),
          title: const Text(
            'Shop Here',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Consumer<CartModel>(
              builder: (context, cart, child) {
                return Stack(
                  children: [
                    IconButton(
                      color: Color.fromARGB(255, 242, 242, 246),
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        if (cart.items.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Cart is empty')),
                          );
                        }
                      },
                    ),
                    if (cart.items.isNotEmpty)
                      Positioned(
                        right: 17.5,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '${cart.items.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          ],
        ),
        // backgroundColor: Colors.black,
        backgroundColor: Color.fromARGB(255, 209, 247, 159),
        // appBar: AppBar(
        //   // backgroundColor: const Color(0xff26272C),
        //   backgroundColor: Colors.blueGrey.shade800,
        //   // foregroundColor: Colors.transparent,
        //   automaticallyImplyLeading: true,
        //   leading: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'KDS',
        //         style: GoogleFonts.getFont('Poppins',
        //             color: Colors.white, fontSize: 22),
        //       ),
        //     ],
        //   ),
        //   // leadingWidth: 65,
        //   // title: Padding(
        //   //   padding: const EdgeInsets.only(left: 120.0),
        //   //   child: Container(
        //   //     decoration: BoxDecoration(
        //   //       borderRadius: BorderRadius.circular(20),
        //   //       color: Colors.white,
        //   //     ),
        //   //     width: 150,
        //   //     height: 35,
        //   //     child: Center(
        //   //       child: TextField(
        //   //         style: GoogleFonts.getFont(
        //   //           'Poppins',
        //   //           color: Colors.black,
        //   //         ),
        //   //         //textAlign: TextAlign.center,
        //   //         decoration: const InputDecoration(
        //   //           border: InputBorder.none,
        //   //           hintText: 'Search',
        //   //           hintStyle: TextStyle(color: Colors.black, fontSize: 14),
        //   //           prefixIcon: Icon(
        //   //             Icons.search,
        //   //             color: Colors.black,
        //   //           ),
        //   //         ),
        //   //       ),
        //   //     ),
        //   //   ),
        //   // ),
        //   actions: [
        //     Stack(
        //       children: [
        //         IconButton(
        //             onPressed: () {
        //               Navigator.pushNamed(context, AddToCart.routeName);
        //             },
        //             icon: const Icon(Icons.shopping_cart)),
        //         Padding(
        //           padding: const EdgeInsets.only(left: 25, bottom: 10),
        //           child: Badge(
        //             backgroundColor: Colors.green,
        //             label: Text('0',
        //                 style: GoogleFonts.getFont('Poppins', fontSize: 10)),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),

        body: Row(
          children: [
            Container(
              width: 100,
              // color: const Color.fromARGB(255, 156, 150, 150),
              color: Color.fromARGB(255, 186, 219, 142),
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      print(
                          "row index:  ${controller.position.maxScrollExtent.toString()}");
                      controller.animateToPage(index,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.bounceOut);
                      // controller.animateTo(controller.position.maxScrollExtent*double.parse('0.$index'), duration: const Duration(milliseconds: 500), curve: Curves.linearToEaseOut);

                      // itemControllers[index].animateTo(itemControllers[index].position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          ClipOval(
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: index == selectedIndex
                                    ? Colors.black.withOpacity(0.3)
                                    : Colors.transparent,
                              ),
                              child: Transform.scale(
                                scale: 0.6,
                                child: Image.asset(
                                  menuItems[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            menuItems[index]['text'],
                            // style: GoogleFonts.getFont(
                            // 'Poppins',
                            // color: Colors.white,
                          ),
                          //  ),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: menuItems.length,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, itemIndex) {
                      bool isSelected = singleItemIndex == itemIndex &&
                          singleCartIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              // If already selected, toggle visibility
                              singleItemIndex = null;
                              singleCartIndex = null;
                            } else {
                              // Otherwise, select the item
                              singleItemIndex = itemIndex;
                              singleCartIndex = index;
                            }
                          });
                        },
                        child: SizedBox(
                          // color: Colors.amber,
                          height: 300,
                          child: Stack(
                            children: [
                              Image.asset(
                                items[index]['image'],
                                width: 350,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      items[index]['text'],
                                      // style: GoogleFonts.getFont(
                                      // 'Poppins',
                                      // color: Colors.white,
                                    ),
                                    // ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          '\$',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 20),
                                          // style: GoogleFonts.getFont(
                                          //   'Poppins',
                                          //   color: Colors.white.withOpacity(0.7),
                                          //   fontSize: 16,
                                        ),
                                        Text(
                                          items[index]['text'],
                                          // style: GoogleFonts.getFont(
                                          // 'Poppins',
                                          // color: Colors.white,
                                        ),
                                      ],
                                    ),

                                    //  ),
                                  ],
                                ),
                              ),
                              if (isSelected ||
                                  countsList[index][itemIndex] > 0)
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      stops: const [0.01, 0.6],
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.8),
                                        Colors.transparent
                                      ],
                                    ),
                                  ),
                                ),
                              if (isSelected ||
                                  countsList[index][itemIndex] > 0)
                                Positioned(
                                  bottom: 10,
                                  left: 25,
                                  right: 25,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          setState(() {
                                            if (countsList[index][itemIndex] >
                                                0) {
                                              countsList[index][itemIndex]--;
                                            }
                                          });
                                        },
                                        color: Colors.white,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            countsList[index][itemIndex]
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        color: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            countsList[index][itemIndex]++;
                                          });
                                          Provider.of<CartModel>(context,
                                                  listen: false)
                                              .addItem(cartItem[index]);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    '${cartItem[index]} added to cart')),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
