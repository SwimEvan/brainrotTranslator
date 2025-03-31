//
//  LearnViewController.swift
//  brainrotTranslator
//
//  Created by EVAN MEYER on 3/4/25.
//

import UIKit
import GoogleGenerativeAI

class LearnDictionary {
    var name: String
    var definition: String
    
    init(name: String, definition: String) {
        self.name = name
        self.definition = definition
    }
}

class LearnViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tfOutlet: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let apiKey = "AIzaSyA2qZ4Bj89yqhVdL7gVbi2UFdeyZ7pTzKs"
    var prompt = ""
 var terms = [LearnDictionary]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        terms = [
            LearnDictionary(name: "sigma", definition: "The best of the best"),
            LearnDictionary(name: "alpha", definition: "The beginning, the leader"),
            LearnDictionary(name: "beta", definition: "A secondary leader or follower"),
            LearnDictionary(name: "cringe", definition: "Feeling embarrassment or discomfort"),
                   LearnDictionary(name: "pog", definition: "Expression of excitement or amazement"),
                    LearnDictionary(name: "yeet", definition: "To throw something with great force"),
                 LearnDictionary(name: "sus", definition: "Suspicious, often used to call out someone acting shady"),
                 LearnDictionary(name: "bet", definition: "Agreement, challenge, or confirmation"),
                  LearnDictionary(name: "drip", definition: "Cool or fashionable, especially referring to one's style"),
                  LearnDictionary(name: "vibes", definition: "The emotional atmosphere or feeling of a place or person"),
                   LearnDictionary(name: "ghosted", definition: "When someone suddenly cuts off communication without explanation"),
                   LearnDictionary(name: "simp", definition: "Someone who does too much for someone they like, often used humorously"),
                   LearnDictionary(name: "noob", definition: "A newcomer or beginner, often used in a teasing manner"),
                 LearnDictionary(name: "stan", definition: "To be an enthusiastic and supportive fan of someone or something"),
                   LearnDictionary(name: "lit", definition: "Awesome, exciting, or great"),
                   LearnDictionary(name: "flex", definition: "To show off or boast"),
                  LearnDictionary(name: "slay", definition: "To do something exceptionally well, or to look great doing it"),
                LearnDictionary(name: "clown", definition: "To act foolishly, or someone who acts in a silly manner"),
                 LearnDictionary(name: "cap", definition: "To lie or exaggerate about something"),
                   LearnDictionary(name: "no-cap", definition: "To speak honestly, without lying"),
                  LearnDictionary(name: "fam", definition: "Close friends or family members"),
                   LearnDictionary(name: "slaps", definition: "Referring to something that is really good, especially music"),
                   LearnDictionary(name: "bruh", definition: "An expression of disbelief or frustration"),
                  LearnDictionary(name: "riz", definition: "Charm or charisma, especially in flirting"),
                  LearnDictionary(name: "finna", definition: "A slang term meaning ‘about to’ or ‘going to’"),
                   LearnDictionary(name: "gucci", definition: "Cool, great, or good"),
                   LearnDictionary(name: "savage", definition: "Tough, rebellious, or cool in a fearless way"),
                 LearnDictionary(name: "boujee", definition: "A person who is high-class or acts superior"),
                   LearnDictionary(name: "clout", definition: "Influence or power, usually on social media"),
                   LearnDictionary(name: "lowkey", definition: "Something done quietly or subtly"),
                   LearnDictionary(name: "highkey", definition: "Something done openly or proudly"),
                   LearnDictionary(name: "deadass", definition: "To be serious or truthful about something"),
                   LearnDictionary(name: "periodt", definition: "An emphasized way of saying ‘period’, used to end a statement"),
                  LearnDictionary(name: "thicc", definition: "A playful term to describe a curvy body or something thick"),
                    LearnDictionary(name: "shade", definition: "Disrespect or subtle insult, usually indirect"),
                   LearnDictionary(name: "wig", definition: "Used when something is extremely surprising or amazing"),
                    LearnDictionary(name: "canceled", definition: "When someone or something is rejected or ostracized"),
                   LearnDictionary(name: "mood", definition: "A way of describing one's emotional state"),
                   LearnDictionary(name: "period", definition: "Used to end a statement, often for emphasis"),
                  LearnDictionary(name: "tea", definition: "Gossip or the latest news, often used to describe drama"),
                    LearnDictionary(name: "thirsty", definition: "Desperate for attention or validation, often romantically"),
                    LearnDictionary(name: "goat", definition: "Greatest of all time"),
                   LearnDictionary(name: "receipts", definition: "Proof or evidence, often used in gossiping"),
                   LearnDictionary(name: "baddie", definition: "A confident, attractive person"),
                  LearnDictionary(name: "clapping", definition: "The act of applauding or the sound of applause"),
                   LearnDictionary(name: "gas", definition: "To hype up or praise someone or something"),
                  LearnDictionary(name: "flexing", definition: "To show off one's abilities or possessions"),
                  LearnDictionary(name: "ghosting", definition: "The act of cutting someone off suddenly without explanation"),
                   LearnDictionary(name: "bff", definition: "Best friend forever"),
                   LearnDictionary(name: "fomo", definition: "Fear of missing out"),
                LearnDictionary(name: "woke", definition: "Being aware of social issues and injustices")
        ]

      
        tableView.dataSource = self
       
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let term = terms[indexPath.row]
        cell.textLabel!.text = term.name
        cell.detailTextLabel!.text = term.definition
        return cell
    }
    public func generateTextForPrompt(prompt:String) async -> String{
        let model = GenerativeModel(name: "gemini-2.0-flash-thinking-exp-01-21", apiKey: apiKey)
        do {
            let response: GenerateContentResponse!
            
           
            
           
                response = try await model.generateContent("Come up with an definition for this brainrot word: \(prompt). don't say anything else except for the translation.")
             
            
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
    
    @IBAction func searchAction(_ sender: UIButton) {
        
        prompt = tfOutlet.text!
        
        // Call the async function to generate text
        Task {
            let generatedText = await generateTextForPrompt(prompt: prompt)
            // Update the label with the generated text on the main thread
            DispatchQueue.main.async {
                self.terms.append(LearnDictionary(name: self.tfOutlet.text!, definition: generatedText))
                self.tableView.reloadData()
            }
        }

    }
    
}
