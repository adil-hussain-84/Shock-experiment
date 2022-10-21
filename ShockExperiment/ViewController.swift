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
        
        Task(priority: .userInitiated) {
            do {
                let getCharactersResponse = try await self.getCharactersJob.getCharacters()
                
                self.onGetCharactersJobSucceeded(getCharactersResponse)
            } catch {
                self.onGetCharactersJobFailed()
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
