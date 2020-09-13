//
//  Reusable.swift
//  Diabetes
//
//  Created by Кирилл Худяков on 11.08.2020.
//

import UIKit


public protocol Reusable: class {
    static var identifier: String { get }
}

public extension Reusable where Self: UIView {
    
    public static var identifier: String {
        return String(describing: self)
    }
    
}
