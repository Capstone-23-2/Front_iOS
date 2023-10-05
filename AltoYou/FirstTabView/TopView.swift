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
    
    ///MARK: - 닉네임 포함 스택 뷰
    private lazy var nameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    ///MARK: - 출석체크 포함 스택 뷰
    private lazy var attendStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    ///MARK: - 3D 이미지 뷰
    private lazy var sceneView: SCNView = {
        let sceneView = SCNView()
        
        let scene = SCNScene(named: "toy_drummer_idle.usdz")
        
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
        
        sceneView.layer.cornerRadius = 14
        sceneView.layer.masksToBounds = true
        sceneView.layer.borderColor = UIColor.black.cgColor // 색 다시 지정 필요
        sceneView.layer.borderWidth = 1
        
        return sceneView
    }()
    
    ///MARK: - 상세 프로필 뷰(오른쪽 프로필)
    private lazy var detailProfileView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        // 색 변경 필요
        // 그림자 효과 추가
        return view
    }()
    
    ///MARK: - 닉네임 라벨
    private lazy var name: UILabel = {
        let label = UILabel()
        label.text = "닉네임" // 변경점
        label.font = UIFont(name: "Katuri.otf", size: 20)
        label.textColor = UIColor.blue //색 변경 필요
        return label
    }()
    
    ///MARK: - 로그아웃 버튼
    private lazy var logoutBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그아웃", for: .normal)
        btn.titleLabel?.font = UIFont(name: "goryeong.otf", size: 12)
        btn.setTitleColor(UIColor.black, for: .normal) // 색상 변경 필요
        btn.backgroundColor = UIColor.systemBlue // 색상 변경 필요
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    ///MARK: - 출석 체크 텍스트
    private lazy var attendanceCheckTitle: UILabel = {
        let title = UILabel()
        title.text = "출석 체크"
        title.font = UIFont(name: "goryeong.otf", size: 14)
        return title
    }()
    
    ///MARK: - 총 출석일 수 텍스트
    private lazy var attendanceDayTitle: UILabel = {
        let title = UILabel()
        title.text = "출석 일수"
        title.font = UIFont(name: "goryeong.otf", size: 14)
        return title
    }()
    
    private lazy var attendanceCollectionView: UICollectionView = {
        //let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = .horizontal
        let cv = UICollectionView()
        
        return cv
    }()
    //MARK: - init
    required init?(coder: NSCoder){
        fatalError("error")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

}
