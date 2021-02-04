//
//  TaskPresenter.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation

class TasksViewPresenter : TaskPresenter{
    
    let taskProvider = TaskLocalServiceProvider()
    
    var view:TaskView?
    
    required init(view: TaskView) {
        self.view = view
    }
    
    func getAllTasks() {
        retrieveTasks()
    }
    
    func taskClicked() {
        
    }
    
    func savedTask(task: Task) {
        guard let view = self.view else { return }
        taskProvider.save(task: task)
        view.addTaskToList(task: task)
    }
    
    func checkedTask(taskId: Int) {
        guard let view = self.view else { return }
        guard var task = taskProvider.allTasks.first(where: { $0.id == taskId }) else { return }
        task.completed = true
        taskProvider.update(task: task)
        view.updateTaskInList(task: task)
    }
    
    func uncheckedTask(taskId: Int) {
        guard let view = self.view else { return }
        guard var task = taskProvider.allTasks.first(where: { $0.id == taskId }) else { return }
        task.completed = false
        taskProvider.update(task: task)
        view.updateTaskInList(task: task)
    }
    
    func deletedTask(taskId: Int) {
        guard let view = self.view else { return }
        guard let task = taskProvider.allTasks.first(where: { $0.id == taskId }) else { return }
        taskProvider.delete(taskId: taskId)
        view.removeTaskFromList(task: task)
    }
    
    // MARK: Private Methods
    private func retrieveTasks() {
        guard let view = self.view else { return }
        view.displayTasks(tasks: taskProvider.findAll())
    }
}
