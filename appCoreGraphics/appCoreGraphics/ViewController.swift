//
//  ViewController.swift
//  appCoreGraphics
//
//  Created by Emiliano Cepeda on 02/12/24.
//

import UIKit

class ViewController: UIViewController {

    private let skyView = SkyView()
    private let characterImageView = UIImageView()
    private let stateLabel = UILabel()
    private var currentRageLevel: RageLevel = .happy

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateScene(for: currentRageLevel)
    }

    private func setupUI() {
        view.backgroundColor = .white

        // Configuración de SkyView
        skyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skyView)

        NSLayoutConstraint.activate([
            skyView.topAnchor.constraint(equalTo: view.topAnchor),
            skyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skyView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])

        // Configuración de UIImageView para el monito
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.contentMode = .scaleAspectFit
        view.addSubview(characterImageView)

        NSLayoutConstraint.activate([
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.topAnchor.constraint(equalTo: skyView.bottomAnchor, constant: 20),
            characterImageView.widthAnchor.constraint(equalToConstant: 150),
            characterImageView.heightAnchor.constraint(equalToConstant: 150)
        ])

        // Configuración de UILabel para el estado
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.textAlignment = .center
        stateLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.addSubview(stateLabel)

        NSLayoutConstraint.activate([
            stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stateLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 10)
        ])

        // Botón para cambiar de estado
        let changeStateButton = UIButton(type: .system)
        changeStateButton.translatesAutoresizingMaskIntoConstraints = false
        changeStateButton.setTitle("Cambiar Estado", for: .normal)
        changeStateButton.addTarget(self, action: #selector(changeStateTapped), for: .touchUpInside)
        view.addSubview(changeStateButton)

        NSLayoutConstraint.activate([
            changeStateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeStateButton.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 20)
        ])
    }

    @objc private func changeStateTapped() {
        // Cambiar al siguiente estado de ánimo
        if let nextRageLevel = RageLevel(rawValue: currentRageLevel.rawValue + 1) {
            currentRageLevel = nextRageLevel
        } else {
            currentRageLevel = .happy // Reiniciar al estado inicial
        }
        updateScene(for: currentRageLevel)
    }

    private func updateScene(for rageLevel: RageLevel) {
        // Actualizar SkyView
        skyView.setRageLevel(rageLevel)

        // Actualizar imagen del monito
        characterImageView.image = rageLevel.image

        // Actualizar texto del estado
        stateLabel.text = "Estado: \(rageLevel)"
    }
}
