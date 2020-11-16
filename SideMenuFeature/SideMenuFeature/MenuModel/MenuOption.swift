//
//  MenuOption.swift
//  SideMenuFeature
//
//  Created by Joseph Veverka on 11/16/20.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Profile
    case Discover
    case Post
    
    var description: String {
        switch self {
        case .Discover: return "Discover"
        case .Post: return "Post"
        case .Profile: return "Profile"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Profile: return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .Post: return UIImage(named: "plus.square.fill.on.square.fill") ?? UIImage()
        case .Discover: return UIImage(named: "magnifyingglass") ?? UIImage()
        }
    }
}
