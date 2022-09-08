//
//  Codec.swift
//  Simple Encryption
//
//  Created by Nick on 2022-09-08.
//

import Foundation
import SwiftUI

struct Codec {
    let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

    @Binding var input: String
    @Binding var output: String
    @Binding var key: String
    var filteredInput: String { input.stripped.lowercased() }
    var filteredKey: String { key.stripped.lowercased() }

    var keyid: [Int] {
        var ids = [Int]()
        
        for letter in filteredKey {
            ids.append(alphabet.firstIndex(of: String(letter))!)
        }
        
        return ids
    }

    var letterid: [Int] {
        var ids = [Int]()
        
        for letter in filteredInput {
            ids.append(alphabet.firstIndex(of: String(letter))!)
        }
        
        return ids
    }
    
    func crypt(decrypt: Bool) {
        var keyidLocation = 0
        var letteridLocation = 0

        // Reset output
        output = ""
        // Repeats for the length of input
        for _ in 0..<filteredInput.count {
            // Encrypt the string
            output += alphabet[wrapArray(decrypt ?
                                         (letterid[letteridLocation] - keyid[keyidLocation]) :
                                         (letterid[letteridLocation] + keyid[keyidLocation]))]
            // Reset the keyidLocation if it's the last element of the array, otherwise add 1
            (keyidLocation == keyid.count - 1) ? (keyidLocation = 0) : (keyidLocation += 1)
            (letteridLocation == letterid.count - 1) ? (letteridLocation = 0) : (letteridLocation += 1)
        }
    }

    func wrapArray(_ index: Int) -> Int {
        var arrayPosition = 0
        
        // If number entered is smaller than the alphabet, return the number and exit
        if index < alphabet.count - 1 { return index }

        for i in 0..<index {
            // If current position in the array is the index, exit out of the loop
            if i == index {
                break
            }
            
            // If the current position is the last index in the array, reset the index.
            if arrayPosition == alphabet.count - 1 {
                arrayPosition = 0
            } else {
                arrayPosition += 1
            }
        }
        
        return arrayPosition
    }
}
