//
//  EntryDetailViewController.swift
//  JournalCK
//
//  Created by Maxwell Poffenbarger on 2/4/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    //MARK: - Properties
    var entry: Entry?{
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text,
            !title.isEmpty,
            !bodyTextView.text.isEmpty else { return }
        EntryController.sharedInstance.addEntryWith(title: title, body: bodyTextView.text) { (true) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func mainViewTapped(_ sender: Any) {
        bodyTextView.resignFirstResponder()
        titleTextField.resignFirstResponder()
    }
    
    //MARK: - Private Methods
    func updateViews(){
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
}//End of class

//MARK: - Extension
extension EntryDetailViewController: UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
