//
//  CustomCell.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/16/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import Eureka

public class CustomCell<T: Equatable> : Cell<T>, CellType {
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    lazy public var trueImage: UIImage = {
        return UIImage(named: "check_mark")!
    }()
    
    lazy public var falseImage: UIImage = {
        return UIImage(named: "check_mark_nil")!
    }()
    
    public override func update() {
        super.update()
        accessoryType = .None
        imageView?.image = row.value != nil ? trueImage : falseImage
    }
    
    public override func setup() {
        super.setup()
    }
    
    public override func didSelect() {
        row.reload()
        row.select()
        row.deselect()
    }
    
}

public final class CustomRow<T: Equatable>: Row<T, CustomCell<T>>, SelectableRowType, RowType {
    public var selectableValue: T?
    required public init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = nil
    }
}
