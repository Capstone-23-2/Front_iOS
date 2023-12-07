//
//  DataModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/13/23.
//

import Foundation
import UIKit

struct ResponseBeginVoice: Codable {
    var status: Bool
    var message: String
    var conversationId: String
    var url: String?
    

    enum CodingKeys: String, CodingKey {
        case status, url, message, conversationId
    }
}

struct GetVoice: Codable {
    var status: Bool
    var url: String?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case status, url, message
    }
}

struct RequestEndVoice: Encodable {
    var userId: String
    var conversation: String
}


struct ResponseEndVoice: Codable {
    var status: Int
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case status, message
    }
}
