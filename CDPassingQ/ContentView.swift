//
//  ContentView.swift
//  CDPassingQ
//
//  Created by ericg on 1/9/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment( \.managedObjectContext ) private var viewContext
  
  @FetchRequest( sortDescriptors: [ NSSortDescriptor( keyPath: \Item.name, ascending: true ) ],
                 animation:       .default )
  
  private var items: FetchedResults<Item>
  
  var body: some View
  {
    NavigationView
    {
      List
      {
        ForEach( items )
        {
          item in
            NavigationLink
            {
              NameViewer()
            }
            label:
            {
              Text( item.name! )
            }
        }
        .onDelete( perform: deleteItems )
      }
      .toolbar
      {
        ToolbarItem( placement: .navigationBarTrailing )
        {
          EditButton()
        }
        
        ToolbarItem
        {
          Button()
          {
            print( "Add Item" )
          }
          label:
          {
            NavigationLink
            {
              NameViewer();
            }
            label:
            {
              Label( "Add Item", systemImage: "plus" )
            }
          }
        }
      }  
    }
  }
  
  
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)
      
      do {
        try viewContext.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
