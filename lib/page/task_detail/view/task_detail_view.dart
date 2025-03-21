import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_itbee_solution/page/task_detail/controller/task_detail_controller.dart';
import 'package:test_itbee_solution/utils/utils.dart';

import '../../../consttants/constants.dart';
import '../../../global_widgets/text_field_custom.dart';
import '../../../repositorys/task_repository.dart';

class TaskDetailView extends StatelessWidget {
  TaskDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskDetailController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              HomeString.titleCreateTask,

              style: GoogleFonts.cairo(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            padding: ConstStyle.padding,
            child: Form(
              key: controller.taskDetailModel.formKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  TextFieldCustom(
                    label: HomeString.name,
                    controller: controller.taskDetailModel.nameController,
                  ),
                  SizedBox(height: 10),
                  TextFieldCustom(
                    label: HomeString.description,
                    controller:
                        controller.taskDetailModel.descriptionController,
                  ),
                  SizedBox(height: 10),
                  TextFieldCustom(
                    label: HomeString.duration,
                    controller: controller.taskDetailModel.dueController,

                    isShowDateTime: true,
                  ),
                  SizedBox(height: 10),
                  if (controller.isEdit.value)
                    Row(
                      children: [
                        Text("Ngày tạo: "),
                        Text(
                          Utils.convertTimestamp(
                            controller
                                    .taskDetailModel
                                    .taskModel
                                    .value
                                    .createAt ??
                                0,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  if (controller.isEdit.value)
                    if (controller.taskDetailModel.taskModel.value.updateAt !=
                            null &&
                        controller.taskDetailModel.taskModel.value.updateAt !=
                            0)
                      Row(
                        children: [
                          Text("Ngày cập nhật: "),
                          Text(
                            Utils.convertTimestamp(
                              controller
                                      .taskDetailModel
                                      .taskModel
                                      .value
                                      .updateAt ??
                                  0,
                            ),
                          ),
                        ],
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (controller.isEdit.value)
                        if (!controller.taskDetailModel.taskModel.value
                            .checkExpired())
                          GestureDetector(
                            onTap:
                                controller.taskDetailModel.taskModel.value
                                        .checkExpired()
                                    ? null
                                    : () => controller.submit(
                                      action: ActionTask.delete,
                                    ),
                            child: Container(
                              padding: ConstStyle.padding,
                              // alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: ConstColors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                HomeString.delete,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      SizedBox(width: 10),
                      if (!controller.taskDetailModel.taskModel.value
                              .checkExpired() ||
                          !controller.isEdit.value)
                        GestureDetector(
                          onTap:
                              () => controller.submit(
                                    action:
                                        controller
                                                    .taskDetailModel
                                                    .taskModel
                                                    .value
                                                    .id !=
                                                null
                                            ? ActionTask.update
                                            : ActionTask.create,
                                  ),
                          child: Container(
                            padding: ConstStyle.padding,
                            // alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              controller.taskDetailModel.taskModel.value.id !=
                                      null
                                  ? HomeString.edit
                                  : HomeString.save,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
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
