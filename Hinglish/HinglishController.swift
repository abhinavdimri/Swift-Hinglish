//
//  HinglishModel.swift
//  Hinglish
//
//  Created by Abhinav Dimri on 22/11/15.
//  Copyright © 2015 Abhinav Dimri. All rights reserved.
//

import Foundation

class HinglishController {
    
    var englishModel = EnglishModel()
    
    var translatedWord:String = ""
    
    //mapping english words to hindi equalvant.
    var HinglishMap = ["A": "","AA": "आ","AH": "अ","AE": "ए","AO": "औ","AW": "औ","AY": "ऐ","B": "ब","CH": "च","D": "ड","DH": "द","EA": "ई","EH": "ऐ","ER": "अर","EY": "एय","F": "फ","G": "ग","HH": "ह","IH": "इ","IY": "ई","J": "ज","JH": "झ","K": "क","L": "ल","M": "म","N": "न","NG": "ङ","OW": "ओ","P": "प","R": "र","S": "स","SH": "ष","T": "ट","TH": "त","Y":  "य","UW": "ऊ","UH": "उ","W": "व","V": "भ","Z": "ज़","ZH": "श",]
    
    var replaceVowels = ["अ":"", "आ":"ा", "इ":"ि", "ई":"ी", "उ":"ु", "ऊ":"ू", "ऋ":"ृ", "ए": "े", "ऐ":"ै", "ओ":"ो", "औ":"ौ", "ङ":"न्"]
    
    var replaceHindiVowels = []
    
    //searches for word in the English Model
    func searchModelForWord(word:String)->Bool{
        //swift 2.1 feature.
        guard let wordFound = englishModel.myModel[word] else {return false}
        var mappedHindiWord:String = ""
        for words in wordFound{
            let hindiWord = HinglishMap[words]
            mappedHindiWord = mappedHindiWord + hindiWord!
        }
        
            if mappedHindiWord != "" {
                ReplaceVowels(mappedHindiWord, vowelsDictionary: replaceVowels)
                print("Final Word is: \(mappedHindiWord)")
            }
        
        return true
    }
    
    //if the word is not found in the model, this method converts english word into hindi word using the mapping dictionary.
    func transliterate(word: String)->String{
        
        //local variables
        var firstLetter:String!
        var secondLetter:String?
        
        //translted string is the hindi word
        var hindiTranslatedWord = [String]()
        let secondTranslatedWord = [String]()
        
        
        //swifty way to map each letter to an array. "Hello" becomes "H", "e", "l", "l", "o"
        let characterArray = word.characters.map( {String($0)} )
        print("Printing characterArray \(characterArray), and the count is \(characterArray.count)")

            //count number of elements in the array.
            let count = characterArray.count
            var i = 0
        
        while (i<count){
            
            firstLetter = characterArray[i]
            
            if i < count-1{
                secondLetter = characterArray[i+1]
            }
            
            print("The second letter is \(secondLetter)")
            guard let nextLetter = secondLetter else {
                return "Not found"
            }
            if HinglishMap.keys.contains(firstLetter + nextLetter) && nextLetter != ""{
                hindiTranslatedWord.append(HinglishMap[firstLetter + nextLetter]!)
            }else if HinglishMap.keys.contains(firstLetter) {
                hindiTranslatedWord.append(HinglishMap[firstLetter]!)
            }else {
                print("Not found?")
            }
            
           
            
            //reset the first and the secondLetters
            firstLetter = ""
            secondLetter = ""
            //increment the counter
            i++
        }
        
        let stringToTranslate = hindiTranslatedWord.joinWithSeparator("")
        let translatedW = ReplaceVowels(stringToTranslate, vowelsDictionary: replaceVowels)
        let secondTranslation = secondTranslatedWord.joinWithSeparator("")
        print(secondTranslation)
        return translatedW
    }
    
    //replaces the vowels in the word.
    
    func ReplaceVowels(var mappedHindiWord:String, vowelsDictionary:[String:String])->String{
       
        //extracting dictionary keys are an array value
        let arrayReprentation = vowelsDictionary.keys
        
        //getting the first character
        let index = mappedHindiWord.startIndex
        if let firstChar:Character = mappedHindiWord[index]{
        print(firstChar)
        
        //check if string contains vowels
        for key in arrayReprentation{
            if mappedHindiWord.containsString(key){
                if letterChanged && firstChar == "आ" || firstChar == "औ"{
                    letterChanged = false
                }else {
                    mappedHindiWord = mappedHindiWord.stringByReplacingOccurrencesOfString(key, withString: replaceVowels[key]!)
                }
                
            }else{
                translatedWord = mappedHindiWord
                }
            }
        
            print("The translated word is \(translatedWord)")
            return translatedWord
        
        }
    }
    
}