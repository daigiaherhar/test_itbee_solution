import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:test_itbee_solution/models/task_model.dart';
import 'package:test_itbee_solution/page/home/controller/home_controller.dart';

import '../../../consttants/constants.dart';
import '../../../dialogs/index.dart';
import '../../../global_widgets/check_box_widget.dart';
import '../../../global_widgets/draggable_fab_widget.dart';
import '../../../utils/utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(
              HomeString.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              GestureDetector(
                onTap: () => controller.handleCreateTask(),
                child: Padding(
                  padding: ConstStyle.paddingHorizontal,
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: ConstStyle.paddingHorizontal,
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.homeModel.listTask.length,
                itemBuilder: (context, index) {
                  TaskModel data = controller.homeModel.listTask[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: ConstStyle.paddingVertical,
                      padding: ConstStyle.padding,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                            color: ConstColors.grey_3.withValues(alpha: .3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            data.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(data.description),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  Utils.convertTimestamp(data.dueDate),
                                  style: TextStyle(
                                    color: ConstColors.grey,
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              CheckBoxWidget(
                                taskModel: data,
                                onCheck: controller.handleCheck,
                              ),

                              // Text(data.status),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          floatingActionButton: SafeArea(
            child: DraggableFab(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton.small(
                    // backgroundColor: ConstColors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),

                    onPressed: null,
                    child: PopupMenuButton(
                      icon: Icon(Icons.filter_alt_sharp),
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              child: Text("Tất cả"),
                              onTap: () => controller.filterTask(type: 0),
                            ),
                            PopupMenuItem(
                              child: Text("Chưa hoàn thành"),
                              onTap: () => controller.filterTask(type: 1),
                            ),
                          ],
                    ),
                  ),
                  SizedBox(height: 5),
                  FloatingActionButton.small(
                    // backgroundColor: ConstColors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    onPressed: () => controller.themeController.toggleTheme(),
                    child: Icon(Icons.dark_mode_outlined),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
