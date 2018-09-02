//
//  ViewController.swift
//  Menu Card
//
//  Created by Paramesh V on 29/08/18.
//  Copyright © 2018 Paramesh V. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import WebKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate, UIWebViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARImageTrackingConfiguration()
    let augmentedRealitySession = ARSession()
    
    var targetAnchor: ARImageAnchor?
//    var cake_1_PlaneNode: SCNNode?
    var cake_1_PlaneNode : SCNNode? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.autoenablesDefaultLighting = true
        let ARScene = SCNScene()
        sceneView.scene = ARScene
        
    }//viewdidload
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       setupARSession()
        
    }//viewWillAppear
    
    func setupARSession(){
        
        //1. Setup Our Tracking Images
        guard let trackingImages =  ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        configuration.trackingImages = trackingImages
        configuration.maximumNumberOfTrackedImages = 1
        
        //2. Configure & Run Our ARSession
        sceneView.session = augmentedRealitySession
        augmentedRealitySession.delegate = self
        sceneView.delegate = self
        augmentedRealitySession.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }//setupARSession
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let anchorNode = SCNNode()
        anchorNode.name = "anchor"
        sceneView.scene.rootNode.addChildNode(anchorNode)
        return anchorNode
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let imageAnchor = anchor as? ARImageAnchor else {return}
        if let imageName  = imageAnchor.referenceImage.name {
            
            print(imageName)
            
            if imageName == "menu"{
                
                let rotationAsRadian = CGFloat(GLKMathDegreesToRadians(360))

                // Check To See The Detected Size Of Our menu Card (Should By 5cm*3cm)
                let menuCardWidth = imageAnchor.referenceImage.physicalSize.width
                let menuCardHeight =  imageAnchor.referenceImage.physicalSize.height
                
//                let menucardx = imageAnchor.referenceImage.physicalSize.
                
                print(
                    """
                    We Have Detected menu Card With Name \(imageName)
                    \(imageName)'s Width Is \(menuCardWidth)
                    \(imageName)'s Height Is \(menuCardHeight)
                    """)
                
                let plane = SCNPlane(width: menuCardWidth, height: menuCardHeight)
                plane.firstMaterial?.diffuse.contents = UIColor.black.withAlphaComponent(0)

                let planeNodee = SCNNode(geometry: plane)
                planeNodee.eulerAngles.x = -.pi / 2
                planeNodee.runAction(SCNAction.moveBy(x:  0.21, y: 0, z: 0, duration: 0))
                

                //raspberry
                //cake 1
                
              
                
                
                    let cake_1_Plane = SCNPlane(width: 0.045, height: 0.045)
                    cake_1_Plane.firstMaterial?.diffuse.contents = UIImage(named: "france")
                    cake_1_Plane.cornerRadius = 0.01
                    
                    let cake_1_PlaneNode = SCNNode(geometry: cake_1_Plane)
                    self.cake_1_PlaneNode = cake_1_PlaneNode
                    
                    cake_1_PlaneNode.eulerAngles.x = -.pi/2
                    cake_1_PlaneNode.position = SCNVector3(0.15, 0, -0.12)
                    cake_1_PlaneNode.name = "yummyCake"
                    cake_1_PlaneNode.runAction(SCNAction.rotateBy(x: 0, y: 0, z: rotationAsRadian, duration: 0.75))
             
                    
                        let cakeStar_1_Plane = SCNPlane(width: 0.09, height: 0.018)
                        cakeStar_1_Plane.firstMaterial?.diffuse.contents = UIImage(named: "cake_star_1")
                        
                        
                        let cakeStar_1_PlaneNode = SCNNode(geometry: cakeStar_1_Plane)
                        cakeStar_1_PlaneNode.eulerAngles.x = -.pi/2
                        cakeStar_1_PlaneNode.position = SCNVector3(0.05, 0, -0.07)

                        cakeStar_1_PlaneNode.runAction(SCNAction.moveBy(x: 0.102, y: 0, z: 0, duration: 1.5))

                        node.addChildNode(cakeStar_1_PlaneNode)

                    
                    
                    
                


                //Dessert cake
                //cake2
                let cake_2_Plane = SCNPlane(width: 0.045, height: 0.045)
                cake_2_Plane.firstMaterial?.diffuse.contents = UIImage(named: "Dessert_cakes")
                cake_2_Plane.cornerRadius = 0.01
                
                let cake_2_PlaneNode = SCNNode(geometry: cake_2_Plane)
                cake_2_PlaneNode.eulerAngles.x = -.pi/2
                cake_2_PlaneNode.position = SCNVector3(0.15, 0, -0.02)

                
                UIView.animate(withDuration: 0, animations: {
                    cake_2_PlaneNode.runAction(SCNAction.rotateBy(x: 0, y: 0, z: rotationAsRadian, duration: 0.75))
                }) { (success) in
                    
                    if success {
                
                let cakeStar_2_Plane = SCNPlane(width: 0.1, height: 0.018)
                cakeStar_2_Plane.firstMaterial?.diffuse.contents = UIImage(named: "cake_star_2")
                
                let cakeStar_2_PlaneNode = SCNNode(geometry: cakeStar_2_Plane)
                cakeStar_2_PlaneNode.eulerAngles.x = -.pi/2
                cakeStar_2_PlaneNode.position = SCNVector3(0.05, 0, 0.03)
                cakeStar_2_PlaneNode.runAction(SCNAction.moveBy(x: 0.102, y: 0, z: 0, duration: 1.5))
                node.addChildNode(cakeStar_2_PlaneNode)

                    }
                    
                }
                
                //Chocolate
                //cake3
                let cake_3_Plane = SCNPlane(width: 0.045, height: 0.045)
                cake_3_Plane.firstMaterial?.diffuse.contents = UIImage(named: "Chocolate")
                cake_3_Plane.cornerRadius = 0.01
                
                let cake_3_PlaneNode = SCNNode(geometry: cake_3_Plane)
                cake_3_PlaneNode.eulerAngles.x = -.pi/2
                cake_3_PlaneNode.position = SCNVector3(0.15, 0, 0.08)
                
                UIView.animate(withDuration: 0, animations: {
                    cake_3_PlaneNode.runAction(SCNAction.rotateBy(x: 0, y: 0, z: rotationAsRadian, duration: 0.75))
                }) { (success) in
                    
                    if success {
                
                let cakeStar_3_Plane = SCNPlane(width: 0.09, height: 0.018)
                cakeStar_3_Plane.firstMaterial?.diffuse.contents = UIImage(named: "cake_star_3")
                let cakeStar_3_PlaneNode = SCNNode(geometry: cakeStar_3_Plane)
                cakeStar_3_PlaneNode.eulerAngles.x = -.pi/2
                
                cakeStar_3_PlaneNode.position = SCNVector3(0.05, 0, 0.125)
                cakeStar_3_PlaneNode.runAction(SCNAction.moveBy(x: 0.1, y: 0, z: 0, duration: 1.5))
                node.addChildNode(cakeStar_3_PlaneNode)

                    }
                    
                }
                
         
                cake_1()
                //plane
                node.addChildNode(planeNodee)
                //cake1
                node.addChildNode(cake_1_PlaneNode)
                //cake2
                node.addChildNode(cake_2_PlaneNode)
                //cake3
                node.addChildNode(cake_3_PlaneNode)
                
                self.sceneView.scene.rootNode.addChildNode(node)
                
            } else if imageName == "Brochure_Front" {
                
                guard let currentFrame = self.sceneView.session.currentFrame else {
                    return
                }

                // Check To See The Detected Size Of Our menu Card (Should By 5cm*3cm)
                let B_FrontWidth = imageAnchor.referenceImage.physicalSize.width
                let B_BackHeight =  imageAnchor.referenceImage.physicalSize.height
                
                print(
                    """
                    We Have Detected menu Card With Name \(imageName)
                    \(imageName)'s Width Is \(B_FrontWidth)
                    \(imageName)'s Height Is \(B_BackHeight)
                    """)
                
                
                DispatchQueue.main.async {
                    
//                    let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
//                    let request = URLRequest(url: URL(string: "http://www.czsm.co.in")!)
//
//                    webView.load(request)

            
                    let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 554, height: 800))
                    let request = URLRequest(url: URL(string: "http://www.czsm.co.in")!)

                    webView.delegate = self
                    webView.allowsInlineMediaPlayback = true
                    webView.allowsPictureInPictureMediaPlayback = true
                    webView.loadRequest(request)
                    
                    let tvPlane = SCNPlane(width: B_FrontWidth, height: B_BackHeight)
                    tvPlane.firstMaterial?.diffuse.contents = webView
                    tvPlane.firstMaterial?.isDoubleSided = true
                    
                    let tvPlaneNode = SCNNode(geometry: tvPlane)
                    tvPlaneNode.eulerAngles.x = -.pi/2
                    tvPlaneNode.position = SCNVector3(0.145, 0, 0.0)
                    
                    
                    
                    //video
                    
//                    let videoNode = SKVideoNode(fileNamed: "ARNAV.mp4")
//                    videoNode.play()
//
//                    let skScene = SKScene(size: CGSize(width: 375, height: 220))
//                    skScene.addChild(videoNode)
//
//                    videoNode.position = CGPoint(x: skScene.size.width/2, y: skScene.size.height/2)
//                    videoNode.size = skScene.size
//
//                    let tvPlanevideo = SCNPlane(width: 0.08, height: 0.05)
//                    tvPlanevideo.firstMaterial?.diffuse.contents = skScene
//                    tvPlanevideo.firstMaterial?.isDoubleSided = true
//
//                    let tvPlanevideoNode = SCNNode(geometry: tvPlanevideo)
//                    tvPlanevideoNode.eulerAngles.x = -.pi/2
//                    tvPlanevideoNode.position = SCNVector3(-0.05, 0, 0.0)
                    
                    
                    let videoHolder = SCNNode()
                    let videoHolderGeometry = SCNPlane(width: 0.05, height: 0.08)
                    videoHolder.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
                    videoHolder.geometry = videoHolderGeometry
//
                    //4. Create Our Video Player
//                    let videoURL = Bundle.main.path(forResource: "ARNAV", withExtension: "mp4")
                    guard let path = Bundle.main.path(forResource: "ARNAV", ofType:"mp4") else {
                        debugPrint("video.m4v not found")
                        return
                    }
                   
                    print("videoURL::\(String(describing: path))")
                    self.setupVideoOnNode(videoHolder, fromURL: URL(fileURLWithPath: path))
                    

              

                    node.addChildNode(tvPlaneNode)
//                    node.addChildNode(tvPlanevideoNode)
                    node.addChildNode(videoHolder)
                    self.sceneView.scene.rootNode.addChildNode(node)
                }

                
            } else if imageName == "Brochure_Back" {
                
                
                
            }
            
            
        }

    }//renderer
    
    
    /// Creates A Video Player As An SCNGeometries Diffuse Contents
    ///
    /// - Parameters:
    ///   - node: SCNNode
    ///   - url: URL
    func setupVideoOnNode(_ node: SCNNode, fromURL url: URL){
        
        //1. Create An SKVideoNode
        var videoPlayerNode: SKVideoNode!
        
        //2. Create An AVPlayer With Our Video URL
        let videoPlayer = AVPlayer(url: url)
        
        //3. Intialize The Video Node With Our Video Player
        videoPlayerNode = SKVideoNode(avPlayer: videoPlayer)
        videoPlayerNode.yScale = -1
        
        //4. Create A SpriteKitScene & Postion It
        let spriteKitScene = SKScene(size: CGSize(width: 375, height: 220))
        spriteKitScene.scaleMode = .aspectFit
        videoPlayerNode.position = CGPoint(x: spriteKitScene.size.width/2, y: spriteKitScene.size.height/2)
        videoPlayerNode.size = spriteKitScene.size
        spriteKitScene.addChild(videoPlayerNode)
        
        //6. Set The Nodes Geoemtry Diffuse Contenets To Our SpriteKit Scene
        node.geometry?.firstMaterial?.diffuse.contents = spriteKitScene
        
        //5. Play The Video
        videoPlayerNode.play()
        
        videoPlayer.volume = 0
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first as! UITouch
        if(touch.view == self.sceneView){
            //            print("touch working")
            let viewTouchLocation:CGPoint = touch.location(in: sceneView)
            guard let result = sceneView.hitTest(viewTouchLocation, options: nil).first else {
                return
            }

            if let planeNode = result.node as SCNNode?, planeNode.name == "yummyCake" {


                print("I'm gonna eat you!")
         


            }
        }
    }
    

    func cake_1() {
        
        let plane = SCNPlane(width: 3.5  , height: 3.5)
        plane.firstMaterial?.diffuse.contents = UIColor.black.withAlphaComponent(1.0)
        let planeNodee = SCNNode(geometry: plane)
        planeNodee.eulerAngles.x = -.pi/2
        planeNodee.position = SCNVector3(0, 0, 0)
        //        planeNodee.runAction(SCNAction.moveBy(x: 0, y: 0, z: 0, duration: 0))
        self.sceneView.scene.rootNode.addChildNode(planeNodee)
        
    }//cake_1
    
    
}//class



