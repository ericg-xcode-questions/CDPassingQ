//
//  NameViewer.swift
//  CDPassingQ
//
//  Created by ericg on 1/9/22.
//
//
//  CompanyView.swift
//  ProductTracker
//
//  Created by ericg on 11/15/21.
//

import SwiftUI
import CoreData

struct NameViewer: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var itemUpdateOperation: UpdateOperation<Item>?
    
    @ObservedObject var item: Item
    
    var body: some View {
        Form {
            Section {
                Text(item.name ?? "")
            }
        }
        .navigationTitle("Item")
        .toolbar  {
            Button("Update") {
                itemUpdateOperation = UpdateOperation(withExistingObject: item, in: viewContext)
            }
        }
        .sheet(item: $itemUpdateOperation) { updateOperation in
            NavigationView {
                NameEditor(item: updateOperation.childObject)
                    .navigationTitle("Update Item")
            }
            .environment(\.managedObjectContext, updateOperation.childContext)
        }
    }
}



//struct NameViewer_Previews: PreviewProvider {
//    static var previews: some View {
//        NameViewer()
//    }
//}
