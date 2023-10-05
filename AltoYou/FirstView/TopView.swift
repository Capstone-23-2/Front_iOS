//
//  TopView.swift
//  AltoYou
//
//  Created by 정의찬 on 10/6/23.
//

import UIKit
import SnapKit
import SceneKit

class TopView: UIView {

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    private lazy var sceneView: SCNView = {
        let sceneView = SCNView()
        
        let scene = SCNScene(named: "ss") // obj file
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 10, z: 35)
        scene?.rootNode.addChildNode(cameraNode)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 0, z: 35)
        scene?.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.white
        scene?.rootNode.addChildNode(ambientLightNode)
        
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.white
        sceneView.cameraControlConfiguration.allowsTranslation = false
        sceneView.scene = scene
        
        return sceneView
    }()
    private lazy var detailProfileView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        // 색 변경 필요
        // 그림자 효과 추가
        return view
    }()
    private lazy var name: UILabel = {
        let label = UILabel()
        label.text = "닉네임" // 변경점
        label.font = UIFont(name: "Katuri.otf", size: 20)
        label.textColor = UIColor.blue //색 변경 필요
        return label
    }()
    private lazy var logoutBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그아웃", for: .normal)
        btn.titleLabel?.font = UIFont(name: "goryeong.otf", size: 16)
        btn.setTitleColor(UIColor.black, for: .normal) // 색상 변경 필요
        btn.backgroundColor = UIColor.systemBlue // 색상 변경 필요
        return btn
    }()
    
    
    
    //MARK: - init
    required init?(coder: NSCoder){
        fatalError("error")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

}
