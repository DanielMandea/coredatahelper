//
//  UserTableViewCell.swift
//  CoreDataHelper
//
//  Created by DanielMandea on 3/16/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

protocol UserCellProtocol {
  /// The name of the user
  var userName: String? { get set }
  /// The age of the user
  var userAge: NSNumber? { get set }
}

class UserTableViewCell: UITableViewCell, UserCellProtocol {
  
  // MARK: - UserCellProtocol
  
  /// The age of the user
  internal var userAge: NSNumber? {
    didSet {
      self.detailTextLabel?.text = userAge?.stringValue
    }
  }
  
  /// The name of the user
  internal var userName: String? {
    didSet {
      self.textLabel?.text = userName
    }
  }
  
  // MARK: - Override
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
