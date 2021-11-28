//
//  RootViewController.swift
//  RockScissorPaper
//
//  Created by 이건준 on 2021/11/28.
//

import UIKit
import Lottie

class RootViewController:UIViewController{
    let image = ["rock.jpeg", "scissor.png", "paper.png"]
    
    private lazy var animationView:AnimationView={
        let av = AnimationView(name: "70289-baby")
        av.contentMode = .scaleAspectFit
        av.loopMode = .loop
        av.play()
        av.backgroundColor = .systemPink
        av.layer.cornerRadius = 100
        return av
    }()
    
    private lazy var computer:UIImageView={
       let imgView = UIImageView()
        imgView.backgroundColor = .systemOrange
        imgView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return imgView
    }()
    
    private lazy var rockButton:UIButton={
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "rock.jpeg"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(rockScissorPaperTapped), for: UIControl.Event.touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.tag = 0
        return btn
    }()
    
    private lazy var scissorButton:UIButton={
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "scissor.png"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(rockScissorPaperTapped), for: UIControl.Event.touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.tag = 1
        return btn
    }()
    
    private lazy var paperButton:UIButton={
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "paper.png"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(rockScissorPaperTapped), for: UIControl.Event.touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.tag = 2
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        
        }
    
    //MARK: -Objc
    @objc func rockScissorPaperTapped(_ sender:UIButton){
       //UIButton의 tag번호를 whoWin()의 인자로 넘겨주어 승리했는지 실패했는지 반환받아 라벨에 띄어주자
        let tag = sender.tag
        let myHand:Hand
        let computer = image.shuffled()[0]
        let computerHand:Hand = whatComputerHand(computerHand: computer)
        switch tag {
        case 0:
            myHand = Hand.Rock
            animationView.isHidden = true
            self.computer.image = UIImage(named: computer)
            if isMyWin(myHand: myHand, computerHand: computerHand){
                //내가 승리했다면 어떻게 할것인지
                print("나의 승리")
            }
        case 1:
            myHand = Hand.Scissor
            animationView.isHidden = true
            self.computer.image = UIImage(named: computer)
            if isMyWin(myHand: myHand, computerHand: computerHand){
                print("나의 승리")
            }
        case 2:
            myHand = Hand.Paper
            animationView.isHidden = true
            self.computer.image = UIImage(named: computer)
            if isMyWin(myHand: myHand, computerHand: computerHand){
                print("나의 승리")
            }
        default:
            print("rockScissorPaperTapped() Error")
        }
//        whoWin(myHand)
    }
    
    func whatComputerHand(computerHand:String)->Hand{
        switch computerHand {
        case "rock.jpeg":
            return .Rock
        case "scissor.png":
            return .Scissor
        case "paper.png":
            return .Paper
        default:
            return .Rock
        }
    }
    
    func isMyWin(myHand:Hand, computerHand:Hand)->Bool{
        switch myHand {
        case .Rock:
            if computerHand == .Scissor {
                return true
            }else{
                return false
            }
            
        case .Scissor:
            if computerHand == .Paper {
                return true
            }else{
                return false
            }
        case .Paper:
            if computerHand == .Rock {
                return true
            }else{
                return false
            }
        }
    }
    //MARK: -Configure
    func configure(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(rockButton)
        rockButton.translatesAutoresizingMaskIntoConstraints = false
        rockButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width/3/2-20).isActive = true
        rockButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        view.addSubview(scissorButton)
        scissorButton.translatesAutoresizingMaskIntoConstraints = false
        scissorButton.centerYAnchor.constraint(equalTo: self.rockButton.centerYAnchor).isActive = true
        scissorButton.leftAnchor.constraint(equalTo: self.rockButton.rightAnchor, constant: view.frame.width/3/2).isActive = true
        
        view.addSubview(paperButton)
        paperButton.translatesAutoresizingMaskIntoConstraints = false
        paperButton.centerYAnchor.constraint(equalTo: self.scissorButton.centerYAnchor).isActive = true
        paperButton.leftAnchor.constraint(equalTo: self.scissorButton.rightAnchor, constant: view.frame.width/3/2).isActive = true
        
        view.addSubview(computer)
        computer.translatesAutoresizingMaskIntoConstraints = false
        computer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        computer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
