//
//  ViewController.swift
//  ShockExperiment
//
//  Created by Adil Hussain on 26/02/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    private var getCharactersJob = GetCharactersJob()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = ""
    }
    
    @IBAction func onFetchCharactersButtonTapped(_ sender: Any) {
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        statusLabel.text = "Fetching characters..."
        
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
        statusLabel.text = "Got \(getCharactersResponse.count) characters."
    }
    
    private func onGetCharactersJobFailed() {
        statusLabel.text = "Failed getting characters."
    }
}
