//
//  ViewController.swift
//  ShockExperiment
//
//  Created by Adil Hussain on 26/02/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loadingLabel: UILabel!
    
    private var getCharactersJob = GetCharactersJob()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCharacters()
    }
    
    private func loadCharacters() {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let getCharactersResponse = try self.getCharactersJob.getCharacters()
                
                DispatchQueue.main.async { self.onGetCharactersJobSucceeded(getCharactersResponse) }
            } catch {
                DispatchQueue.main.async { self.onGetCharactersJobFailed() }
            }
        }
    }
    
    private func onGetCharactersJobSucceeded(_ getCharactersResponse: GetCharactersResponse) {
        loadingLabel.text = "Got \(getCharactersResponse.count) characters."
    }
    
    private func onGetCharactersJobFailed() {
        loadingLabel.text = "Failed getting characters."
    }
}
