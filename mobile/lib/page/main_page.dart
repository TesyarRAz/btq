import 'package:bacaanshalat/model/menu.dart';
import 'package:bacaanshalat/network.dart';
import 'package:bacaanshalat/page/favorite_page.dart';
import 'package:bacaanshalat/page/menu_page.dart';
import 'package:bacaanshalat/provider/user_model.dart';
import 'package:bacaanshalat/widget/app_bar_popup_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var userModel = Provider.of<UserModel>(context);

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
              if (!userModel.isLoggedIn) {
                value = value.where((element) => element.name?.toLowerCase() != 'favorite').toList();
              }
              return GridView.count(
                crossAxisCount: 2,
                children: value.map((menu) {
                  if (menu.name?.toLowerCase() == 'favorite') {
                    return _buildFavoriteWidget(menu);
                  }
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

  Widget _buildFavoriteWidget(Menu menu) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoritePage(
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
  }

  Future<void> _loadData() async {
    var menus = await Network.instance.getMenu();

    _data.value = menus;
  }
}
