import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/features/main/main_report/view_model/main_report_view_model.dart';
import 'package:todo_infinity_app/features/main/main_report/views/widgets/category_chart_item.dart';

class CategoryChartList extends StatelessWidget {
  CategoryChartList({super.key});
  final MainReportViewModel reportVM = Get.find<MainReportViewModel>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.sizeOfDevice(context).width,
      child: GetBuilder<MainReportViewModel>(
        builder: (_) =>  ListView.builder(
          itemBuilder: (context, index) => CategoryChartItem(
              title: reportVM.model.categoryList[index].title,
              color: colorList[reportVM.model.categoryList[index].colorIndex]),
          itemCount: reportVM.model.categoryList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
