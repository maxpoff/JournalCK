//
//  Entry.swift
//  JournalCK
//
//  Created by Maxwell Poffenbarger on 2/4/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

import Foundation
import CloudKit

struct EntryConstants {
    static let TitleKey = "title"
    static let BodyKey = "body"
    static let TimestampKey = "timestamp"
    static let RecordType = "Entry"
}

class Entry {
    
    var title: String
    var body: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryConstants.TitleKey] as? String,
        let body = ckRecord[EntryConstants.BodyKey] as? String,
        let timestamp = ckRecord[EntryConstants.TimestampKey] as? Date else {return nil}
        
        self.init(title: title, body: body, timestamp: timestamp, ckRecordID: ckRecord.recordID)
    }
    
}//End of class

extension CKRecord {
    
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.RecordType, recordID: entry.ckRecordID)
        self.setValue(entry.title, forKey: EntryConstants.TitleKey)
        self.setValue(entry.body, forKey: EntryConstants.BodyKey)
        self.setValue(entry.timestamp, forKey: EntryConstants.TimestampKey)
    }
}//End of extension
