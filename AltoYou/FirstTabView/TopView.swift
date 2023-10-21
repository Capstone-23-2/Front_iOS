//
//  TopView.swift
//  AltoYou
//
//  Created by 정의찬 on 10/6/23.
//

// KaturiOTF
// Goryeong-Strawberry

import UIKit
import SnapKit
import SceneKit

class TopView: UIView {
    
    var dayCnt: Int?
    
    ///MARk: - 구분선 만들기 위한 뷰
    private lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.58, green: 0.58, blue: 0.58, alpha: 1.00)
        return line
    }()
    
    ///MARK: - 3D 이미지 뷰
    private lazy var sceneView: SCNView = {
        let sceneView = SCNView()
        
        let scene = SCNScene(named: "toy_drummer_idle.usdz")
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 9, z: 20)
        scene?.rootNode.addChildNode(cameraNode)
        
        if let object = scene?.rootNode.childNodes.first{
            object.scale = SCNVector3(x: 1.2, y: 1.2, z: 1.2)
            
            let jumpAnimation = CAKeyframeAnimation(keyPath: "position.y")
            jumpAnimation.values = [object.position.y, object.position.y+2, object.position.y]
            jumpAnimation.keyTimes = [0, 0.5, 1]
            jumpAnimation.duration = 2
            
            let waitAnimation = CABasicAnimation(keyPath: "position.y")
            waitAnimation.fromValue = object.position.y
            waitAnimation.toValue = object.position.y
            waitAnimation.beginTime = 2
            waitAnimation.duration = 1
            
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = 3
            animationGroup.animations = [jumpAnimation, waitAnimation]
            animationGroup.repeatCount = .infinity
            object.addAnimation(animationGroup, forKey: "jumpAndWaitAnimation")
        }
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .ambient
        lightNode.light?.intensity = 1500
        lightNode.position = SCNVector3(x: 0, y: 1, z: 20)
        scene?.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .area
        ambientLightNode.light?.color = UIColor.white
        scene?.rootNode.addChildNode(ambientLightNode)
        
        
        
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.clear
        sceneView.layer.cornerRadius = 50
        sceneView.clipsToBounds = true
        sceneView.cameraControlConfiguration.allowsTranslation = false
        sceneView.scene = scene
    
        return sceneView
    }()
    
    ///MARK: - 상세 프로필 뷰(오른쪽 프로필)
    private lazy var detailProfileView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    ///MARK: - 닉네임 라벨
    private lazy var name: UILabel = {
        let label = UILabel()
        label.text = "닉네임" // 변경점
        label.font = UIFont(name: "KaturiOTF", size: 40)
        label.textColor = UIColor.black
        return label
    }()
    
    ///MARK: - 로그아웃 버튼
    private lazy var logoutBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그아웃", for: .normal)
        btn.titleLabel?.font = UIFont(name: "KaturiOTF", size: 22)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor(red: 0.95, green: 0.62, blue: 0.02, alpha: 1.00)
        btn.layer.cornerRadius = 12
   //     btn.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        return btn
    }()
    
    ///MARK: - 출석 체크 텍스트
    private lazy var attendanceCheckTitle: UILabel = {
        let title = UILabel()
        title.text = "출석 체크"
        title.font = UIFont(name: "KaturiOTF", size: 35)
        return title
    }()
    
    ///MARK: - 출석 체크 컬렉션 뷰
    private lazy var attendanceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.layer.backgroundColor = UIColor.clear.cgColor
        cv.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    //MARK: - init
    required init?(coder: NSCoder){
        fatalError("error")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSelf()
        makeSuperSubViewConstraints()
        makeDetailProfileViewConstraints()
    }
    //MARK: - Function
    
    ///MARK: - self 설정
    private func setSelf(){
        self.backgroundColor = UIColor(red: 0.50, green: 0.91, blue: 1.00, alpha: 1.00)
        self.layer.cornerRadius = 50
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        self.layer.shadowColor = UIColor(red: 0.48, green: 0.87, blue: 0.96, alpha: 1.00).cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 2, height: 12)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = nil
    }
    
    ///MARK: - 서브 뷰 두개 배치(3D오브젝트 뷰, 프로파일 뷰)
    private func makeSuperSubViewConstraints(){
        [sceneView, detailProfileView].forEach{ self.addSubview($0) }
        
        sceneView.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(63)
            make.left.equalToSuperview().offset(74)
            make.height.width.lessThanOrEqualTo(280)
        }
        
        detailProfileView.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(70)
            make.left.equalTo(sceneView.snp.right).offset(162)
            make.bottom.equalToSuperview().offset(-45)
            make.right.greaterThanOrEqualToSuperview().offset(-53)
            
        }
    }
    ///MARK: - 프로파일 내부 뷰
    private func makeDetailProfileViewConstraints(){
        [name, logoutBtn,lineView, attendanceCheckTitle, attendanceCollectionView ].forEach{ detailProfileView.addSubview($0) }
    
        name.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(45)
            make.left.equalToSuperview().offset(34)
            make.height.lessThanOrEqualTo(100)
        }
        logoutBtn.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(45)
            make.right.equalToSuperview().offset(-54)
            make.width.greaterThanOrEqualTo(106)
            make.bottom.equalTo(lineView.snp.top).offset(-15)
        }
        lineView.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(29)
            make.right.equalToSuperview().offset(-49)
            make.height.equalTo(1)
        }
        attendanceCheckTitle.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(34)
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.width.greaterThanOrEqualTo(142)
        }
        
        attendanceCollectionView.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(29)
            make.top.equalTo(attendanceCheckTitle.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.greaterThanOrEqualTo(500)
        }
        
    }
}

//MARK: - Extension
extension TopView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellInfor.DayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
        cell.configuration(cellInfor.DayList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 55)
    }
    // 간격 보고 코드 추가할 예정
}
