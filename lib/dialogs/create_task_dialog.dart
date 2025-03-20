import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_itbee_solution/consttants/const_colors.dart';
import 'package:test_itbee_solution/models/task_model.dart';

import '../consttants/constants.dart';
import '../global_widgets/text_field_custom.dart';

Future createTaskDialog() {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dueController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  save() {
    if (formKey.currentState!.validate()) {
      // convert "dd-MM-yyyy HH:mm" -> "yyyy-MM-dd HH:mm"
      DateTime dateTime = DateTime.parse(
        "${dueController.text.split(' ')[0].split('-').reversed.join('-')}T${dueController.text.split(' ')[1]}:00",
      );
      Navigator.pop(
        Get.context!,
        TaskModel(
          title: nameController.text,
          description: descriptionController.text,
          dueDate: dateTime.microsecondsSinceEpoch,
          createAt: DateTime.now().microsecondsSinceEpoch
        ),
      );
    }
  }

  return Get.generalDialog(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: kToolbarHeight,
          horizontal: 12,
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Scaffold(
            // insetPadding: EdgeInsets.all(kToolbarHeight),
            // borderRadius: BorderRadius.all(Radius.circular(20)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            // extendBodyBehindAppBar: true,
            appBar: AppBar(
              // foregroundColor: Colors.black,
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
                key: formKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFieldCustom(
                      label: HomeString.name,
                      controller: nameController,
                    ),
                    SizedBox(height: 10),
                    TextFieldCustom(
                      label: HomeString.description,
                      controller: descriptionController,
                    ),
                    SizedBox(height: 10),
                    TextFieldCustom(
                      label: HomeString.duration,
                      controller: dueController,
                      isShowDateTime: true,
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => save(),
                        child: Container(
                          padding: ConstStyle.padding,
                          // alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Text(
                            HomeString.save,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(
          begin: Offset(1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child: child,
      );
    },
    barrierLabel: "createTaskDialog",
    barrierDismissible: true,
  );
}
