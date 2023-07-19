//
//  ContentView.swift
//  HTTP Requests
//
//  Created by Kaloyan Petkov on 18.07.23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var networkController = NetworkController()
    
    @State private var text: String = ""
    @State private var number: String = ""
    
    @State private var putText: String = ""
    @State private var putNumber: String = ""
    
    @State private var deleteProductID: Int = 1
    
    @FocusState private var textFieldFocused: Bool
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 50) {
                VStack(alignment: .leading) {
                    HeaderViewModel(title: "GET Method")
                    Text(self.networkController.responseData)
                        .foregroundColor(.gray)
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                        )
                        .focused($textFieldFocused)
                    Button {
                        textFieldFocused = false
                        self.networkController.performRequest(type: "GET", body: nil)
                    } label: {
                        Text("GET")
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .tint(.gray)
                    .padding(.top, 20)
                    
                }
                
                VStack(alignment: .leading) {
                    HeaderViewModel(title: "POST Method")
                    TextField("Text to post", text: $text)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .focused($textFieldFocused)
                    TextField("Number to post", text: $number)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .focused($textFieldFocused)
                    Button {
                        if self.text != "" && self.number != "" {
                            textFieldFocused = false
                            let body = self.networkController.getPostBody(title: self.text, price: Double(self.number)!)

                            self.networkController.performRequest(type: "POST", body: body)
                        }
                    } label: {
                        Text("POST")
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .padding(.top, 20)
                }
                
                VStack(alignment: .leading) {
                    HeaderViewModel(title: "PUT Method")
                    TextField("Change title", text: $putText)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .focused($textFieldFocused)
                    TextField("Change price", text: $putNumber)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .focused($textFieldFocused)
                    Button {
                        if self.text != "" && self.number != "" {
                            textFieldFocused = false
                            let body = self.networkController.getPostBody(title: self.putText, price: Double(self.putNumber)!)

                            self.networkController.performRequest(type: "PUT", body: body)
                        }
                    } label: {
                        Text("PUT")
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .tint(.yellow)
                    .padding(.top, 20)
                }
                
                VStack(alignment: .leading) {
                    HeaderViewModel(title: "DELETE Method")
                    Picker("Product ID", selection: $deleteProductID) {
                        ForEach(1...9, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    Button {
                        textFieldFocused = false
                        self.networkController.performRequest(type: "DELETE", body: nil, productID: $deleteProductID.wrappedValue)
                    } label: {
                        Text("OPTIONS")
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .padding(.top, 20)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
