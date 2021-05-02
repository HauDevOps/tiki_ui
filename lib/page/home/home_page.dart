import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tiki_challenge/bloc/base_bloc.dart';
import 'package:tiki_challenge/model/banner_model.dart';
import 'package:tiki_challenge/model/box.dart';
import 'package:tiki_challenge/model/deal_hot_model.dart';
import 'package:tiki_challenge/model/quick_link_model.dart';
import 'package:tiki_challenge/page/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<HomeBloc>(context);
    bloc.getQuickLink();
    bloc.getBanner();
    bloc.getDealHot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: CustomScrollView(
        slivers: [
          _appBarWidget(),
          SliverFixedExtentList(
            itemExtent: 140,
            delegate: SliverChildListDelegate([_bannerWidget(bloc)]),
          ),
          SliverFixedExtentList(
            itemExtent: 250,
            delegate: SliverChildListDelegate([_dealHotWidget(bloc)]),
          ),
          SliverFixedExtentList(
            itemExtent: 250,
            delegate: SliverChildListDelegate([_quickLinkWidget(bloc)]),
          ),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  color: Colors.redAccent[(index % 9) * 100],
                );
              }),
              itemExtent: 56)
        ],
      ),
    );
  }

  Widget _appBarWidget() {
    return SliverAppBar(
      title: Text("TIKI"),
      centerTitle: true,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications_none_outlined),
              onPressed: () {},
            ),
            Positioned(
                top: 8,
                right: 8,
                child: Container(
                    width: 16,
                    height: 16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepOrangeAccent),
                    child: Text(""))),
          ],
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {},
            ),
            Positioned(
                top: 8,
                right: 8,
                child: Container(
                    width: 16,
                    height: 16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepOrangeAccent),
                    child: Text(""))),
          ],
        ),
      ],
      expandedHeight: 120,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(9),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.search_rounded),
                  onPressed: () {},
                ),
                Text(
                  'Bạn tìm gì hôm nay?',
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bannerWidget(HomeBloc bloc) {
    return StreamBuilder(
      stream: bloc.bannerStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<BannerData>> snapShot) {
        if (!snapShot.hasData) {
          return Center(
            child: Text('Data not found'),
          );
        }
        return CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 1)),
          items: snapShot.data.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: AspectRatio(
                            aspectRatio: 3.1,
                            child: Image.network(
                              i.imageUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 5,
                        //   left: 0,
                        //   right: 0,
                        //   child: Container(
                        //     height: 20,
                        //     color: Colors.black.withOpacity(0.5),
                        //     child: Row(
                        //       children: [
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _quickLinkWidget(HomeBloc bloc) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      color: Colors.white,
      child: StreamBuilder(
        stream: bloc.quickLinkStream,
        builder: (BuildContext context, AsyncSnapshot<QuickLink> snapShot) {
          if (!snapShot.hasData) {
            return Center(
              child: Text('Data not found'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: snapShot.data.data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 110,
                  width: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapShot.data.data[index].length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: const EdgeInsets.all(7),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              height: 80,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  snapShot.data.data[index][i].imageUrl,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                snapShot.data.data[index][i].title,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _dealHotWidget(HomeBloc bloc){
    return Box(
      title: Text('Giá Sốc Hôm Nay'),
      action: TextButton(onPressed: (){}, child: TweenAnimationBuilder<Duration>(
        duration: Duration(minutes: 60),
        tween: Tween(begin: Duration(minutes: 120), end: Duration.zero),
        onEnd: () {},
        builder: (BuildContext context, Duration value, Widget child) {
          final minutes = value.inMinutes % 60;
          final seconds = value.inSeconds % 60;
          final hour = value.inHours % 24;
          return Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Text(
                    "$hour",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                        backgroundColor: Colors.red),
                  )),
              Text(" : "),
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Text(
                    "$minutes",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                        backgroundColor: Colors.red),
                  )),
              Text(" : "),
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Text(
                    "$seconds",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                        backgroundColor: Colors.red),
                  )),
            ],
          );
        },
      ),),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: StreamBuilder(
            stream: bloc.dealHotStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Data>> snapShot) {
              if (!snapShot.hasData) {
                return Center(
                  child: Text('Data not found'),
                );
              }
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(5),
                  itemCount: snapShot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              snapShot.data[index].product.thumbnailUrl,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            snapShot.data[index].product.price.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Text(
                              'Đã bán ' +
                                  snapShot.data[index].progress.qtyOrdered
                                      .toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  backgroundColor: Colors.red[600]),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }


}
