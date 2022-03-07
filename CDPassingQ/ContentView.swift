//
//  ContentView.swift
//  CDPassingQ
//
//  Created by ericg on 1/9/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest( sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)], animation: .default )
  private var items: FetchedResults<Item>
  
  @State private var itemCreateOperation: CreateOperation<Item>?
  
  var body: some View {
    NavigationView {
      List {
        ForEach(items) { item in
          NavigationLink {
            NameViewer(item: item)
          } label: {
            Text(item.name ?? "")
          }
        }
      }
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          EditButton()
          
          Button(action: {
            itemCreateOperation = CreateOperation(with: viewContext)
          }) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
      .sheet(item: $itemCreateOperation) { createOperation in
        NavigationView {
          NameEditor(item: createOperation.childObject)
            .navigationTitle("New Item")
        }
        .environment(\.managedObjectContext, createOperation.childContext)
      }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
