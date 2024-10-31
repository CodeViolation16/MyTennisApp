//
//  anotherTest.swift
//  MyTennisApp
//
//  Created by Khanh Nguyen on 10/31/24.
//

import SwiftUI

struct anotherTest: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
struct modal: View {
	 @State var names: [String] = []
	 @State var name: String = ""
	 var body: some View {

			TextField("ARRAY", text: $name)

	 }
}
#Preview {
    anotherTest()
}
