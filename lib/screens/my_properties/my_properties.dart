import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class MyProperties extends StatefulWidget {
  const MyProperties({super.key});

  @override
  State<MyProperties> createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {
  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          body: CustomScrollView(slivers: [
            const SliverAppBar(
              backgroundColor: Colors.deepPurple,
              centerTitle: true,
              toolbarHeight: 80,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
              ),
              floating: false,
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "My Properties",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TabBar(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 0,
                      ),
                      isScrollable: true,
                      labelColor: Colors.deepPurple,
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelColor: Colors.grey,
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                      indicatorColor: appbarColor,
                      tabs: const [
                        Tab(
                          text: "Pending",
                        ),
                        Tab(
                          text: "Posted",
                        ),
                        Tab(
                          text: "Closed",
                        ),
                        Tab(
                          text: "Canceled",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 700,
                      child: TabBarView(
                        children: [
                          TabViewWidget(),
                          TabViewWidget(),
                          TabViewWidget(),
                          TabViewWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}

class TabViewWidget extends StatelessWidget {
  const TabViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    width: 150,
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black45,
                            blurRadius: 5,
                            offset: Offset(0, 3)),
                        BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                        BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                      ],
                      image: const DecorationImage(
                          image: AssetImage("assets/house1.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Category: Real estate",
                          style: TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Area: 1000sq ft.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "For: Rent",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Price: Birr 20,000",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Status: FInished",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Location: Bahirdar",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
