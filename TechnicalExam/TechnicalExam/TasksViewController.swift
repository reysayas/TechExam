//
//  TasksViewController.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    var presenter: TasksViewPresenter?
    
    lazy var barBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "Add Task", style: .plain, target: self, action: #selector(addTaskTapped))
        return btn
    }()
    
    lazy var tableView:UITableView = {
        let tb = UITableView()
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         *   Finish this simple task recording app
         *   1. Make sure all defects are fixed
         *   2. Show a view (can be UIAlertController or any) that can add/edit the task.
         *   3. Show the added task in a UITableView/CollectionView
         *   4. Allow the user to toggle it as completed
         *   5. Allow the user to delete a task
         *
         **/
        
        let taskViewPresenter = TasksViewPresenter(view: self)
        self.presenter = taskViewPresenter
        
        guard let presenter = self.presenter else { return }
        setupUI()
        presenter.getAllTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc private func addTaskTapped() {
        let alert = UIAlertController(title: "Add new task", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter task name"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            guard let txtField = alert.textFields?.first else { return }
            if let name = txtField.text, !name.isEmpty, let presenter = self.presenter {
                presenter.savedTask(task: Task(id: Int.random(in: 0...1000), description: name))
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: Private functions
extension TasksViewController {
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = barBtn
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        [
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach({ $0.isActive = true })
    }
}

extension TasksViewController: TaskView {
    func displayTasks(tasks: [Task]) {
        self.tasks = tasks
        self.tableView.reloadData()
    }
    
    func addTaskToList(task: Task) {
        self.tasks.append(task)
        self.tableView.reloadData()
    }
    
    func removeTaskFromList(task: Task) {
        self.tasks.removeAll(where: { $0.id == task.id })
        self.tableView.reloadData()
    }
    
    func updateTaskInList(task: Task) {
        
    }
}

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, sucess) in
            let alert = UIAlertController(title: "Confirmation", message: "Do you want to delete this task?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: { [weak self] (action) in
                guard let `self` = self else { return }
                guard let presenter = self.presenter else { return }
                presenter.deletedTask(taskId: self.tasks[indexPath.row].id)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        let swipeAction = UISwipeActionsConfiguration(actions: [action])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
    }
}

extension TasksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = tasks[indexPath.row].description
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
}
