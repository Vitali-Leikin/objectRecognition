//
//  ManagerModel.swift
//  SeaFoodML
//
//  Created by vitali on 12.07.2023.
//

import UIKit
import CoreML
import Vision

class ManagerModel{
    
    //MARK: - Variable
    static let shared = ManagerModel()
    private init(){}

    //MARK: - Func
    
    func detect(image: CIImage) -> (id: String, confidence: String){
        var res = (id: "Take Photo",  confidence: "0.0")
        //first way create a model
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{fatalError("Loading CoreML error")}
        
        //second way create a model
      //  let config = MLModelConfiguration()
        //Inceptionv3
    //    guard let coreMLModel = try? ImageClassifier(configuration: config),
      //        let model = try? VNCoreMLModel(for: coreMLModel.model)else{fatalError("Loading CoreML error")}
        
        //
        
        let request = VNCoreMLRequest(model: model){ requ, error in
            guard let results = requ.results as? [VNClassificationObservation] else{
                fatalError("qqqq")
            }
            // get all result
//            print("--------------------------------")
//            print(results.first?.identifier)
//            print(results.first?.confidence)
//            print("--------------------------------")
//            print(results)
           // print(results.first!.identifier.filter{ "," })
            
            // get the most suitable result
            
            if let firstResult = results.first{
//                if firstResult.identifier.contains("hotdog"){
//                    self.navigationItem.title = "HOTDOG"
//                }else{
                    if let superkey = firstResult.identifier.components(separatedBy: ",").first{
                     //   self.navigationItem.title = "\(superkey)"
                        res.id = superkey
                        res.confidence = String(format: "%.f2", firstResult.confidence * 10)
                    }
               
             //   }
                
            }
        }
        let handler = VNImageRequestHandler(ciImage:  image)
        do {
            try handler.perform([request])
        } catch {
            print("error", error.localizedDescription)
        }
        return res
    }
}
