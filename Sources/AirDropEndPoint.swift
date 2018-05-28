//
//  AirDropBuilder.swift
//  ostkit
//
//  Created by Duong Khong on 5/16/18.
//  Copyright © 2018 Duong Khong. All rights reserved.
//

import Foundation
import Alamofire

/// Airdrop endpoint definitions.
internal enum AirdropEndPoint: EndPoint {
    
    case execute(amount: Float, airdropped: Bool, user_ids: String)
    
    case retrieve(id: String)
    
    case list(
        page_no: Int, airdropped: Bool, order_by: String?,
        order: String?, limit: Int, optional_filters: String?
    )
    
    var method: EndPointMethod {
        switch self {
        case .execute:
            return .post
            
        case .retrieve, .list:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .execute, .list:
            return "/airdrops"
            
        case .retrieve(let id):
            return "/airdrops/\(id)"
        }
    }
    
    var params: [String: Any] {
        var params: [String: Any] = [:]
        switch self {
            
        case .execute(let amount, let airdropped, let user_ids):
            params["amount"] = amount
            params["airdropped"] = airdropped
            params["user_ids"] = user_ids
        
        case .list(
            let page_no, let airdropped, let order_by,
            let order, let limit, let optional_filters):
            
            params["page_no"] = page_no
            params["airdropped"] = airdropped
            params["limit"] = limit
            
            if let optional_filters = optional_filters {
                params["optional_filters"] = optional_filters
            }
            
            if let order_by = order_by {
                params["order_by"] = order_by
            }
            
            if let order = order {
                params["order"] = order
            }
            
        default:
            break
        }
        
        return params
    }
}
