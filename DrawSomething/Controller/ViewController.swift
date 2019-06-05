//
//  ViewController.swift
//  DrawSomething
//
//  Created by Wilfred Furthado M on 21/03/19.
//  Copyright © 2019 Pervacio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let canvas = Canvas()
    
    let undoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.lightGray
        button.setTitle("UNDO", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo() {
        canvas.undo()
    }
    
    let clearButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.lightGray
        button.setTitle("CLEAR", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()

    @objc fileprivate func handleClear() {
        canvas.clear()
    }
    
    let yellowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.yellow
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let redButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()

    let blueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleColorChange(button: UIButton) {
        canvas.setStrokeColor(color: button.backgroundColor ?? UIColor.black)
    }


    let slider: UISlider = {
        let slider = UISlider()

        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(hanleSliderChange), for: .valueChanged)

        return slider
    }()
    
    @objc fileprivate func hanleSliderChange() {
        canvas.setStrokeWidth(width: slider.value)
    }

    
    override func loadView() {
        //        THIS METHOD DOES BELOW THINGS
        //        view.addSubview(canvas)
        //        canvas.frame = view.frame
        self.view = canvas
    }
    
    fileprivate func setUpLayout() {
        
        let colorsStackView = UIStackView(arrangedSubviews: [yellowButton, redButton, blueButton])
        colorsStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [undoButton, clearButton, colorsStackView, slider])
        
        stackView.spacing = 10
        
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        //        stackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
                stackView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.backgroundColor = UIColor.white
        
        setUpLayout()
    }
}

