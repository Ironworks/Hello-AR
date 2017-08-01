//
//  ViewController.swift
//  Hello-AR
//
//  Created by Mohammad Azam on 6/18/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class DominoViewController: UIViewController, ARSCNViewDelegate {
    
    var sceneView: ARSCNView!
    var planes = [OverlayPlane]()
    var dominos = [SCNNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(self.sceneView)
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        sceneView.scene = scene
        
        registerGestureRecognizers()
    }
    
    private func registerGestureRecognizers() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        let doubleTappedGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTappedGestureRecognizer.numberOfTapsRequired = 2
        
        tapGestureRecognizer.require(toFail: doubleTappedGestureRecognizer)
        
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        self.sceneView.addGestureRecognizer(doubleTappedGestureRecognizer)
    }
    
    @objc func doubleTapped(recognizer :UIGestureRecognizer) {
        
        let sceneView = recognizer.view as! ARSCNView
        let touch = recognizer.location(in: sceneView)
        
        let hitResults = sceneView.hitTest(touch, options: [:])
        
        if !hitResults.isEmpty {
            
            // make all nodes dynamic
            for n in self.dominos {
                n.physicsBody = SCNPhysicsBody.dynamic()
            }
            
            guard let hitResult = hitResults.first else {
                return
            }
            
            let node = hitResult.node
           // node.physicsBody = SCNPhysicsBody.dynamic()
            node.physicsBody?.applyForce(SCNVector3(0, 0.5, hitResult.worldCoordinates.z * Float(-2.0)), asImpulse: true)
        }
        
        let configuration = self.sceneView.session.configuration as! ARWorldTrackingSessionConfiguration
        
        configuration.planeDetection = []
        self.sceneView.session.run(configuration, options: [])
        
        // turn off the grid
        for plane in self.planes {
            plane.planeGeometry.materials.forEach { material in
                material.diffuse.contents = UIColor.clear
            }
        }
        
    }
    
    @objc func tapped(recognizer :UIGestureRecognizer) {
        
        let sceneView = recognizer.view as! ARSCNView
        let touch = recognizer.location(in: sceneView)
        
        let hitResults = sceneView.hitTest(touch, types: .existingPlaneUsingExtent)
        
        if !hitResults.isEmpty {
            
            guard let hitResult = hitResults.first else {
                return
            }
            
            addBox(hitResult :hitResult)
        }
        
    }
    
    private func addBox(hitResult :ARHitTestResult) {
        
        let offsetY = 0.1
        
        let box = SCNBox(width: 0.1, height: 0.2, length: 0.05, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/_6.jpg")
        
        let node = SCNNode()
        node.name = "BOX"
        node.geometry = box
        node.geometry?.materials = [material]
        node.physicsBody?.categoryBitMask = BodyType.box.rawValue
        node.physicsBody?.mass = 1.0
        
        node.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y + Float(offsetY) , hitResult.worldTransform.columns.3.z)
        
        self.dominos.append(node)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if !(anchor is ARPlaneAnchor) {
            return
        }
        
        let plane = OverlayPlane(anchor: anchor as! ARPlaneAnchor)
        self.planes.append(plane)
        node.addChildNode(plane)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        let plane = self.planes.filter { plane in
            return plane.anchor.identifier == anchor.identifier
            }.first
        
        if plane == nil {
            return
        }
        
        plane?.update(anchor: anchor as! ARPlaneAnchor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
}



