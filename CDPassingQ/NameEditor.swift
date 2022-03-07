//
//  NameEditor.swift
//  CDPassingQ
//
//  Created by ericg on 3/6/22.
//

import SwiftUI

struct NameEditor: View {
  @Environment(\.dismiss)              private var dismiss
  @Environment(\.managedObjectContext) private var childContext
  
  @ObservedObject var item: Item
  
  @State private var reason: TrustReason = .unknown
  
  var body: some View {
    Form {
      Section(header: Text("Information")) {
        if let name = Binding($item.name) {
          TextField("Name", text: name)
        }
      }
      
      Section( header: Text( "Trust" ) ) {
        Picker( "Reason", selection: $reason ) {
          ForEach( TrustReason.allCases ) { trustReason in
            Text( trustReason.title ).tag( trustReason )
          }
        }
      }
    }
    .toolbar {
      Button() {
        try? childContext.save()
        dismiss()
      } label: {
        Text("Save")
      }
    }
  }
}

//struct NameEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        NameEditor( )
//    }
//}
