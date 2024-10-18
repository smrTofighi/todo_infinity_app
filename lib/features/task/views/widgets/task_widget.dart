import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_infinity_app/core/styles/box_decoration.dart';
import 'package:todo_infinity_app/data/models/todo_model.dart';
import '../../../../../core/values/colors.dart';
import '../../../../../core/values/dimens.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.color, required this.onDelete, required this.onEdit,
  });

  final TodoModel todo;
  final Color color;
  final Function(BuildContext?) onDelete;
  final Function(BuildContext?) onEdit;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    //? return widget
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          //? delete task slidable action
          SlidableAction(
            onPressed: onDelete,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppDimens.radius),
              bottomRight: Radius.circular(AppDimens.radius),
            ),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),

          //? edit task slidable action
          SlidableAction(
            onPressed: onEdit,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimens.radius),
              bottomLeft: Radius.circular(AppDimens.radius),
            ),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {},
        onLongPress: () {},
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
          child: Container(
            padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
            margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
            decoration: AppBoxDecoration.taskWidgetDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //? subject of task
                Text(
                  todo.title,
                  style: TextStyle(
                    color: todo.isComplete ? Colors.grey : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    decoration:
                        todo.isComplete ? TextDecoration.lineThrough : null,
                  ),
                ),
                //? status of task
                Checkbox(
                  activeColor: color,
                  value: todo.isComplete,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ).animate(delay: const Duration(milliseconds: 250)).fade().move(),
      ),
    );
  }
}
