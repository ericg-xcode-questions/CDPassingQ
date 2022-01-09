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



struct NameViewer: View
{
  @Environment ( \.presentationMode) var presentationMode
  @Environment( \.managedObjectContext ) private var moc
  
  @State private var name:    String      = ""
  
  var body: some View
  {
    Form
    {
      Section( header: Text( "Information" ) )
      {
        TextField( "Name", text: $name )
      }
    }
    
    Spacer()
    
    Button()
    {
      if ( saveName() )
      {
        self.presentationMode.wrappedValue.dismiss()
      }
    }
    label:
    {
      Text( "Save" )
    }
  }
  
  
  
  private func saveName() -> Bool
  {
    let item = Item( context: moc )
    
    do
    {
      print( self.name )
      
      item.name = self.name

      try moc.save()
      
      return true
    }
    catch
    {
      print( error )
      print( error.localizedDescription )
    }
    
    self.moc.rollback();
    
    return false
  }
}



struct NameViewer_Previews: PreviewProvider
{
  static var previews: some View
  {
    NameViewer()
  }
}
