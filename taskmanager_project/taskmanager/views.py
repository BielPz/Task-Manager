from django.shortcuts import render, redirect, get_object_or_404
from .models import TaskManager


# Funcionalidade do sistema
def todo_list(request):

    # ID fixo apenas para teste.
    id_usuario = 1

    todos = TaskManager.objects.filter(
        user_id=id_usuario
    ).order_by("id")

    if request.method == "POST":

        # CREATE: adicionar tarefa
        if "add_task" in request.POST:
            title = request.POST.get("title", "").strip()

            if title and len(title) <= 50:
                TaskManager.objects.create(
                    title=title,
                    user_id=id_usuario
                )

            return redirect("todo_list")

        # UPDATE: editar tarefa
        if "edit_task" in request.POST:
            task_id = request.POST.get("task_id")
            new_title = request.POST.get(
                "new_title", ""
            ).strip()

            if new_title and len(new_title) <= 50:
                todo = get_object_or_404(
                    TaskManager,
                    id=task_id,
                    user_id=id_usuario
                )

                todo.title = new_title
                todo.save(update_fields=["title"])

            return redirect("todo_list")

        # UPDATE: alternar o status da tarefa
        if "toggle_task" in request.POST:
            task_id = request.POST.get("task_id")

            todo = get_object_or_404(
                TaskManager,
                id=task_id,
                user_id=id_usuario
            )

            todo.completed = not todo.completed
            todo.save(update_fields=["completed"])

            return redirect("todo_list")


        # DELETE: excluir uma tarefa
        if "delete_task" in request.POST:
            task_id = request.POST.get("task_id")

            todo = get_object_or_404(
                TaskManager,
                id=task_id,
                user_id=id_usuario
            )

            todo.delete()

            return redirect("todo_list")

        # DELETE: limpar tarefas do usuário
        if "clear_all" in request.POST:
            todos.delete()
            return redirect("todo_list")

    return render(
        request,
        "todo/list.html",
        {
            "todos": todos,
            "task_count": todos.count()
        }
    )