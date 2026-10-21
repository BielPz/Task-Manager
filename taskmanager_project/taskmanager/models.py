from django.db import models

# Create your models here.
class TaskManager(models.Model):
    title = models.CharField(
        max_length=50,
        db_column="titulo"
    )

    completed = models.BooleanField(
        default=False,
        db_column="realizado"
    )

    user_id = models.IntegerField(
        db_column="id_Usuario"
    )

    class Meta:
        db_table = "task"
        managed = False

    def __str__(self):
        return self.title