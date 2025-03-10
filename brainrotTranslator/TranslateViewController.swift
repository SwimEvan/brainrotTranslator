//
//  TranslateViewController.swift
//  brainrotTranslator
//
//  Created by EVAN MEYER on 3/3/25.
//

import UIKit
import GoogleGenerativeAI

class viewFirst{
    static var translateDude = 0
}
class TranslateViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectedTranslator: UISegmentedControl!
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    let apiKey = "AIzaSyA2qZ4Bj89yqhVdL7gVbi2UFdeyZ7pTzKs"
    var prompt = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
            }
    override func viewDidAppear(_ animated: Bool) {
        if (viewFirst.translateDude == 0){
            instructionLabel.text = "This is the translate function! Enter a phrase above!"
            imageView.image = UIImage(named: "chickenNugget")
            viewFirst.translateDude = 1
            print(viewFirst.translateDude)
        }
        else{
            instructionLabel.text = ""
            imageView.isHidden = true        }
        

    }
    public func generateTextForPrompt(prompt:String) async -> String{
        let model = GenerativeModel(name: "gemini-2.0-flash-thinking-exp-01-21", apiKey: apiKey)
        do {
            let response: GenerateContentResponse!
            
            if(selectedTranslator.selectedSegmentIndex == 0){
                response = try await model.generateContent("Translate to brainrot: \(prompt). don't say anything else except for the translation.")
                
            }
            else{
                response = try await model.generateContent("Translate to proper english: \(prompt). don't say anything else except for the translation.")
             
            }
            if let text = response.text {
                return text
            } else {
                return "Empty"
            }
        } catch {
            print("Error generating content: \(error)")
            return "Error"
        }
    }
    
    @IBAction func generateButtonTapped(_ sender: UIButton) {
        guard let inputText = inputTextField.text, !inputText.isEmpty else {
            outputLabel.text = "Please enter a prompt."
            return
        }
        outputLabel.text = "loading..."
        prompt = inputText
        
        // Call the async function to generate text
        Task {
            let generatedText = await generateTextForPrompt(prompt: prompt)
            // Update the label with the generated text on the main thread
            DispatchQueue.main.async {
                self.outputLabel.text = generatedText
            }
        }
    }
}
