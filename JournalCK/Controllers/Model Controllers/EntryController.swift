//
//  EntryController.swift
//  JournalCK
//
//  Created by Maxwell Poffenbarger on 2/4/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    //MARK: - Properties
    let privateDB = CKContainer.default().privateCloudDatabase
    
    static let sharedInstance = EntryController()
    
    var entries: [Entry] = []
    
    //MARK: - CRUD Functions
    func save(entry: Entry, completion: @escaping (Bool) -> Void) {
        
        let record = CKRecord(entry: entry)
        
        privateDB.save(record) { (record, error) in
            
            if let error = error {
                print(error, error.localizedDescription)
                return completion(false)
            }
            
            guard let record = record,
                let entry = Entry(ckRecord: record) else { return completion(false)}
            self.entries.append(entry)
            completion(true)
        }
    }
    
    func addEntryWith(title: String, body: String, completion: @escaping (Bool) -> Void) {
        
        let entry = Entry(title: title, body: body)
        
        save(entry: entry, completion: completion)
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void) {
        
        let queryAllPredicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: EntryConstants.RecordType, predicate: queryAllPredicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print(error, error.localizedDescription)
                return completion(false)
            }
            
            guard let records = records else {return completion(false)}
            
            let entries: [Entry] = records.compactMap({Entry(ckRecord: $0)})
            self.entries = entries
            completion(true)
        }
    }
}//End of class
