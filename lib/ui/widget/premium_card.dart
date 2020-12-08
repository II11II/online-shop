import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/model/get_category_model.dart';
import 'package:online_shop/ui/page/home_page/home_cubit.dart';
import 'package:online_shop/ui/style/style.dart';

class PremiumCard extends StatelessWidget {
  final Object category;
  final Function onPressed;

  const PremiumCard(
      {Key key, this.onPressed, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 100,
          width: 351,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.black38, BlendMode.darken),
                  image: NetworkImage(
                    "${category.imageCategory}",
                  ),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(left: 22, top: 37, bottom: 12),
            child: Text(
              '${category.name}',
              style: TextStyle(shadows: [BoxShadow(color: Colors.black)]),
            ),
          ),
        ),
      ),
    );
  }
}
