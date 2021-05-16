//
//  ApplicationModel.swift
//  Social App
//
//  Created by Ryan Koo on 2/17/21.
//

import SwiftUI

struct ApplicationModel : Identifiable {
    var id: String
    var applicantID: String
    var recipientID: String
    var applicantUserName: String
    var applicationMessage: String
    var postID: String
    var applicantPhoto: String
    var positionApplied: String
}
