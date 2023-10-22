import 'package:caisseapp/utils/constants.dart';
import 'package:caisseapp/utils/global_methods.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

late PageController pageController;

int _page = 0;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = GlobalMethodes.getScreenSize(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: navWidget,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: const Color(0xfff4e4ff),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    navigationTapped(0);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: _page == 0 ? 64 : 48,
                    height: _page == 0 ? 64 : 48,
                    curve: Curves.easeInOut,
                    child: Image.asset(
                      _page == 0
                          ? 'assets/icons/receive.png'
                          : 'assets/icons/breceive.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.fill,
                    ),
                  )),
              InkWell(
                  onTap: () {
                    navigationTapped(1);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: _page == 1 ? 64 : 48,
                    height: _page == 1 ? 64 : 48,
                    curve: Curves.easeInOut,
                    child: Image.asset(
                      _page == 1
                          ? 'assets/icons/stats.png'
                          : 'assets/icons/bstats.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.fill,
                    ),
                  )),
              InkWell(
                  onTap: () {
                    navigationTapped(2);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: _page == 2 ? 64 : 48,
                    height: _page == 2 ? 64 : 48,
                    curve: Curves.easeInOut,
                    child: Image.asset(
                      _page == 2
                          ? 'assets/icons/paid.png'
                          : 'assets/icons/bpaid.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.fill,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
