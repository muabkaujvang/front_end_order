import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    CarouselController _controller = CarouselController();
    int activeIndex = 0;
    int categorySelected = 0;
    List<String> imgList = [
      'assets/image/1.jfif',
      'assets/image/pep.jpg',
      'assets/image/pepsi.jpg',
      'assets/image/ps.jpg',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.black38,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String value) {
              print(value);
            },
            itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'Option 1',
                  child: Text('setting'),
                  
                ),
                const  PopupMenuItem(
                  value: 'Option 2',
                  child: Text('logout'),
                ),
                const PopupMenuItem(
                  value: 'Option 3',
                  child: Text('help'),
                ),
              ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  carouselController: _controller,
                  items: imgList
                      .map(
                        (e) => Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: AssetImage(e),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    viewportFraction: 1,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reson) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () {
                          _controller.animateToPage(entry.key);
                          setState(() {
                            activeIndex = entry.key;
                          });
                        },
                        child: Container(
                          width: activeIndex == entry.key ? 20 : 10.0,
                          height: 10,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: activeIndex == entry.key
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/image/1.jfif',
                                    width: 40,
                                    height: 20,
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 8),
                                const Text(
                                  'Category',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Products',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 24,
                            color: Colors.black87,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        height: 280,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/image/1.jfif',
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Product Title 1',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                                child: const Row(
                              children: [
                                const Text(
                                  '⭐⭐⭐⭐⭐',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('15,000 kip')
                              ],
                            )),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        height: 280,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/image/pepsi.jpg',
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Product Title 2',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                                child: const Row(
                              children: [
                                const Text(
                                  '⭐⭐⭐⭐⭐',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('15,000 kip')
                              ],
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
