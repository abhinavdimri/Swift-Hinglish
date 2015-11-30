//
//  HindiModel.swift
//  Hinglish
//
//  Created by Abhinav Dimri on 23/11/15.
//  Copyright © 2015 Abhinav Dimri. All rights reserved.
//

import Foundation


class HindiController {
    
    
    //Hindi Model to convert hinglish words to hindi.
    
    let eModel = HinglishController()
    
    //dictionary containing vowels and their corresponding 'matra's'
    let hindiVarmala = ["अ":"s", "आ":"ा", "इ":"ि", "ई":"ी", "उ":"ु", "ऊ":"ू", "ऋ":"ृ", "ए": "े", "ऐ":"ै", "ओ":"ो", "औ":"औ"]
    
    func constructHindiWord(word:String)->(String,String){
        
        
        /*firstly This function takes the hinglish word as an input then breaks the word into array, for instance
        if input = "suraj" then it will turn into ["s","u","r","a","j"]. Afterwards each item in the array is converted into hindi letter, also the adjecent letter will be considered as tuple. If the letter in the array is "b" then next letter will be checked if it's a "h" then "भ" will be appended otherwise    "ब" will be appended to the suggestion array*/
        
        
        //this array will contain first suggestion
        var lowerCaseSuggestions = [String]()
        //this array will contain alternative suggestion
        var upperCaseSuggestions = [String]()
        
        //letters
        var firstLetter:String?
        var secondLetter:String?
        var thirdLetter:String?
        
        //loops
    
        let characterArray:[String?] = word.characters.map( {String($0)} )
        print("Printing characterArray \(characterArray), and the count is \(characterArray.count)")
        
        //count number of elements in the array.
        let count = characterArray.count
        var i = 0
        
        while (i<count){
            firstLetter = characterArray[i]
            //methods to find next letters, "a" vs "ah"
            secondLetter = getSecondLetter(characterArray, indexToFind: i+1, endIndex: count)
            thirdLetter = getThirdLetter(characterArray, indexToFind: i+2, endIndex: count)
            
        
            switch firstLetter!{
                
            case "a":
                    
                    if containsValue(secondLetter, letter: "a"){
                        print("add AA")
                        lowerCaseSuggestions.append("आ")
                        upperCaseSuggestions.append("आ")
                        ++i
                        break
                    }
                    
                    if containsValue(secondLetter, letter: "i"){
                        print("add AI")
                        lowerCaseSuggestions.append("ऐ")
                        upperCaseSuggestions.append("ऐ")
                        ++i
                        break
                    }
                    
                    if containsValue(secondLetter, letter: "u"){
                        print("add au")
                        lowerCaseSuggestions.append("औ")
                        upperCaseSuggestions.append("औ")
                        ++i
                        break
                    }
                    
                    if containsValue(secondLetter, letter: "s"){
                        print("add as")
                        lowerCaseSuggestions.append("स्स")
                        upperCaseSuggestions.append("स्स")
                        ++i
                        break
                    }
                    
                
                lowerCaseSuggestions.append("")
                upperCaseSuggestions.append("")
                 print("adding vanilla A")
                
            case "b":
                
                if containsValue(secondLetter, letter: "h"){
                    print("add BH")
                    lowerCaseSuggestions.append("भ")
                    upperCaseSuggestions.append("भ")
                    ++i
                    break
                }
                
                lowerCaseSuggestions.append("ब")
                upperCaseSuggestions.append("ब")
                print("Adding vanilla B")
                
                
            case "c":
                
                if containsValue(secondLetter, letter: "h"){
                    if containsValue(thirdLetter, letter: "h"){
                        print("add Chh")
                        lowerCaseSuggestions.append("छ")
                        upperCaseSuggestions.append("छ")
                        i+=2
                        break
                    }else{print("add CH")
                        lowerCaseSuggestions.append("च")
                        upperCaseSuggestions.append("च")
                        ++i
                        break
                    }
                }
                
                lowerCaseSuggestions.append("च")
                upperCaseSuggestions.append("च")
                print("Adding vanilla C")
                
                
            case "d":
                
                if containsValue(secondLetter, letter: "h"){
                    print("adding dh")
                    lowerCaseSuggestions.append("ढ")
                    upperCaseSuggestions.append("ध")
                    ++i
                    break
                }
               
                lowerCaseSuggestions.append("द")
                upperCaseSuggestions.append("ड")
                print("Adding vanilla D")
                
                
            case "D":
                if containsValue(secondLetter, letter: "h"){
                    print("adding DH")
                    ++i
                    break
                }
                print("add vanilla D Capital")
                
                
            case "e":
                print("add vanilla E")
                lowerCaseSuggestions.append("ए")
                upperCaseSuggestions.append("ए")
                
            case "f":
                print("adding fa")
                lowerCaseSuggestions.append("फ")
                upperCaseSuggestions.append("फ")
                
            case "g":
                
                if containsValue(secondLetter, letter: "h"){
                    print("adding GH")
                    lowerCaseSuggestions.append("घ")
                    upperCaseSuggestions.append("घ")
                    ++i
                    break
                }
                print("adding vanilla G")
                lowerCaseSuggestions.append("ग")
                upperCaseSuggestions.append("ग")
                
            case "h":
                print("adding vanilla H")
                lowerCaseSuggestions.append("ह")
                upperCaseSuggestions.append("ह")
                
            case "i": //add the matra if needed
                print("adding vanilla I")
                lowerCaseSuggestions.append("इ")
                upperCaseSuggestions.append("ई")
                
            case "I":
                print("adding capital vanilla I")
                
            case "j":
                
                if containsValue(secondLetter, letter: "h"){
                    if containsValue(thirdLetter, letter: "h" ){
                        print("adding JHH")
                        lowerCaseSuggestions.append("झ")
                        upperCaseSuggestions.append("झ")
                        i+=2
                        break
                    }
                }
                
                if containsValue(secondLetter, letter: "n"){
                    print("adding JN")
                    lowerCaseSuggestions.append("ज्ञ")
                    upperCaseSuggestions.append("ज्ञ")
                    ++i
                    break
                }
                
                print("adding vanilla J")
                lowerCaseSuggestions.append("ज")
                upperCaseSuggestions.append("ज")
                
            case "k":
                
                if containsValue(secondLetter, letter: "h"){
                    print("adding kh")
                    lowerCaseSuggestions.append("ख")
                    upperCaseSuggestions.append("ख")
                    ++i
                    break
                }
                
                if containsValue(secondLetter, letter: "s"){
                    if containsValue(thirdLetter, letter: "h"){
                        print("adding ksh")
                        lowerCaseSuggestions.append("क्ष")
                        upperCaseSuggestions.append("क्ष")
                        i+=2
                        break
                    }
                }
                
                if containsValue(secondLetter, letter: "k"){
                    lowerCaseSuggestions.append("क्क")
                    upperCaseSuggestions.append("क्क")
                    ++i
                    break
                }
                
                
                lowerCaseSuggestions.append("क")
                upperCaseSuggestions.append("क")
                print("adding vanilla K")
                
            case "l":
                
                if containsValue(secondLetter, letter: "l"){
                    lowerCaseSuggestions.append("ल्ल")
                    upperCaseSuggestions.append("ल्ल")
                    ++i
                    break
                }
                lowerCaseSuggestions.append("ल")
                upperCaseSuggestions.append("ल")
                print("adding vanilla L")
            case "m":
                lowerCaseSuggestions.append("म")
                upperCaseSuggestions.append("म")
                print("adding vanilla m")
                
            case "n":
                
                if containsValue(secondLetter, letter: "g"){
                    print("adding NG.")
                    lowerCaseSuggestions.append("ङ")
                    upperCaseSuggestions.append("ङ")
                    ++i
                    break
                }
                
                if containsValue(secondLetter, letter: "j"){
                    print("adding NJ")
                    lowerCaseSuggestions.append("ञ")
                    upperCaseSuggestions.append("ञ")
                    ++i
                    break
                }
                
                lowerCaseSuggestions.append("न")
                upperCaseSuggestions.append("न")
                print("adding vanilla N")
                
            case "N":
                upperCaseSuggestions.append("")
                print("Adding capital vanilla N")
                
            case "o":
                lowerCaseSuggestions.append("ओ")
                upperCaseSuggestions.append("ओ")
                print("adding vanilla O")
                
            case "p":
                
                //TODO: add halant sound for word "pappu"
                
                if containsValue(secondLetter, letter: "h"){
                    print("adding PH")
                    lowerCaseSuggestions.append("फ")
                    upperCaseSuggestions.append("फ")
                    ++i
                    break
                }
                lowerCaseSuggestions.append("प")
                upperCaseSuggestions.append("प")
                print("adding vanilla P")
                
            case "r":
                if containsValue(secondLetter, letter: "r"){
                    if containsValue(thirdLetter, letter: "i"){
                        print("adding RRI")
                        lowerCaseSuggestions.append("ऋ")
                        upperCaseSuggestions.append("ऋ")
                        i+=2
                        break
                    }
                }
                
                print("adding vanilla R")
                lowerCaseSuggestions.append("र")
                upperCaseSuggestions.append("र")
                
                
            case "s":
                if containsValue(secondLetter, letter: "h"){
                    print("adding SH")
                    lowerCaseSuggestions.append("ष")
                    upperCaseSuggestions.append("ष")
                    ++i
                    break
                }
                
                if containsValue(secondLetter, letter: "s"){
                    if containsValue(thirdLetter, letter: "h"){
                        print("adding SSH")
                        lowerCaseSuggestions.append("श")
                        upperCaseSuggestions.append("श")
                        i+=2
                        break
                    }
                }
                
                print("adding S")
                lowerCaseSuggestions.append("स")
                upperCaseSuggestions.append("स")
                
            case "t":
                
                if containsValue(secondLetter, letter: "h"){
                    if containsValue(thirdLetter, letter: "h"){
                        print("adding THH")
                        lowerCaseSuggestions.append("ठ")
                        upperCaseSuggestions.append("ठ")
                        i+=2
                        break
                    }else{print("adding TH")
                        lowerCaseSuggestions.append("ट")
                        upperCaseSuggestions.append("थ")
                        i++
                        break
                    }
                }
                
                if containsValue(secondLetter, letter: "r"){
                    print("adding TR")
                    lowerCaseSuggestions.append("त्र")
                    upperCaseSuggestions.append("त्र")
                    ++i
                    break
                }
                //त
                lowerCaseSuggestions.append("त")
                upperCaseSuggestions.append("ट")
                print("adding vanilla T")
                
            case "T":
                
                if containsValue(secondLetter, letter: "h"){
                    upperCaseSuggestions.append("")
                    print("adding capital TH")
                    ++i
                    break
                }
                upperCaseSuggestions.append("")
                print("adding vanilla capital T")
                
                
            case "u":
                lowerCaseSuggestions.append("उ")
                upperCaseSuggestions.append("ऊ")
                print("adding vanilla u")
                
            case "v":
                lowerCaseSuggestions.append("व")
                upperCaseSuggestions.append("व")
                print("adding vanilla V")
                
            case "y":
                lowerCaseSuggestions.append("य")
                upperCaseSuggestions.append("य")
                print("adding vanilla Y")
            case "w":
                lowerCaseSuggestions.append("व")
                upperCaseSuggestions.append("व")
                
            case " ":
                lowerCaseSuggestions.append(" ")
                upperCaseSuggestions.append(" ")
                
                
            default:
                break
            }
        
            //the letters get flushed.
            flushString(firstLetter)
            flushString(secondLetter)
            flushString(thirdLetter)
           
            //increments the value of the index i
            i++
        
        }
    
        print("Lower Case: \(lowerCaseSuggestions), and Uppercase: \(upperCaseSuggestions)")
        
        //joins the array, into a word.
        let lowerCase = lowerCaseSuggestions.joinWithSeparator("")
        let upperCase = upperCaseSuggestions.joinWithSeparator("")

        //eModel is instance of class hinglishController, the method replacevowels replaces the vowels.
        return (eModel.ReplaceVowels(lowerCase, vowelsDictionary: self.hindiVarmala), eModel.ReplaceVowels(upperCase, vowelsDictionary: self.hindiVarmala))
    }
    
    
    
    //function returns letter at i+1 index, if possible.
    
    func getSecondLetter(word:[String?], indexToFind: Int, endIndex:Int)->String?{
        
        var secondLetter:String?
        
        if indexToFind < endIndex{
            secondLetter = word[indexToFind]
            return secondLetter
        }
        
        return secondLetter

    }
    
    //function returns letter at i+2 index, if possible.
    
    func getThirdLetter(word:[String?], indexToFind: Int, endIndex:Int)->String?{
        
        var thirdLetter:String?
        
        if indexToFind < endIndex{
            thirdLetter = word[indexToFind]
        }
        return thirdLetter
    }
    
    //flush
    
    func flushString(var stringToFlush:String?){
        
        stringToFlush = nil
        
    }
    
    //checks if the string contains the specified value. 
    func containsValue(checkString: String?, letter: String)->Bool{
        if let nextLetter = checkString{
            if nextLetter == letter{
                return true
            }
        }
            return false
    }
    
    
    
    
    
    
}

    