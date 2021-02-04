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
        
    }
    
    func uncheckedTask(taskId: Int) {
        
    }
    
    func deletedTask(taskId: Int) {
        if var task = taskProvider.allTasks.first(where: { $0.id == taskId }) {
            task.isDeleted = true
        }
        
    }
    
    // MARK: Private Methods
    private func retrieveTasks() {
        guard let view = self.view else { return }
        view.displayTasks(tasks: taskProvider.findAll())
    }
}
