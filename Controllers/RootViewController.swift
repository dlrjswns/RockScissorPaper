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
    
    private lazy var statusLabel:UILabel={
        //승리, 실패, 비김 상태표시용 라벨
        let label = UILabel()
        label.text = "날 클릭해봐 !!"
        label.font = UIFont(name: "GillSans-UltraBold", size: 30)
       
        return label
    }()
    
    private lazy var animationView:AnimationView={
        let av = AnimationView(name: "70289-baby")
        av.contentMode = .scaleAspectFit
        av.loopMode = .loop
        av.play()
        av.backgroundColor = .systemPink
        av.layer.cornerRadius = 100
        av.widthAnchor.constraint(equalToConstant: 200).isActive = true
        av.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(animationVWTapped))
//        av.isUserInteractionEnabled = true
//        av.addGestureRecognizer(tap)
        return av
    }()
    
    private lazy var computer:UIImageView={
       let imgView = UIImageView()
        imgView.backgroundColor = .systemOrange
        imgView.contentMode = .scaleAspectFit
        imgView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
        
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
    @objc func animationVWTapped(){
        print("animationtapped()")
    }
    
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
            if whatResult(myHand: myHand, computerHand: computerHand) == .WIN{
                statusLabel.text = "WINNER"
            }else if whatResult(myHand: myHand, computerHand: computerHand) == .LOSE{
                statusLabel.text = "LOSER"
            }else{
                statusLabel.text = "DRAW"
            }
        case 1:
            myHand = Hand.Scissor
            animationView.isHidden = true
            self.computer.image = UIImage(named: computer)
            if whatResult(myHand: myHand, computerHand: computerHand) == .WIN{
                statusLabel.text = "WINNER"
            }else if whatResult(myHand: myHand, computerHand: computerHand) == .LOSE{
                statusLabel.text = "LOSER"
            }else{
                statusLabel.text = "DRAW"
            }
        case 2:
            myHand = Hand.Paper
            animationView.isHidden = true
            self.computer.image = UIImage(named: computer)
            if whatResult(myHand: myHand, computerHand: computerHand) == .WIN{
                statusLabel.text = "WINNER"
            }else if whatResult(myHand: myHand, computerHand: computerHand) == .LOSE{
                statusLabel.text = "LOSER"
            }else{
                statusLabel.text = "DRAW"
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
    
    func whatResult(myHand:Hand, computerHand:Hand)->Result{ //결과를 반환하기위한 함수
        switch myHand {
        case .Rock:
            if computerHand == .Scissor {
                return .WIN
            }else if computerHand == .Rock{
                return .DRAW
            }else{ //컴퓨터가 가위일때
                return .LOSE
            }
            
        case .Scissor:
            if computerHand == .Paper {
                return .WIN
            }else if computerHand == .Scissor{
                return .DRAW
            }else{ //컴퓨터가 주먹일때
                return .LOSE
            }
            
        case .Paper:
            if computerHand == .Rock {
                return .WIN
            }else if computerHand == .Paper{
                return .DRAW
            }else{ //컴퓨터가 보자기일때
                return .LOSE
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
        
        view.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    }
}
