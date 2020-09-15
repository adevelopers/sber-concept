//
//  TextField.swift
//  SberbankConcept
//
//  Created by Kirill Khudiakov on 15.09.2020.
//  Copyright © 2020 Худяков Кирилл. All rights reserved.
//

import UIKit


class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    
}

