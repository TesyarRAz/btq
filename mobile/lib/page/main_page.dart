import 'package:bacaanshalat/model/menu.dart';
import 'package:bacaanshalat/network.dart';
import 'package:bacaanshalat/page/ayat_kursi_page.dart';
import 'package:bacaanshalat/page/bacaan_sholat_page.dart';
import 'package:bacaanshalat/page/menu_page.dart';
import 'package:bacaanshalat/page/niat_sholat_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _data = ValueNotifier<List<Menu>>([]);

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title: Text('BTQ Mobile'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [];
            },
            onSelected: (value) {},
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: _data,
            builder: (context, value, child) {
              return GridView.count(
                crossAxisCount: 2,
                children: value.map((menu) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuPage(
                              menu: menu,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: menu.image ?? '',
                            height: 100,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            menu.name ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _loadData() async {
    var menu = await Network.instance.getMenu();

    _data.value = menu;
  }
}
