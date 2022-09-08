//
//  ContentView.swift
//  Simple Encryption
//
//  Created by Nick on 2022-09-07.
//

import SwiftUI

extension String {
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        return self.filter { okayChars.contains($0) }
    }
}

struct ContentView: View {
    @State var input: String = ""
    @State var output: String = ""
    @State var key: String = ""

    var body: some View {
        let codec = Codec(input: $input, output: $output, key: $key)

        VStack {
            Text("Cearser Cypher")
                .font(.title)
            
            TextField("Text to encrypt/decrypt", text: $input)
            TextField("Encryption Key", text: $key)
            
            HStack {
                Button("Encrypt") {
                    codec.crypt(decrypt: false)
                }
                Button("Decrypt") {
                    codec.crypt(decrypt: true)
                }
            }
            
            Text(output)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
