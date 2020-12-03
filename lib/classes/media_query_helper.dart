
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

getHalfHeight(BuildContext context) => getHeight(context) / 2;
getHalfWidth(BuildContext context) => getWidth(context) / 2;

getPercentsOfHeight(BuildContext context, double percent) =>
    _getPercentOf(getHeight(context), percent);
getHeightBasedOnWidthAndAspectRatio(BuildContext context, double percentOfHeight, double percentOfWidth) => (percentOfHeight /100) * getPercentsOfWidth(context, percentOfWidth) / (getWidth(context)/getHeight(context));
getWidthBasedOnHeightAndAspectRatio(BuildContext context, double percentOfWidth, double percentOfHeight) => (percentOfWidth /100) * getPercentsOfHeight(context, percentOfHeight) * (getHeight(context)/getWidth(context));
getAspectRatio(BuildContext context) => (getHeight(context)/getWidth(context));



getPercentsOfWidth(BuildContext context, double percent) =>
    _getPercentOf(getWidth(context), percent);

getWidth(BuildContext context) => MediaQuery.of(context).size.width;
getHeight(BuildContext context) => MediaQuery.of(context).size.height;
getTextScaleFactor(BuildContext context) => MediaQuery.of(context).textScaleFactor;
getSafeAreaHeight(BuildContext context) => getHeight(context) - MediaQuery.of(context).padding.top;
getBodyHeight(BuildContext context) => getHeight(context) - MediaQuery.of(context).padding.top - kToolbarHeight;

double _getPercentOf(double number, double percent) {
  _checkPercentIsValid(percent);
  return number * (percent / 100);
}

void _checkPercentIsValid(double percent) {
  assert(percent < 100 && percent > 0, "Percent should be between 0 and 100");
}
