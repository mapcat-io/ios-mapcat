//
//  CustomCell.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/16/16.
//  Copyright © 2016 Mapcat. All rights reserved.
//

import UIKit
import Eureka

open class CustomCell<T: Equatable> : Cell<T>, CellType {
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
<<<<<<< HEAD
=======
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
>>>>>>> e4d4c712428b856818be62af2f255797a4053edd
    lazy open var trueImage: UIImage = {
        return UIImage(named: "check_mark")!
    }()
    
    lazy open var falseImage: UIImage = {
        return UIImage(named: "check_mark_nil")!
    }()
    
    open override func update() {
        super.update()
        accessoryType = .none
        imageView?.image = row.value != nil ? trueImage : falseImage
    }
    
    open override func setup() {
        super.setup()
    }
    
    open override func didSelect() {
        row.reload()
        row.select()
        row.deselect()
    }
    
}
