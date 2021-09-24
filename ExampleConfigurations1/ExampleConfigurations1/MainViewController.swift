//
//  MainViewController.swift
//  ExampleConfigurations1
//
//  Created by Eduard Calero on 19/9/21.
//

import UIKit

enum ExampleError: Error {
    case genericError
    case decodingError
}

final class MainViewController: UIViewController, HeaderConfiguratorProtocol {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonTthree: UIButton!
    
    #if DEBUG
    let endpoint =  URL(string: "https://callonedebug.free.beeceptor.com/")
    #else
    let endpoint =  URL(string: "https://calloneproduction.free.beeceptor.com/")
    #endif

    @IBAction func oneButtonTouchUpINside(_ sender: Any) {
        hacerPrimeraLlamada { [weak self] result in
            
            if case .success(let responseModel) = result {
                self?.mainLabel.text = responseModel.textResponse
            }
            
        }
        
    }
    
    @IBAction func twoButtonTouchUpInside(_ sender: Any) {
        hacerSegundaLlamada { [weak self] result in
            
            if case .success(let responseModel) = result {
                self?.mainLabel.text = responseModel.textResponse
            }
            
        }
    }
    
    @IBAction func threeButtonTouchUpInside(_ sender: Any) {
        hacerTerceraLlamada { [weak self] result in
            
            if case .success(let responseModel) = result {
                self?.mainLabel.text = responseModel.textResponse
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureNavigationBar()
    }

    
    fileprivate func hacerPrimeraLlamada( completion: ((Result<CallOneEndpointResponseModel, ExampleError>)->())? = nil ) {
        
    
        guard let url = endpoint else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                DispatchQueue.main.async {
                    completion?(.failure(.genericError))
                }
                return
            }
            
            if let responseModel = try? JSONDecoder().decode(CallOneEndpointResponseModel.self, from: data) {
                DispatchQueue.main.async {
                    completion?(.success(responseModel))
                }
                return
            }
            DispatchQueue.main.async {
                completion?(.failure(.decodingError))
            }
            return
        }
        
        dataTask.resume()
    }
    
    
    fileprivate func hacerSegundaLlamada(completion: ((Result<CallOneEndpointResponseModel, ExampleError>)->())? = nil ) {
        
        guard var url = endpoint else { return }
                  url.appendPathComponent("two")
        
        
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                DispatchQueue.main.async {
                    completion?(.failure(.genericError))
                }
                return
            }
            
            if let responseModel = try? JSONDecoder().decode(CallOneEndpointResponseModel.self, from: data) {
                DispatchQueue.main.async {
                    completion?(.success(responseModel))
                }
                return
            }
                DispatchQueue.main.async {
                    completion?(.failure(.decodingError))
                }
            return
        }
        
        dataTask.resume()
        
    }
    
    fileprivate func hacerTerceraLlamada( completion: ((Result<CallOneEndpointResponseModel, ExampleError>)->())? = nil ) {
        
        guard var url = endpoint else { return }
                  url.appendPathComponent("three")
        
        
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                DispatchQueue.main.async {
                    completion?(.failure(.genericError))
                }
                return
            }
            
            if let responseModel = try? JSONDecoder().decode(CallOneEndpointResponseModel.self, from: data) {
                DispatchQueue.main.async {
                    completion?(.success(responseModel))
                }
                return
            }
                DispatchQueue.main.async {
                    completion?(.failure(.decodingError))
                }
            return
        }
        
        dataTask.resume()
    }
   

}

struct CallOneEndpointResponseModel: Decodable {
    let textResponse: String?
}
