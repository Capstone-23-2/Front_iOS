//
//  ContentView.swift
//  AltoYou
//
//  Created by 정의찬 on 10/3/23.
//

import SwiftUI
import RealityKit
import AVFoundation
import Alamofire

struct ContentView : View {
    
    var body: some View {
        ZStack{
            ARViewContainer().edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                MICButton()
                    .padding()
                    .padding(.trailing, 50)
            }
        }
    }
    
    struct ARViewContainer: UIViewRepresentable {
        
        func makeUIView(context: Context) -> ARView {
            AudioManager.shared.stopMusic()
            let arView = ARView(frame: .zero)
            
            // Create a cube model
            let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
            let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
            let model = ModelEntity(mesh: mesh, materials: [material])
            
            // Create horizontal plane anchor for the content
            let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
            anchor.children.append(model)
            
            // Add the horizontal plane anchor to the scene
            arView.scene.anchors.append(anchor)
            
            return arView
            
        }
        
        func updateUIView(_ uiView: ARView, context: Context) {}
        
        static func dismantleUIView(_ uiView: ARView, coordinator: ()) {
            AudioManager.shared.startMusic()
        }
        
    }
}

class AudioManager{
    static let shared = AudioManager()
    private var isPlayMusic = false
    
    func startMusic(){
        AltoYou.startMusic("backgroundMusic")
        isPlayMusic = true
    }
    
    func stopMusic(){
        backgroundMusicPlayer?.stop()
        isPlayMusic = false
    }
    
    func toggleMusic(){
        if isPlayMusic{
            stopMusic()
        } else{
            startMusic()
        }
    }
}

