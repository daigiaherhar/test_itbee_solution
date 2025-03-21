import 'package:flutter/material.dart';
import 'package:test_itbee_solution/consttants/const_colors.dart';

import '../models/task_model.dart';

class CheckBoxWidget extends StatefulWidget {
  CheckBoxWidget({
    super.key,
    required this.onCheck,
    required this.taskModel,
    this.isOnTap = true,
  });

  // final bool isCheck; // 0 incomplete, 1 complete
  final Function(TaskModel) onCheck; // 0 incomplete, 1 complete
  final TaskModel taskModel;
  final bool isOnTap;

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isCheck = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  handleCheck() {
    setState(() {
      isCheck = !isCheck;
      TaskModel dataChange = widget.taskModel;
      dataChange.status = dataChange.intCheck(isCheck);
      widget.onCheck(dataChange);
    });
  }

  @override
  Widget build(BuildContext context) {
    isCheck = widget.taskModel.isCheck();
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.isOnTap ? () => handleCheck() : null,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: Colors.transparent),
        ),
        height: width * 0.05,
        width: width * 0.05,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: ConstColors.grey_2.withValues(alpha: 0.3),
            shape: BoxShape.rectangle,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            switchInCurve: Curves.easeInOutSine,
            switchOutCurve: Curves.easeOutBack,
            child:
                isCheck
                    ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      key: Key('active'),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [ConstColors.orange, ConstColors.orange],
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      child: Icon(Icons.check),
                    )
                    : Container(
                      key: Key('disable'),
                      decoration: BoxDecoration(
                        color: ConstColors.white,
                        shape: BoxShape.rectangle,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
