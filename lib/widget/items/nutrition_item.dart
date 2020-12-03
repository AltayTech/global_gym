import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/models/nutrition.dart';
import 'package:global_gym/provider/app_theme.dart';

class NutritionItem extends StatelessWidget {
  final Nutrition nutrition;

  NutritionItem({
    this.nutrition,
  });

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppTheme.white,
            border: Border.all(width: 0.3, color: AppTheme.grey),
          ),
          height: constraints.maxHeight,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Image.network(
                    nutrition.PicPath,
                    height: 60,
                    width: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    nutrition.Name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppTheme.black,
                      fontSize: textScaleFactor * 18.0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Amount ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppTheme.black,
                        fontSize: textScaleFactor * 14.0,
                      ),
                    ),
                    Text(
                      nutrition.Quantity != 0.0 ? nutrition.Quantity.toString() : nutrition.Weight.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppTheme.black,
                        fontSize: textScaleFactor * 14.0,
                      ),
                    ),
                    Text(
                      nutrition.Quantity != 0.0 ? '' : 'g',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppTheme.black,
                        fontSize: textScaleFactor * 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
