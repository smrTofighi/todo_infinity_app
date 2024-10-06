import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/box_decoration.dart';
import 'package:todo_infinity_app/data/models/todo_model.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/values/dimens.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({super.key, required this.todo,});

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {

    //? return widget
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          //? delete task slidable action
          SlidableAction(
            onPressed: (context) {},
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
            onPressed: (context) {},
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimens.radius),
              bottomLeft: Radius.circular(AppDimens.radius),
            ),
            backgroundColor: LightColors.primary,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //? dueDate of task
              Center(
                child: Text(
                 '',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4, 0, 12, 0),
                margin:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                height: 45,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.55,
                decoration: AppBoxDecoration.taskWidgetDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //? subject of task
                    Text(
                     todo.title,
                      style: const TextStyle(fontSize: 13),
                    ),
                    //? status of task
                    Checkbox(
                      value: todo.isComplete,
                      onChanged: (value) {},
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
