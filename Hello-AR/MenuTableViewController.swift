//
//  MenuTableViewController.swift
//  ARKitExamples
//
//  Created by Mohammad Azam on 6/16/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class MenuTableViewController : UITableViewController {
    
    let menuItems = ["Adding Simple Box", "Displaying Text", "Adding Multiple Objects", "Touch Detection on Virtual Objects", "Detecting Planes", "Overlaying Planes","Placing Objects on Planes","Physics and Collision Detection","Applying Force","Importing SketchUp Models", "Missile Launch", "Shooting Target App", "Loading Google Blocks Models", "Measurement App", "Light"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuItemIndex = indexPath.row
        
        switch menuItemIndex {
        case 0:
            let controller = SimpleBoxViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 1:
            let controller = DisplayingTextViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 2:
            let controller = MultipleObjectsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 3:
            let controller = SimpleBoxWithTouchViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 4:
            let controller = DetectingPlanesViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 5:
            let controller = OverlayingPlanesViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 6:
            let controller = PlacingVirtualObjectsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 7:
            let controller = EnablingPhysicsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 8:
            let controller = ApplyingForcesViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 9:
            let controller = LoadingModelsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 10:
            let controller = MissleLaunchViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 11:
            let controller = TargetAppViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 12:
            let controller = GoogleBlocksViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 13:
            let controller = MeasurementViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 14:
            let controller = LightViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        default:
            let controller = SimpleBoxViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.menuItems[indexPath.row]
        return cell
    }
    
}


