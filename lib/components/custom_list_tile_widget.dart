import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.itemList,
  });
  final Map itemList;

  @override
  Widget build(BuildContext context) {
    int hora = int.parse(itemList['date'].toString().substring(11, 13));
    final int minuto = int.parse(itemList['date'].toString().substring(14, 16));
    String lapso = 'am';
    if (hora > 12) {
      hora -= 12;
      lapso = 'pm';
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemList['city'],
                  style: const TextStyle(fontSize: 18),
                ),
                Text(itemList['description']),
              ],
            ),
          ),
          Container(
            width: 90,
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Color(0xFFC9E5FF),
            ),
            child: Column(
              children: [
                if(itemList['temperature'] > 25)
                Image.asset(
                  'assets/images/sol.png',
                  height: 50,
                ),
                if(itemList['temperature'] < 25)
                  Image.asset(
                    'assets/images/nublado.png',
                    height: 50,
                  ),
                Text('$hora:$minuto $lapso')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
