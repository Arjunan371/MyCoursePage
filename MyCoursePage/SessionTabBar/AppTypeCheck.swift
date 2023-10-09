//
//  ActivityViewController.swift
//  MyCoursePage
//
//  Created by Arjunan on 04/10/23.
//

import UIKit


struct AppTypeCheck {
    static func checkBasicType<T>(type: T.Type, givenObj: BasicType?) -> T {
       
        if T.self == Int.self {
            let quantity: T
            switch givenObj {
                case .integer(let x):
                    quantity = x as! T
                case .string(let x):
                    quantity = (Int(x) ?? 0) as! T
                case .double(let x):
                    quantity = (Int(x) ) as! T
                case .long(let x):
                    quantity = (Int(x) ) as! T
                case .none:
                    quantity = 0 as! T
            }
            return quantity
        } else if T.self == Double.self {
            let quantity: T
            switch givenObj {
                case .integer(let x):
                    quantity = Double(x) as! T
                case .string(let x):
                    quantity = (x as NSString).doubleValue as! T
                case .double(let x):
                    quantity = x as! T
                case .long(let x):
                quantity = Double(x) as! T
                case .none:
                    quantity = 0.0 as! T
            }
            return quantity
        } else if T.self == Int64.self {
            let quantity: T
            switch givenObj {
                case .integer(let x):
                    quantity = Int64(x) as! T
                case .string(let x):
                    quantity = (Int64(x) ?? 0) as! T
                case .double(let x):
                    quantity = Int64(x) as! T
                case .long(let x):
                    quantity = x as! T
                case .none:
                    quantity = 0 as! T
            }
            return quantity
        }  else {
            let quantity: T
            switch givenObj {
                case .integer(let x):
                    quantity = String(x) as! T
                case .string(let x):
                    quantity = x as! T
                case .double(let x):
                    quantity = String(x) as! T
                case .long(let x):
                    quantity = String(x) as! T
                case .none:
                    quantity = String() as! T
            }
            return quantity
        }

    }
}
