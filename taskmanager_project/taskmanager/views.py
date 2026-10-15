from django.shortcuts import render, redirect, get_object_or_404
from .models import TaskManager

# Create your views here.
def todo_list(request):
    todos = TaskManager.objects.all()

    if request.method == "POST":

        # Adicionar Task
        if "add_task" in request.POST:
            title = request.POST.get("title")
            if title:
                TaskManager.objects.create(title=title)
            return redirect("todo_list")

        # Editar Task
        if "edit_task" in request.POST:
            task_id = request.POST.get("task_id")
            new_title = request.POST.get("new_title")
            todo = get_object_or_404(TaskManager, id=task_id)
            todo.title = new_title
            todo.save()
            return redirect("todo_list")

        # Delete Task
        if "delete_task" in request.POST:
            task_id = request.POST.get("task_id")
            todo = get_object_or_404(TaskManager, id=task_id)
            todo.delete()
            return redirect("todo_list")

        # Clear All
        if "clear_all" in request.POST:
            TaskManager.objects.all().delete()
            return redirect("todo_list")

    return render(request, "todo/list.html", {
        "todos": todos,
        "task_count": todos.count()
    })