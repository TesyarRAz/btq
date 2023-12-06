import 'package:bacaanshalat/model/menu.dart';
import 'package:bacaanshalat/network.dart';
import 'package:bacaanshalat/page/menu_page.dart';
import 'package:bacaanshalat/widget/app_bar_popup_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const route = "/";

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BTQ Mobile'),
        actions: const [
          AppBarPopupWidget(),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            menu.name ?? '',
                            style: const TextStyle(
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
