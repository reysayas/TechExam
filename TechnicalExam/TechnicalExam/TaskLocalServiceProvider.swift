//
//  TaskLocalServiceProvider.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation

class TaskLocalServiceProvider : TaskLocalService {
    
    let defaults = UserDefaults.standard
    let taskKey = "Tasks"
    var allTasks = [Task]()
    init() {
        if let objects = defaults.value(forKey: taskKey) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Task] {
                allTasks = objectsDecoded
            }
        }
    }
    
    func save(task: Task) {
        allTasks.append(task)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allTasks){
            UserDefaults.standard.set(encoded, forKey: taskKey)
        }
    }
    
    func delete(taskId:Int) {
        let tasks = allTasks.filter({ $0.id == taskId })
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: taskKey)
        }
    }
    
    func update(task:Task) {
        guard let idx = allTasks.firstIndex(where: { $0.id == task.id }) else { return }
        allTasks.remove(at: idx)
        save(task: task)
    }
    
    func findAll() -> [Task] {
        if let objects = defaults.value(forKey: taskKey) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Task] {
                allTasks = objectsDecoded
            }
        }
        return allTasks
        
    }
    
}
